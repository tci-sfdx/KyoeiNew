@RestResource(urlMapping='/GetAccountInfo')
global without Sharing class GetAccountInfoRest{
    @HttpPost
    global static void processIncomingData() {
        // Retrieve POST data
        RestRequest req = RestContext.request;
        String reqString = req.requestBody.toString();
        //
        RestResponse res = RestContext.response;
        res.statusCode = 200;
        res.addHeader('Content-Type', 'application/json');

        //If POST data is blank, redirect immediately
        if (reqString == null || String.isBlank(reqString)) {
            return ;
        }
        Request params = (Request) System.JSON.deserialize(reqString, Request.class);
        System.debug(params);
        if(String.isBlank(params.gyoumu_id)){
            //エラー
            return ;
        }
        Contract_Information__c contract = new Contract_Information__c();
        String gyoumu_Id = params.gyoumu_Id;
        String eigyotenCD =  params.shokanten_Cd;
        eigyotenCD = eigyotenCD.replaceAll('-', '');
        Case c =null;
        if(gyoumu_Id.left(3) == '500'){
            c = new Case(Id = gyoumu_Id);
            c.PolicyNumber__c = params.shoken_No;//証券番号
            //c.StockNumberMainNumber__c = params.shoken_No;//証券番号親番
            if(params.shoken_No.length() == 17){
                c.PolicyNumber__c = params.shoken_No.left(12);//証券番号
                c.StockNumberMainNumber__c = params.shoken_No.left(12);//証券番号親番
                c.SecuritiesBranch__c = params.shoken_No.right(5);//証券番号枝番

            }else if(params.shoken_No.length() == 15){
                c.PolicyNumber__c = params.shoken_No.left(10);//証券番号
                c.StockNumberMainNumber__c = params.shoken_No.left(10);//証券番号親番
                c.SecuritiesBranch__c = params.shoken_No.right(5);//証券番号枝番
            }else{
                c.PolicyNumber__c = params.shoken_No;//証券番号
                c.StockNumberMainNumber__c = params.shoken_No;//証券番号親番

            }
            if(String.isNotBlank(params.hkn_Shiki)){
                c.CommencementOfInsurance__c = 
                    Date.newInstance(Integer.valueOf(params.hkn_Shiki.left(4)),Integer.valueOf(params.hkn_Shiki.mid(4, 2)),Integer.valueOf(params.hkn_Shiki.right(2)));//保険始期
            }else{
                c.CommencementOfInsurance__c = null;
            }
            
            if(String.isNotBlank(params.hkn_Shuki)){
                if(params.hkn_Shuki == '00000000'){
                
                    c.EndInsurance__c = null;
                }else{
                    c.EndInsurance__c = 
                        Date.newInstance(Integer.valueOf(params.hkn_Shuki.left(4)),Integer.valueOf(params.hkn_Shuki.mid(4, 2)),Integer.valueOf(params.hkn_Shuki.right(2)));//保険終期
                }
            }else{
                c.EndInsurance__c = null;
            }
            c.ContractorName__c = params.keiyakusha_Knj;//契約者名
            c.ContractorName_Kana__c = params.keiyakusha_Kana;//契約者名カナ
            c.ContractorPhoneNumber__c = params.keiyakusha_Tel;//契約者電話番号
            c.PostCode__c = params.keiyakusha_Yubin_No.replaceAll('-', '');//郵便番号
            c.PolicyholderZipCode__c = params.keiyakusha_Yubin_No.replaceAll('-', '');//郵便番号
            c.ContractorAddress__c = params.keiyakusha_Jusho_Knj;//契約者住所
            //c.AgencyCode__c = params.dairiten_Cd;//代理店コード
            List<Account> dairitens = [select id,Name from Account Where CounterpartyCode__c = :params.dairiten_Cd];
            if(!dairitens.isEmpty()){
                c.ReferenceAccount__c =dairitens.get(0).Id;
                c.AgencyName__c = dairitens.get(0).Name;
            }
            String eigyoCode = eigyotenCD.replaceAll('-', '');//所管店コード

            List<Account> eigyotens = [select id from Account Where JurisdictionalStoreCode__c = :eigyoCode];
            if(!eigyotens.isEmpty()) c.OfficeName__c =eigyotens.get(0).Id;

            c.HasSpecialOrder__c = String.isBlank(params.tsuhan_Umu)? false : true;  //通販特約有無
            c.GroupCode__c = params.shudan_Cd;//集団コード
            
            //List<GroupCode__c> groupCodes = [select id,Name from GroupCode__c Where Name = :params.shudan_Cd];
            //if(!groupCodes.isEmpty()) c.GroupGroupName__c =groupCodes.get(0).Id;
            
            c.GroupGroupName__c = params.shudan_Name;//集団名
            
            c.HasAccident__c = String.isBlank(params.jiko_Umu)? false : true;//事故有無
            c.FukokuCode__c = params.soshiki_Cd;//富国生命 組織コード
            c.TypeOfInsurance__c = params.hkn_Shurui;//保険種目
            c.InsuranceFee__c = String.isBlank(params.gokei_HknRyo) ? 0 : Decimal.valueOf(params.gokei_HknRyo.replaceAll(',',''));  //合計保険料
            
            if(String.isNotBlank(params.keiyakusha_Birth)){
                c.ContractorBirthday__c =
                    Date.newInstance(Integer.valueOf(params.keiyakusha_Birth.left(4)),Integer.valueOf(params.keiyakusha_Birth.mid(4, 2)),Integer.valueOf(params.keiyakusha_Birth.right(2)));//契約者生年月日
            }else{
                c.ContractorBirthday__c = null;
            }
            c.ContractorAge__c = String.isBlank(params.keiyakusha_Nenrei) ? 0 : Decimal.valueOf(params.keiyakusha_Nenrei);//契約者年齢
            c.ContractorSex__c = params.keiyakusha_Seibetsu;//契約者性別
            c.RelatedBranchCode__c = params.shisha_Cd;//相対支社コード
            c.CifCode__c = params.cif_Cd;//CIFコード
            c.ContactInfo__c = params.renrakusaki;//事務上連絡先
            c.PaymentMethod__c = params.haraikomi;//払込方法
            c.Policyholder_SAddressInKana__c = params.keiyakusha_Jusho_Kana;//住所カナ

            //レコードタイプ取得
            List<Case> cases = [SELECT RecordTypeId FROM Case WHERE Id =:params.gyoumu_Id];
            List<RecordType> RecordTypes = [SELECT DeveloperName FROM RecordType WHERE Id =:cases[0].RecordTypeId];
            
            //レコードタイプ：火新異動の場合
            if (RecordTypes[0].DeveloperName == 'Fire') {
                for (Fire_InsuranceItem2__mdt FireIns2 : [SELECT MasterLabel, InsuranceItem1__c FROM Fire_InsuranceItem2__mdt WHERE MasterLabel =:params.hkn_Shurui]){
                    c.InsuranceItem_1__c = FireIns2.InsuranceItem1__c; //保険種目１
                    c.InsuranceItem_2__c = FireIns2.MasterLabel; //保険種目２
                }
            }

            //レコードタイプ：自動継続停止の場合
            if (RecordTypes[0].DeveloperName == 'Auto_ContinuationStop') {
                if ((params.shoken_No.length() == 12 || params.shoken_No.length() == 17) && params.hkn_Shurui == '標準傷害保険') {
                    if (params.shudan_Cd.left(3) == '862') {
                        c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                        c.InsuranceItem_2__c = '窓販シニア*'; //保険種目２

                    } else if (params.shudan_Cd.left(3) == '863'){
                        c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                        c.InsuranceItem_2__c = 'JAシニア／安心倶楽部*'; //保険種目２

                    } else if (params.shudan_Cd.left(3) == '864') {
                        c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                        c.InsuranceItem_2__c = 'しんきんシニア*'; //保険種目２
                    }

                } else if ((params.shoken_No.length() == 12 || params.shoken_No.length() == 17) && params.hkn_Shurui == '普通傷害保険') {
                    c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                    c.InsuranceItem_2__c = '窓販シニア*'; //保険種目２

                } else if ((params.shoken_No.length() == 12 || params.shoken_No.length() == 17) && params.hkn_Shurui == '安心生活総合（普傷）') {
                    c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                    c.InsuranceItem_2__c = 'しんきんシニア*'; //保険種目２

                } else if ((params.shoken_No.length() == 12 || params.shoken_No.length() == 17) && params.hkn_Shurui == 'こども総合保険') {
                    c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                    c.InsuranceItem_2__c = 'まごネット*'; //保険種目２
                
                } else if ((params.shoken_No.length() == 12 || params.shoken_No.length() == 17) && params.hkn_Shurui == '交通事故傷害保険') {
                    c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                    c.InsuranceItem_2__c = 'JA自転車倶楽部*'; //保険種目２

                } else if (params.shoken_No.length() == 10 && params.hkn_Shurui == '普通傷害保険') {
                    c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                    c.InsuranceItem_2__c = 'しんきんフルタイム24*'; //保険種目２

                } else if (params.shoken_No.length() == 10 && params.hkn_Shurui == '標準傷害保険') {
                    if (params.shudan_Cd =='7701000') {
                        c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                        c.InsuranceItem_2__c = 'しんくみ標準傷害*'; //保険種目２
                    } else {
                        c.InsuranceItem_1__c = 'S傷害（改定DM専用）'; //保険種目１
                        c.InsuranceItem_2__c = 'しんきん標準傷害*'; //保険種目２
                    }
                }
            }

            update c;

        }
        if(gyoumu_Id.left(3) == '001'){
            //personAccount
            Account acc = new Account(Id = gyoumu_Id);
            System.debug('shoken_No:' +params.shoken_No);
            if(params.shoken_No.length() == 17){
                acc.PolicyNumber__pc = params.shoken_No.left(12);//証券番号
                acc.SecurityNumberParentNumber__pc = params.shoken_No.left(12);//証券番号親番
                acc.SecurityNumberBranchNumber__pc = params.shoken_No.right(5);//証券番号枝番

            }else if(params.shoken_No.length() == 15){
                acc.PolicyNumber__pc = params.shoken_No.left(10);//証券番号
                acc.SecurityNumberParentNumber__pc = params.shoken_No.left(10);//証券番号親番
                acc.SecurityNumberBranchNumber__pc = params.shoken_No.right(5);//証券番号枝番
            }else{
                acc.PolicyNumber__pc = params.shoken_No;//証券番号
                acc.SecurityNumberParentNumber__pc = params.shoken_No;//証券番号親番

            }
            System.debug('hkn_Shiki:' +params.hkn_Shiki);
            if(String.isNotBlank(params.hkn_Shiki)){
                acc.CommencementInsurance__pc = 
                    Date.newInstance(Integer.valueOf(params.hkn_Shiki.left(4)),Integer.valueOf(params.hkn_Shiki.mid(4, 2)),Integer.valueOf(params.hkn_Shiki.right(2)));//保険始期
            }else{
                acc.CommencementInsurance__pc = null;
            }
            
            System.debug('hkn_Shuki:' +params.hkn_Shuki);
            if(String.isNotBlank(params.hkn_Shuki)){
                if(params.hkn_Shuki == '00000000'){
                
                    acc.TermOfInsurance__pc = null;
                }else{
                    acc.TermOfInsurance__pc = 
                        Date.newInstance(Integer.valueOf(params.hkn_Shuki.left(4)),Integer.valueOf(params.hkn_Shuki.mid(4, 2)),Integer.valueOf(params.hkn_Shuki.right(2)));//保険終期
                }
            }else{
                acc.TermOfInsurance__pc = null;
            }
            if(String.isNotBlank(params.hkn_Shiki) && String.isNotBlank(params.hkn_Shuki)){
                acc.PeriodOfInsurance__pc = 
                (acc.TermOfInsurance__pc.year() - acc.CommencementInsurance__pc.year()) *12
                +(acc.TermOfInsurance__pc.month() - acc.CommencementInsurance__pc.month());
            }
            System.debug('keiyakusha_Knj:' +params.keiyakusha_Knj);
            acc.PolicyholderName__pc = params.keiyakusha_Knj;//契約者名
            System.debug('keiyakusha_Kana:' +params.keiyakusha_Kana);
            acc.PolicyholderName_Kana__pc = params.keiyakusha_Kana;//契約者名カナ
            System.debug('keiyakusha_Tel:' +params.keiyakusha_Tel);
            acc.PolicyholderTEL__pc = params.keiyakusha_Tel;//契約者電話番号
            System.debug('keiyakusha_Yubin_No:' +params.keiyakusha_Yubin_No);
            acc.PostalCode__pc = params.keiyakusha_Yubin_No.replaceAll('-', '');//郵便番号
            System.debug('keiyakusha_Jusho_Knj:' +params.keiyakusha_Jusho_Knj);
            acc.Address__pc = params.keiyakusha_Jusho_Knj;//契約者住所
            String stateMatcher = '^(.{2}[都道府県]|.{3}県)';
            Pattern statePattern = Pattern.compile(stateMatcher);
            List<String> states = statePattern.split(params.keiyakusha_Jusho_Knj);
            if(states.size() > 1){
                acc.Address__pc = states.get(1);//契約者住所
                acc.State_Province__pc = params.keiyakusha_Jusho_Knj.left(params.keiyakusha_Jusho_Knj.length() - states.get(1).length());
            }else{
                acc.Address__pc = params.keiyakusha_Jusho_Knj;//契約者住所
            }


            System.debug('dairiten_Cd:' +params.dairiten_Cd);
            acc.AgencyCode__pc = params.dairiten_Cd;//代理店コード
            List<Account> dairitens = [select id,CounterpartyName_Kana__c from Account Where CounterpartyCode__c = :params.dairiten_Cd];
            if(!dairitens.isEmpty()){
                acc.AgencyName__pc = dairitens.get(0).Id;
                acc.AgencyKana__pc = dairitens.get(0).CounterpartyName_Kana__c;
            }
            System.debug('shokanten_Cd:' +eigyotenCD.replaceAll('-', ''));
            acc.JurisdictionalStoreCode__pc = eigyotenCD.replaceAll('-', '');//所管店コード

            List<Account> eigyotens = [select id from Account Where JurisdictionalStoreCode__c = :acc.JurisdictionalStoreCode__pc];
            if(!eigyotens.isEmpty()) acc.SalesBranchName__pc =eigyotens.get(0).Id;

            System.debug('tsuhan_Umu:' +params.tsuhan_Umu);
            acc.AvailabilityHawkerAgreements__c = String.isBlank(params.tsuhan_Umu)? false : true;  //通販特約有無
            
            System.debug('shudan_Cd:' +params.shudan_Cd);
            acc.CollectiveCode__pc = params.shudan_Cd;//集団コード
            
            List<GroupCode__c> groupCodes = [select id,Name from GroupCode__c Where Name = :params.shudan_Cd];
            if(!groupCodes.isEmpty()) acc.GroupList__pc =groupCodes.get(0).Id;
            System.debug('shudan_Name:' +params.shudan_Name);
            acc.GroupName__pc = params.shudan_Name;//集団名
            System.debug('jiko_Umu:' +params.jiko_Umu);
            acc.Accident__pc = String.isBlank(params.jiko_Umu)? false : true;//事故有無
            System.debug('soshiki_Cd:' +params.soshiki_Cd);
            acc.FukokuBranchCode__pc = params.soshiki_Cd;//富国生命 組織コード
            System.debug('hkn_Shurui:' +params.hkn_Shurui);
            acc.LineInsurance__pc = params.hkn_Shurui;//保険種目
            acc.InsuranceFee__pc = String.isBlank(params.gokei_HknRyo) ? 0 : Decimal.valueOf(params.gokei_HknRyo.replaceAll(',',''));  //合計保険料
            
            System.debug('keiyakusha_Birth:' +params.keiyakusha_Birth);
            if(String.isNotBlank(params.keiyakusha_Birth)){
                acc.ContractorBirthday__pc =
                    Date.newInstance(Integer.valueOf(params.keiyakusha_Birth.left(4)),Integer.valueOf(params.keiyakusha_Birth.mid(4, 2)),Integer.valueOf(params.keiyakusha_Birth.right(2)));//契約者生年月日
            }else{
                acc.ContractorBirthday__pc = null;
            }
            
            System.debug('keiyakusha_Nenrei:' +params.keiyakusha_Nenrei);
            acc.ContractorAge__pc = String.isBlank(params.keiyakusha_Nenrei) ? 0 : Decimal.valueOf(params.keiyakusha_Nenrei); //契約者年齢
            
            System.debug('keiyakusha_Seibetsu:' +params.keiyakusha_Seibetsu);
            acc.Gender__pc = params.keiyakusha_Seibetsu;//契約者性別
            System.debug('shisha_Cd:' +params.shisha_Cd);
            acc.OfficeCode__pc = params.shisha_Cd;//相対支社コード
            System.debug('cif_Cd:' +params.cif_Cd);
            acc.CIFCode__pc = params.cif_Cd;//CIFコード
            acc.ContactInfo__pc = params.renrakusaki;//事務上連絡先
            acc.PaymentMethod__pc = params.haraikomi;//払込方法
            System.debug('keiyakusha_Jusho_Kana:' +params.keiyakusha_Jusho_Kana);
            acc.AddressKana__pc = params.keiyakusha_Jusho_Kana;//住所カナ
            update acc;
            acc = [Select Id, PersonContactId,AgencyName__pc From Account Where Id = :gyoumu_Id];
            System.debug(acc);
            contract.R_Contact__c = acc.PersonContactId;
            contract.AccountManagement__c = acc.AgencyName__pc;
        }
        contract.Name = params.shoken_No;
        contract.SecuritiesNumber__c = params.shoken_No; //証券番号
        if(String.isNotBlank(params.hkn_Shiki)){
            contract.InsuranceFrom__c = 
                Date.newInstance(Integer.valueOf(params.hkn_Shiki.left(4)),Integer.valueOf(params.hkn_Shiki.mid(4, 2)),Integer.valueOf(params.hkn_Shiki.right(2)));//保険始期
        }else{
            contract.InsuranceFrom__c = null;
        }
        if(String.isNotBlank(params.hkn_Shuki)){
            if(params.hkn_Shuki == '00000000'){
            
                contract.InsurancePeriod__c = null;
            }else{
                contract.InsurancePeriod__c =
                    Date.newInstance(Integer.valueOf(params.hkn_Shuki.left(4)),Integer.valueOf(params.hkn_Shuki.mid(4, 2)),Integer.valueOf(params.hkn_Shuki.right(2)));//保険終期
            }
        }else{
            contract.InsurancePeriod__c = null;
        }
        
        contract.ContractorName__c = params.keiyakusha_Knj; //契約者名
        contract.ContractorKana__c = params.keiyakusha_Kana; //契約者名カナ
        contract.PhoneNumber__c = params.keiyakusha_Tel; //契約者電話番号
        contract.ZipCode__c = params.keiyakusha_Yubin_No; //契約者郵便番号
        contract.Address__c = params.keiyakusha_Jusho_Knj; //契約者住所
        contract.AgencyCode__c = params.dairiten_Cd; //代理店コード
        system.debug(eigyotenCD.replaceAll('-', ''));
        contract.JurisdictionalStoreCode__c = eigyotenCD.replaceAll('-', '');//所管店コード; //所管店コード
        contract.SpecialAgreementYesNo__c = String.isBlank(params.tsuhan_Umu)? false : true;  //通販特約有無
        contract.CollectiveCode__c = params.shudan_Cd; //集団コード
        contract.CollectiveName__c = params.shudan_Name; //集団名
        contract.AccidentYesNo__c = String.isBlank(params.jiko_Umu)? false : true;//事故有無
        contract.OrganizationCode__c = params.soshiki_Cd; //富国生命 組織コード
        contract.InsuranceItem__c = params.hkn_Shurui; //保険種目
        contract.InsuranceFee__c = Integer.valueOf(params.gokei_HknRyo); //合計保険料
        
        if(String.isNotBlank(params.keiyakusha_Birth)){
            contract.Birthday__c = 
                Date.newInstance(Integer.valueOf(params.keiyakusha_Birth.left(4)),Integer.valueOf(params.keiyakusha_Birth.mid(4, 2)),Integer.valueOf(params.keiyakusha_Birth.right(2)));//契約者生年月日
        
        }else{
            contract.Birthday__c = null;
        }
        contract.Age__c = String.isBlank(params.keiyakusha_Nenrei) ? 0 : Integer.valueOf(params.keiyakusha_Nenrei); //契約者年齢
        
        contract.Sex__c = params.keiyakusha_Seibetsu; //契約者性別
        contract.BranchCode__c = params.shisha_Cd; //相対支社コード
        contract.CifCode__c = params.cif_Cd; //CIFコード
        contract.ContactInfo__c = params.renrakusaki; //事務上連絡先
        contract.PaymentMethod__c = params.haraikomi; //払込方法
        contract.AddressKana__c = params.keiyakusha_Jusho_Kana; //住所カナ
        List<Contract_Information__c> contracts = [Select Id from Contract_Information__c Where Name =:params.shoken_No];
        if(contracts.isEmpty()){
            insert contract;
        }else{
            contract.Id = contracts.get(0).Id;
            update contract;
        }
        if(c != null){
            c.ContractInformationId__c = contract.Id;
            update c;
        }
        res.statusCode = 200;
        return ;
    }
    public class Request{
        String gCode;
        String gyoumu_Id;
        String shoken_No;
        String hkn_Shiki;
        String hkn_Shuki;
        String keiyakusha_Knj;
        String keiyakusha_Kana;
        String keiyakusha_Tel;
        String keiyakusha_Yubin_No;
        String keiyakusha_Jusho_Knj;
        String dairiten_Cd;
        String shokanten_Cd;
        String tsuhan_Umu;
        String shudan_Cd;
        String shudan_Name;
        String jiko_Umu;
        String soshiki_Cd;
        String hkn_Shurui;
        String gokei_HknRyo;
        String keiyakusha_Birth;
        String keiyakusha_Nenrei;
        String keiyakusha_Seibetsu;
        String shisha_Cd;
        String cif_Cd;
        String renrakusaki;
        String haraikomi;
        String keiyakusha_Jusho_Kana;
    }
}