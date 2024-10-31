public without Sharing class GetAccountInfoController{

    public GetAccountInfoController(){
    }
    public void processIncomingData() {
            // Retrieve POST data
            Map<String,String> postData = ApexPages.currentPage().getParameters();
            System.debug('POSTデータ: ' + postData);
            System.debug(ApexPages.currentPage().getParameters());
            
            //If POST data is blank, redirect immediately
            if (postData == null || postData.isEmpty()) {
                return;
            }
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
            for(String key : postData.keySet()){
                if(key.toLowerCase() == 'gCode'.toLowerCase()){
                    gCode = postData.get(key);
                }else if(key.toLowerCase() == 'gyoumu_Id'.toLowerCase()){
                    gyoumu_Id = postData.get(key);

                }else if(key.toLowerCase() == 'shoken_No'.toLowerCase()){
                    shoken_No = postData.get(key);

                }else if(key.toLowerCase() == 'hkn_Shiki'.toLowerCase()){
                    hkn_Shiki = postData.get(key);

                }else if(key.toLowerCase() == 'hkn_Shuki'.toLowerCase()){
                    hkn_Shuki = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Knj'.toLowerCase()){
                    keiyakusha_Knj = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Kana'.toLowerCase()){
                    keiyakusha_Kana = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Tel'.toLowerCase()){
                    keiyakusha_Tel = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Yubin_No'.toLowerCase()){
                    keiyakusha_Yubin_No = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Jusho_Knj'.toLowerCase()){
                    keiyakusha_Jusho_Knj = postData.get(key);

                }else if(key.toLowerCase() == 'dairiten_Cd'.toLowerCase()){
                    dairiten_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'shokanten_Cd'.toLowerCase()){
                    shokanten_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'tsuhan_Umu'.toLowerCase()){
                    tsuhan_Umu = postData.get(key);

                }else if(key.toLowerCase() == 'shudan_Cd'.toLowerCase()){
                    shudan_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'shudan_Name'.toLowerCase()){
                    shudan_Name = postData.get(key);

                }else if(key.toLowerCase() == 'jiko_Umu'.toLowerCase()){
                    jiko_Umu = postData.get(key);

                }else if(key.toLowerCase() == 'soshiki_Cd'.toLowerCase()){
                    soshiki_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'hkn_Shurui'.toLowerCase()){
                    hkn_Shurui = postData.get(key);

                }else if(key.toLowerCase() == 'gokei_HknRyo'.toLowerCase()){
                    gokei_HknRyo = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Birth'.toLowerCase()){
                    keiyakusha_Birth = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Nenrei'.toLowerCase()){
                    keiyakusha_Nenrei = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Seibetsu'.toLowerCase()){
                    keiyakusha_Seibetsu = postData.get(key);

                }else if(key.toLowerCase() == 'shisha_Cd'.toLowerCase()){
                    shisha_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'cif_Cd'.toLowerCase()){
                    cif_Cd = postData.get(key);

                }else if(key.toLowerCase() == 'renrakusaki'.toLowerCase()){
                    renrakusaki = postData.get(key);

                }else if(key.toLowerCase() == 'haraikomi'.toLowerCase()){
                    haraikomi = postData.get(key);

                }else if(key.toLowerCase() == 'keiyakusha_Jusho_Kana'.toLowerCase()){
                    keiyakusha_Jusho_Kana = postData.get(key);
                }
            }
            if(String.isBlank(gyoumu_id)){
                //エラー
                return;
            }
            Contract_Information__c contract = new Contract_Information__c();

            if(gyoumu_Id.left(3) == '003'){
                //Contact
                Contact c = new Contact(Id = gyoumu_Id);
                c.SecurityNumberParentNumber__c = shoken_No;//証券番号
                if(String.isNotBlank(hkn_Shiki)){
                    c.CommencementInsurance__c = 
                        Date.newInstance(Integer.valueOf(hkn_Shiki.left(4)),Integer.valueOf(hkn_Shiki.mid(4, 2)),Integer.valueOf(hkn_Shiki.right(2)));//保険始期
                }else{
                    c.CommencementInsurance__c = null;
                }
                
                if(String.isNotBlank(hkn_Shuki)){
                    c.TermOfInsurance__c = 
                        Date.newInstance(Integer.valueOf(hkn_Shuki.left(4)),Integer.valueOf(hkn_Shuki.mid(4, 2)),Integer.valueOf(hkn_Shuki.right(2)));//保険終期
                }else{
                    c.TermOfInsurance__c = null;
                }
                c.PolicyholderName__c = keiyakusha_Knj;//契約者名
                c.PolicyholderName_Kana__c = keiyakusha_Kana;//契約者名カナ
                c.PolicyholderTEL__c = keiyakusha_Tel;//契約者電話番号
                c.PostalCode__c = keiyakusha_Yubin_No.replaceAll('-', '');//郵便番号
                c.Address__c = keiyakusha_Jusho_Knj;//契約者住所
                c.AgencyCode__c = dairiten_Cd;//代理店コード
                List<Account> dairitens = [select id from Account Where CounterpartyCode__c = :dairiten_Cd];
                if(!dairitens.isEmpty()) c.AgencyName__c =dairitens.get(0).Id;
                c.JurisdictionalStoreCode__c = shokanten_Cd;//所管店コード

                List<Account> eigyotens = [select id from Account Where CounterpartyCode__c = :shokanten_Cd];
                if(!eigyotens.isEmpty()) c.SalesBranchName__c =eigyotens.get(0).Id;

                c.MailOrderSpecialSales__c = String.isBlank(tsuhan_Umu)? false : true;  //通販特約有無
                c.CollectiveCode__c = shudan_Cd;//集団コード
                
                List<GroupCode__c> groupCodes = [select id from GroupCode__c Where Name = :shudan_Cd];
                if(!groupCodes.isEmpty()) c.GroupList__c =groupCodes.get(0).Id;
                c.GroupName__c = shudan_Name;//集団名
                c.Accident__c = String.isBlank(jiko_Umu)? false : true;//事故有無
                c.FukokuBranchCode__c = soshiki_Cd;//富国生命 組織コード
                c.LineInsurance__c = hkn_Shurui;//保険種目
                // = shoken_No;合計保険料
                
                if(String.isNotBlank(keiyakusha_Birth)){
                    //c.Birthdate =
                    //    Date.newInstance(Integer.valueOf(keiyakusha_Birth.left(4)),Integer.valueOf(keiyakusha_Birth.mid(4, 2)),Integer.valueOf(keiyakusha_Birth.right(2)));//契約者生年月日
                }else{
                    //c.Birthdate = null;
                }
                // = shoken_No;契約者年齢
                c.Gender__c = keiyakusha_Seibetsu;//契約者性別
                c.OfficeCode__c = shisha_Cd;//相対支社コード
                c.CIFCode__c = cif_Cd;//CIFコード
                //c. = renrakusaki;//事務上連絡先
                //c. = haraikomi;//払込方法
                c.AddressKana__c = keiyakusha_Jusho_Kana;//住所カナ
                update c;

                contract.R_Contact__c = c.Id;
                contract.AccountManagement__c = c.AgencyName__c;
            }
            contract.Name = shoken_No;
            contract.SecuritiesNumber__c = shoken_No; //証券番号
            if(String.isNotBlank(hkn_Shiki)){
                contract.InsuranceFrom__c = 
                    Date.newInstance(Integer.valueOf(hkn_Shiki.left(4)),Integer.valueOf(hkn_Shiki.mid(4, 2)),Integer.valueOf(hkn_Shiki.right(2)));//保険始期
            }else{
                contract.InsuranceFrom__c = null;
            }
            if(String.isNotBlank(hkn_Shuki)){
                contract.InsurancePeriod__c =
                Date.newInstance(Integer.valueOf(hkn_Shuki.left(4)),Integer.valueOf(hkn_Shuki.mid(4, 2)),Integer.valueOf(hkn_Shuki.right(2)));//保険終期
            }else{
                contract.InsurancePeriod__c = null;
            }
            
            contract.ContractorName__c = keiyakusha_Knj; //契約者名
            contract.ContractorKana__c = keiyakusha_Kana; //契約者名カナ
            contract.PhoneNumber__c = keiyakusha_Tel; //契約者電話番号
            contract.ZipCode__c = keiyakusha_Yubin_No; //契約者郵便番号
            contract.Address__c = keiyakusha_Jusho_Knj; //契約者住所
            contract.AgencyCode__c = dairiten_Cd; //代理店コード
            contract.JurisdictionalStoreCode__c = shokanten_Cd; //所管店コード
            contract.SpecialAgreementYesNo__c = String.isBlank(tsuhan_Umu)? false : true;  //通販特約有無
            contract.CollectiveCode__c = shudan_Cd; //集団コード
            contract.CollectiveName__c = shudan_Name; //集団名
            contract.AccidentYesNo__c = String.isBlank(jiko_Umu)? false : true;//事故有無
            contract.OrganizationCode__c = soshiki_Cd; //富国生命 組織コード
            contract.InsuranceItem__c = hkn_Shurui; //保険種目
            contract.InsuranceFee__c = Integer.valueOf(gokei_HknRyo); //合計保険料
            
            if(String.isNotBlank(keiyakusha_Birth)){
                contract.Birthday__c = 
                    Date.newInstance(Integer.valueOf(keiyakusha_Birth.left(4)),Integer.valueOf(keiyakusha_Birth.mid(4, 2)),Integer.valueOf(keiyakusha_Birth.right(2)));//契約者生年月日
            
            }else{
                contract.Birthday__c = null;
            }
            contract.Age__c = Integer.valueOf(keiyakusha_Nenrei); //契約者年齢
            contract.Sex__c = keiyakusha_Seibetsu; //契約者性別
            contract.BranchCode__c = shisha_Cd; //相対支社コード
            contract.CifCode__c = cif_Cd; //CIFコード
            contract.ContactInfo__c = renrakusaki; //事務上連絡先
            contract.PaymentMethod__c = haraikomi; //払込方法
            contract.AddressKana__c = keiyakusha_Jusho_Kana; //住所カナ
            List<Contract_Information__c> contracts = [Select Id from Contract_Information__c Where Name =:shoken_No];
            if(contracts.isEmpty()){
                insert contract;
            }else{
                contract.Id = contracts.get(0).Id;
                update contract;
            }

    }
}