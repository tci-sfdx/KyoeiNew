public with sharing class ChohyoCreatorPattern1Controller {
    
    public String STAFF_DEPT_NAME{get; set;} //代理店．担当営業店名．相手先名
    public String CUSTOMER_AGENCY_NAME{get; set;} //代理店．相手先名
    public String InsuranceItem{get; set;} //契約情報．保険種目
    public String InsuranceItem_2{get; set;} //保険種目2
    public String SecuritiesNumber{get; set;} //契約情報．証券番号
    public String ContractorName{get; set;} //契約情報．契約者名
    public String PhoneNumber{get; set;} //契約情報．契約者電話番号
    public String PolicyIdentificationMethod{get; set;} //契約特定方法
    public String CifCode{get; set;} //契約情報．CIFコード
    public Decimal InsuranceFee{get; set;} //合計保険料
    public String PaymentMethod{get; set;} //払込方法
    public String CreatedDate{get; set;} //作成日
    public String CreatedByName  {get; set;} //作成者名
    public String ConversationPartner_Group{get; set;} //契約者との続柄
    public String ContactName{get; set;} //入電者名.相手先名
    public String ContactLastFirstName{get; set;} //入電者名．相手先名
    public String ContactPostCode{get; set;} //入電者名.郵便番号
    public String ContactAddress{get; set;} //入電者名.住所
    public String ContactPhoneNumber{get; set;} //入電者名.電話番号
    public String ContactGroupName{get; set;} //入電者名．集団名
    public String UnionMemberEmployeeCode{get; set;} //組合員（社員）コード
    public String Caller_PhoneNumber{get; set;} //着信電話番号
    public String counterparty_Kana{get; set;} //入電者カナ           
    public String NameOfReturnCaller{get; set;} //折返し連絡者名（カナ）
    public String ReturnPhoneNumber{get; set;} //折返し電話番号
    public String ContactPersonRelationship{get; set;} //契約者と折返し連絡者の関係
    public String DesiredContactDateAndTime{get; set;} //連絡希望日時
    public Date DateOfTransfer{get; set;} //異動日（死亡・解約日）
    public String DateofDeathAndCause{get; set;} //死亡日・原因
    public String ReceiptItem_Reason{get; set;} //受付項目（事由）
    public String KCC_ReasonForExclusion{get; set;} //KCC対象外理由
    public String Other_EntryField{get; set;} //その他＿記入欄
    public String ReceiptItem_Reason_Multi{get; set;} //受付項目（事由）_複数

    public Date NotSubjectDay{get; set;} //満期対象外契約発覚日
    public Date DateOfCallSuspension{get; set;} //コール中止日
    public String ReasonForCallSuspension{get; set;} //コール中止理由
    public Date InsuranceFrom{get; set;} //保険始期
    public Date InsurancePeriod{get; set;} //保険終期
    public Integer HokenKikan{get; set;} //保険期間
    public Date ArrivalDate_Latest{get; set;} //到着日（最新）
    public String DuplicateCoverageItem{get; set;} //補償重複項目
    public String CertificateInterruption{get; set;} //中断証明書
    public String CancellationContractReason{get; set;} //解約理由
    public String CarName{get; set;} //車名（＋車体の形状）
    public String ApplicationRequest{get; set;} //申込（請求）日時
    public String DeficiencyResolvedResult{get; set;} //不備解消結果
    public String PaymentDate{get; set;} //入電者名．集団コード．払込日

    public String InquiryDetails{get; set;} //問い合わせ詳細
    public String Remarks{get; set;} //対応依頼票転記内容
    public String CaseNumber{get; set;} //コール連番
    public String OwnerName{get; set;} //所有者名
    public String Extension{get; set;} //内線番号

    public String PrintName{get; set;} //帳票名
    public String Header{get; set;} //ヘッダ
    public String PROB_TEXT_Header{get; set;} //案内内容ヘッダ
    public String ANS_TEXT_Header{get; set;} //回答内容ヘッダ
    public String SiteName{get; set;} //所管部門名
    public String SitePhone{get; set;} //所管部門連絡先
    public String InsuranceItemHeader{get; set;} //保険種目ヘッダ
    public String ContactInformationHeader{get; set;} //入電者名情報ヘッダ
    public String CreatedDateLabel{get; set;} //受付日時ラベル
    public String ContactLabel{get; set;} //入電者名ラベル
    public String CallerPhoneNumberLabel{get; set;} //着信電話番号ラベル
    public String SenderPostCode{get; set;} //発送元郵便番号
    public String SenderAddress{get; set;} //発送元住所
    public String SenderName{get; set;} //発送元名
    public String Detail1Header{get; set;} //明細１ヘッダ
    public String Detail2Header{get; set;} //明細２ヘッダ
    public String Detail3Header{get; set;} //明細３ヘッダ
    public String ShippingPersonName{get; set;} //送付者名
    public String PrintHeader{get; set;} //帳票ヘッダ
    public String PrintSubHeader{get; set;} //帳票サブヘッダ
    public String DisplayWord1{get; set;} //表記１
    public String FirstFeeTransDate{get; set;} //初回保険料振替日
    public String SendTo{get; set;} //送付先
    public String SendFrom{get; set;} //送付元
    public String Title{get; set;} //件名

    public String Greeting{get; set;} //あいさつ文
    public String GreetingHosoku{get; set;} //あいさつ文補足
    public String Enclosure{get; set;} //今回お送りした書類
    public String ReplyDoc{get; set;} //ご返送いただく書類
    public String CommunicationColumn{get; set;} //ご連絡事項
    public String CommunicationColumn2{get; set;} //ご連絡事項2
    public String Inquiry{get; set;} //連絡先
    public String CheckItem1{get; set;} //確認項目1
    public String CheckItem2{get; set;} //確認項目2
    public String CheckItem3{get; set;} //確認項目3
    public String CheckDetail1{get; set;} //確認内容1
    public String CheckDetail2{get; set;} //確認内容2
    public String CheckDetail3{get; set;} //確認内容3
    public Date KigenDate{get; set;} //期限日
    public String ReceptDetails{get; set;} //受付内容の区分

    public List<soufusyoruiWrapper> soufuList{get; set;} //送付書類用リスト
    public Date SystemDate{get; set;} //現在日付用

    public ChohyoCreatorPattern1Controller() {

        //パラメータ取得
        String paramId = ApexPages.currentPage().getParameters().get('Id');
        String paramcId = ApexPages.currentPage().getParameters().get('cId');

        system.debug(paramId);
        system.debug(paramcId);

        SystemDate = System.today();

        //カスタマーセンターコールデータの取得
        List<Case> cases = [SELECT ReferenceAccount__r.SalesBranchName__r.Name   //代理店．担当営業店名．相手先名
                                  ,OfficeName__r.Name                            //対応依頼営業店名
                                  ,ReferenceAccount__r.Name                      //代理店．相手先名
                                  ,ContractInformationId__r.InsuranceItem__c     //契約情報．保険種目
                                  ,InsuranceItem_2__c                            //保険種目2
                                  ,ContractInformationId__r.SecuritiesNumber__c  //契約情報．証券番号
                                  ,ContractInformationId__r.ContractorName__c    //契約情報．契約者名
                                  ,ContractInformationId__r.PhoneNumber__c       //契約情報．契約者電話番号
                                  ,PolicyIdentificationMethod__c                 //契約特定方法
                                  ,ContractInformationId__r.CifCode__c           //契約情報．CIFコード
                                  ,ContractInformationId__r.ZipCode__c           //契約情報．契約者郵便番号
                                  ,ContractInformationId__r.Address__c           //契約情報．契約者住所
                                  ,ContractInformationId__r.InsuranceFee__c      //契約情報．合計保険料
                                  ,ContractInformationId__r.PaymentMethod__c     //契約情報．払込方法

                                  ,RegistrationDate__c                           //登録日時（対応依頼用）
                                  ,CreatedBy.Name                                //作成者名
                                  ,ConversationPartner_Group__c                  //契約者との続柄
                                  ,Contact.Name                                  //入電者名．相手先名
                                  ,Contact.LastName                              //入電者名．相手先名
                                  ,Contact.FirstName                             //入電者名．相手先名
                                  ,Contact.PolicyholderName__c                   //入電者名．契約者名
                                  ,ContractorName__c                             //契約者名

                                  ,Contact.PostalCode__c                         //入電者名．郵便番号
                                  ,Contact.State_Province__c                     //入電者名．都道府県
                                  ,Contact.Address__c                            //入電者名．住所
                                  ,Contact.PhoneNumber__c                        //入電者名．電話番号
                                  ,PolicyholderZipCode__c                        //契約者郵便番号
                                  ,ContractorAddress__c                          //契約者住所

                                  ,Contact.GroupName__c                          //入電者名．集団名
                                  ,Account.UnionMemberEmployeeCode__c            //組合員（社員）コード
                                  ,Caller_PhoneNumber__c                         //着信電話番号
                                  ,counterparty_Kana__c                          //入電者カナ

                                  ,NameOfReturnCaller__c                         //折返し連絡者名（カナ）
                                  ,ReturnPhoneNumber__c                          //折返し電話番号
                                  ,ContactPersonRelationship__c                  //契約者と折返し連絡者の関係
                                  ,DesiredContactDateAndTime__c                  //連絡希望日時

                                  ,DateOfTransfer__c                             //異動日（死亡・解約日）
                                  ,DateofDeathAndCause__c                        //死亡日・原因
                                  ,ReceiptItem_Reason__c                         //受付項目（事由）
                                  ,KCC_ReasonForExclusion__c                     //KCC対象外理由
                                  ,Other_EntryField__c                           //その他＿記入欄
                                  ,ReceiptItem_Reason_Multi__c                   //受付項目（事由）_複数

                                  ,NotSubjectDay__c                             //満期対象外契約発覚日
                                  ,DateOfCallSuspension__c                      //コール中止日
                                  ,ReasonForCallSuspension__c                   //コール中止理由
                                  ,ContractInformationId__r.InsuranceFrom__c    //契約情報．保険始期
                                  ,ContractInformationId__r.InsurancePeriod__c  //契約情報．保険終期
                                  ,ArrivalDate_Latest__c                        //到着日（最新）
                                  ,DuplicateCoverageItem__c                     //補償重複項目
                                  ,CertificateInterruption__c                   //中断証明書
                                  ,CancellationContractReason__c                //解約理由
                                  ,CarName__c                                   //車名（＋車体の形状）
                                  ,ApplicationRequest__c                        //申込（請求）日時
                                  ,DeficiencyResolvedResult__c                  //不備解消結果
                                  ,Contact.GroupList__r.PaymentDate__c          //入電者名．集団コード．払込日

                                  ,InquiryDetails__c                            //問い合わせ詳細
                                  ,Remarks__c                                   //対応依頼票転記内容
                                  ,CaseNumber                                   //コール連番
                                  ,OwnerId                                      //所有者Id
                                  ,Owner.Name                                   //所有者名

                                  ,Greeting__c                                  //あいさつ文
                                  ,GreetingHosoku__c                            //あいさつ文補足
                                  ,Enclosure__c                                 //今回お送りした書類
                                  ,ReplyDoc__c                                  //ご返送いただく書類
                                  ,CommunicationColumn__c                       //ご連絡事項
                                  ,Inquiry__c                                   //連絡先
                                  ,CheckItem1__c                                //確認項目1
                                  ,CheckItem2__c                                //確認項目2
                                  ,CheckItem3__c                                //確認項目3
                                  ,CheckDetail1__c                              //確認内容1
                                  ,CheckDetail2__c                              //確認内容2
                                  ,CheckDetail3__c                              //確認内容3
                                  ,SofuShorui__c                                //送付書類
                                  ,KigenDate__c                                 //期限日
                                  ,ReceptDetails__c                             //受付内容の区分
                                  ,FirstFeeTransDate__c                         //初回保険料振替日
                              FROM Case WHERE Id =:paramId];
        
        if (cases.isEmpty()) return;

        String OwnerId = ''; 
        for(case caseRcd : cases){
            if (String.isNotBlank(caseRcd.OfficeName__r.Name)) {
                STAFF_DEPT_NAME = caseRcd.OfficeName__r.Name; //対応依頼営業店名
            } else {
                STAFF_DEPT_NAME = caseRcd.ReferenceAccount__r.SalesBranchName__r.Name; //代理店．担当営業店名．相手先名
            }
            
            CUSTOMER_AGENCY_NAME = caseRcd.ReferenceAccount__r.Name;                //代理店．相手先名

            InsuranceItem = caseRcd.ContractInformationId__r.InsuranceItem__c;      //契約情報．保険種目
            InsuranceItem_2 = caseRcd.InsuranceItem_2__c;                           //保険種目2
            SecuritiesNumber = caseRcd.ContractInformationId__r.SecuritiesNumber__c; //契約情報．証券番号
            ContractorName = caseRcd.ContractInformationId__r.ContractorName__c;    //契約情報．契約者名
            PhoneNumber = caseRcd.ContractInformationId__r.PhoneNumber__c;          //契約情報．契約者電話番号
            PolicyIdentificationMethod = caseRcd.PolicyIdentificationMethod__c;     //契約特定方法
            CifCode = caseRcd.ContractInformationId__r.CifCode__c;                  //契約情報．CIFコード
            InsuranceFee = caseRcd.ContractInformationId__r.InsuranceFee__c;        //契約情報．合計保険料
            PaymentMethod = caseRcd.ContractInformationId__r.PaymentMethod__c;      //契約情報．払込方法

            //登録日時（対応依頼用）
            if (caseRcd.RegistrationDate__c != null) {
                CreatedDate = caseRcd.RegistrationDate__c.format('yyyy/MM/dd HH:mm','JST'); 
            }
            
            CreatedByName = caseRcd.CreatedBy.Name;                                 //作成者名
            ConversationPartner_Group = caseRcd.ConversationPartner_Group__c;       //契約者との続柄
            ContactName = caseRcd.Contact.Name;                                     //入電者名.相手先名
            
            //入電者名．相手先名
            ContactLastFirstName = caseRcd.ContractorName__c;

            //入電者名.郵便番号
            if (String.isNotBlank(caseRcd.Contact.PostalCode__c)) {
                ContactPostCode = caseRcd.Contact.PostalCode__c; 
            } else {
                ContactPostCode = caseRcd.PolicyholderZipCode__c; 
            }
            
            //入電者名.住所
            if (String.isNotBlank(caseRcd.Contact.State_Province__c) && String.isNotBlank(caseRcd.Contact.Address__c)) {
                ContactAddress = formatNewLine(caseRcd.Contact.State_Province__c + caseRcd.Contact.Address__c, 20); 
            } else {
                ContactAddress = formatNewLine(caseRcd.ContractorAddress__c, 20); 
            }
            
            //電話番号（帳票14-1,2用）
            if (String.isNotBlank(caseRcd.ContractInformationId__r.PhoneNumber__c)) {
                ContactPhoneNumber = caseRcd.ContractInformationId__r.PhoneNumber__c;
            } else {
                ContactPhoneNumber = caseRcd.Contact.PhoneNumber__c;
            }

            ContactGroupName = caseRcd.Contact.GroupName__c;                        //入電者名．集団名
            UnionMemberEmployeeCode = caseRcd.Account.UnionMemberEmployeeCode__c;   //組合員（社員）コード
            Caller_PhoneNumber = caseRcd.Caller_PhoneNumber__c;                     //着信電話番号                                     
            counterparty_Kana = caseRcd.counterparty_Kana__c;                       //入電者カナ

            NameOfReturnCaller = caseRcd.NameOfReturnCaller__c;	                    //折返し連絡者名（カナ）
            ReturnPhoneNumber = caseRcd.ReturnPhoneNumber__c;	                    //折返し電話番号
            ContactPersonRelationship = caseRcd.ContactPersonRelationship__c;	    //契約者と折返し連絡者の関係
            DesiredContactDateAndTime = caseRcd.DesiredContactDateAndTime__c;	    //連絡希望日時

            DateOfTransfer = caseRcd.DateOfTransfer__c;                             //異動日（死亡・解約日）
            DateofDeathAndCause = caseRcd.DateofDeathAndCause__c;                   //死亡日・原因
            ReceiptItem_Reason = caseRcd.ReceiptItem_Reason__c;                     //受付項目（事由）
            
            //KCC対象外理由
            if (String.isNotBlank(caseRcd.KCC_ReasonForExclusion__c)){
                KCC_ReasonForExclusion = caseRcd.KCC_ReasonForExclusion__c.replace(';','、');
            }
            
            //その他＿記入欄
            Other_EntryField = caseRcd.Other_EntryField__c;
            
            //受付項目（事由）_複数
            if (String.isNotBlank(caseRcd.ReceiptItem_Reason_Multi__c)){
                ReceiptItem_Reason_Multi = caseRcd.ReceiptItem_Reason_Multi__c.replace(';','、');
            }
            
            NotSubjectDay = caseRcd.NotSubjectDay__c; //満期対象外契約発覚日
            DateOfCallSuspension = caseRcd.DateOfCallSuspension__c; //コール中止日
            ReasonForCallSuspension = caseRcd.ReasonForCallSuspension__c; //コール中止理由
            InsuranceFrom = caseRcd.ContractInformationId__r.InsuranceFrom__c; //契約情報．保険始期
            InsurancePeriod = caseRcd.ContractInformationId__r.InsurancePeriod__c; //契約情報．保険終期

            //保険期間
            if (InsuranceFrom != null && InsurancePeriod != null){
                HokenKikan = Integer.valueOf(Math.floor(InsuranceFrom.daysBetween(InsurancePeriod) / 365));
            }

            ArrivalDate_Latest = caseRcd.ArrivalDate_Latest__c; //到着日（最新）
            DuplicateCoverageItem = framingString(caseRcd.DuplicateCoverageItem__c, 46); //補償重複項目
            CertificateInterruption = caseRcd.CertificateInterruption__c; //中断証明書
            CancellationContractReason = caseRcd.CancellationContractReason__c; //解約理由
            CarName = caseRcd.CarName__c; //車名（＋車体の形状）

            //申込（請求）日時
            if (caseRcd.ApplicationRequest__c != null) {
                ApplicationRequest = caseRcd.ApplicationRequest__c.format('yyyy/MM/dd','JST'); 
            }
            
            DeficiencyResolvedResult = framingString(caseRcd.DeficiencyResolvedResult__c, 36); //不備解消結果
            PaymentDate = caseRcd.Contact.GroupList__r.PaymentDate__c; //入電者名．集団コード．払込日（初回保険料振替日）
            
            InquiryDetails = framingString(caseRcd.InquiryDetails__c, 58); //問い合わせ詳細
            Remarks = framingString(caseRcd.Remarks__c, 58); //対応依頼票転記内容
            CaseNumber = caseRcd.CaseNumber;
            OwnerId = caseRcd.OwnerId;
            OwnerName = caseRcd.Owner.Name;

            Greeting = framingString(caseRcd.Greeting__c, 58); //あいさつ文
            GreetingHosoku = framingString(caseRcd.GreetingHosoku__c, 58); //あいさつ文補足

            //今回お送りした書類
            Integer LineRow1 = (paramcId == '11-1' || paramcId == '11-2' || paramcId == '11-3')? 26 : 58; 
            Enclosure = framingString(caseRcd.Enclosure__c, LineRow1); 

            //ご返送いただく書類
            Integer LineRow2 = (paramcId == '11-1' || paramcId == '11-2' || paramcId == '11-3')? 26 : 58; 
            ReplyDoc = framingString(caseRcd.ReplyDoc__c, LineRow2); 

            CommunicationColumn = framingString(caseRcd.CommunicationColumn__c, 58); //ご連絡事項
            Inquiry =  framingString(caseRcd.Inquiry__c, 50); //連絡先
            CheckItem1 = framingString(caseRcd.CheckItem1__c, 18); //確認項目1
            CheckItem2 = framingString(caseRcd.CheckItem2__c, 18); //確認項目2
            CheckItem3 = framingString(caseRcd.CheckItem3__c,18); //確認項目3
            CheckDetail1 = framingString(caseRcd.CheckDetail1__c, 34); //確認内容1
            CheckDetail2 = framingString(caseRcd.CheckDetail2__c, 34); //確認内容2
            CheckDetail3 = framingString(caseRcd.CheckDetail3__c, 34); //確認内容3
            KigenDate = caseRcd.KigenDate__c; //期限日
            ReceptDetails = caseRcd.ReceptDetails__c; //受付内容の区分
            FirstFeeTransDate = caseRcd.FirstFeeTransDate__c; //初回保険料振替日

            //送付書類
            soufuList = new List<soufusyoruiWrapper>();
            if (String.isNotBlank(caseRcd.SofuShorui__c)){                   
                for(String str : caseRcd.SofuShorui__c.split('\r\n|\r|\n')){
                    soufusyoruiWrapper sw = new soufusyoruiWrapper(formatNewLine(str, 50));
                    soufuList.add(sw);
                }
            }
        }

        //内線番号の取得
        List<User> users = [SELECT Phone FROM User WHERE Id =:OwnerId];
        
        for(User userRcd : users){
            Extension = userRcd.Phone; 
        }

        //帳票文言マスタの取得
        List<WordMaster__c> words = [SELECT PrintName__c //帳票名
                                            ,Header__c //ヘッダ
                                            ,PROB_TEXT_Header__c //案内内容ヘッダ
                                            ,ANS_TEXT_Header__c //回答内容ヘッダ
                                            ,SiteName__c //所管部門名
                                            ,SitePhone__c //所管部門連絡先
                                            ,InsuranceItemHeader__c //保険種目ヘッダ
                                            ,ContactInformationHeader__c //入電者名情報ヘッダ
                                            ,CreatedDateLabel__c //受付日時ラベル
                                            ,ContactLabel__c //入電者名ラベル
                                            ,CallerPhoneNumberLabel__c //着信電話番号ラベル
                                            ,SenderPostalCode__c //発送元郵便番号
                                            ,SenderAddress__c //発送元住所
                                            ,SenderName__c //発送元名
                                            ,Detail1Header__c //明細１ヘッダ
                                            ,Detail2Header__c //明細２ヘッダ
                                            ,Detail3Header__c //明細３ヘッダ
                                            ,ShippingPersonName__c //送付者名
                                            ,PrintHeader__c //帳票ヘッダ
                                            ,PrintSubHeader__c //帳票サブヘッダ
                                            ,DisplayWord1__c //表記１
                                            ,SendTo__c //送付先
                                            ,SendFrom__c //送付元
                                            ,Title__c //件名
                                        FROM WordMaster__c WHERE Name =:paramcId];

        for(WordMaster__c wordRcd : words){
            PrintName = wordRcd.PrintName__c; //帳票名
            Header = wordRcd.Header__c; //ヘッダ
            PROB_TEXT_Header = wordRcd.PROB_TEXT_Header__c; //案内内容ヘッダ
            ANS_TEXT_Header = wordRcd.ANS_TEXT_Header__c; //回答内容ヘッダ
            SiteName = wordRcd.SiteName__c; //所管部門名
            SitePhone = wordRcd.SitePhone__c; //所管部門連絡先
            InsuranceItemHeader = wordRcd.InsuranceItemHeader__c; //保険種目ヘッダ
            ContactInformationHeader = wordRcd.ContactInformationHeader__c; //入電者名情報ヘッダ
            CreatedDateLabel = wordRcd.CreatedDateLabel__c; //受付日時ラベル
            ContactLabel = wordRcd.ContactLabel__c; //入電者名ラベル
            CallerPhoneNumberLabel = wordRcd.CallerPhoneNumberLabel__c; //着信電話番号ラベル
            SenderPostCode = wordRcd.SenderPostalCode__c; //発送元郵便番号
            SenderAddress = wordRcd.SenderAddress__c; //発送元住所
            SenderName = wordRcd.SenderName__c; //発送元名
            Detail1Header = wordRcd.Detail1Header__c; //明細１ヘッダ
            Detail2Header = wordRcd.Detail2Header__c; //明細２ヘッダ
            Detail3Header = wordRcd.Detail3Header__c; //明細３ヘッダ
            ShippingPersonName = wordRcd.ShippingPersonName__c; //送付者名
            PrintHeader = wordRcd.PrintHeader__c; //帳票ヘッダ
            PrintSubHeader = wordRcd.PrintSubHeader__c; //帳票サブヘッダ
            DisplayWord1 = wordRcd.DisplayWord1__c; //表記１
            SendTo = wordRcd.SendTo__c; //送付先
            SendFrom = wordRcd.SendFrom__c; //送付元
            Title = wordRcd.Title__c; //件名
        }
    }

    public class soufusyoruiWrapper {
        public String syorui {get; set;}
        
        public soufusyoruiWrapper(String syorui) {    
            this.syorui = syorui;
        }
    }

    public String framingString(String paramString, Integer lineLength){

        if (String.isBlank(paramString)) return '';

        String tempString = '';
        Boolean isFirstRow = true;
            
        for(String str : paramString.split('\r\n|\r|\n')){
            if (!isFirstRow) tempString += '<br/>';
            tempString += formatNewLine(str, lineLength);
            isFirstRow = false;
        }
        return tempString;
    }
    
    //改行挿入処理
    private String formatNewLine(String str,Integer maxlength){

        if (String.isBlank(str)) return '';
        
        Integer strLength = str.length();
        String retStr = '';
        decimal nowLength = 0;
		for(Integer i = 0 ; i < str.length(); i++){
            String chr;
            Integer byteSize;
     
            // 1文字取得する
            chr = str.substring(i, (i + 1));
            // 1文字のバイト数を取得する
            byteSize = Blob.valueOf(chr).size();
            // 複数バイトの場合は全角とする
            if(byteSize > 1){
                nowLength += 1;
            }else{
            	nowLength += 0.6;
            }
            if(nowLength >= maxlength){
                retStr += '<br/>' + chr;
                nowLength = 0;
            }else{
                retStr += chr;
            }
        }
        return retStr;
    }
}