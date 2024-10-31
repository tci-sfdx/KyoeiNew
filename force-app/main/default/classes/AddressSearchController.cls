public with sharing class AddressSearchController {
    public Case currentRecord{get; set;}
    private Case caseRecord;

    public String ModeFlag{get;set;} //モードフラグ
    public String TargetField{get; set;} //対象項目
    public List<RecordType> RecordTypes; //レコードタイプ
    public Boolean isShowButton{get; set;} //次へボタン表示フラグ

    public String PostCodeLabel{get;set;}  //郵便番号表示ラベル
    public String JusyoKanjiLabel{get;set;} //住所表示ラベル
    public String PostCode{get;set;} //郵便番号
    public String JusyoKanji{get;set;} //住所

    public List<SelectOption> SelectTargetFields {
        get {
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('', '-'));
            
            if (RecordTypes[0].DeveloperName == 'AutomotiveNew') {
                //レコードタイプ：自動車新規
                //契約者住所
                options.add(new SelectOption('ContractorAddress__c', Schema.SObjectType.Case.fields.ContractorAddress__c.label));
            
            } else if (RecordTypes[0].DeveloperName == 'Fire') {
                //レコードタイプ：火新異動
                //（新）契約者住所
                options.add(new SelectOption('SubscribersAddressAfterChange1__c', Schema.SObjectType.Case.fields.SubscribersAddressAfterChange1__c.label));
                //（新）被保険者住所
                options.add(new SelectOption('Insured_AddressAfterChange1__c', Schema.SObjectType.Case.fields.Insured_AddressAfterChange1__c.label));
            
            } else if (RecordTypes[0].DeveloperName == 'IndemnityTermination') {
                //レコードタイプ：自賠責解約
                //送付先住所
                options.add(new SelectOption('MailingAddress__c', Schema.SObjectType.Case.fields.MailingAddress__c.label));
                //書類不備_送付先住所
                options.add(new SelectOption('Incomplete_Address__c', Schema.SObjectType.Case.fields.Incomplete_Address__c.label));
                //解約完了_送付先住所
                options.add(new SelectOption('CancellationCompletion_Address__c', Schema.SObjectType.Case.fields.CancellationCompletion_Address__c.label));
    
            } else if (RecordTypes[0].DeveloperName == 'TransferOfWealth') {
                //レコードタイプ：富国異動
                //（新）契約者住所
                options.add(new SelectOption('SubscribersAddressAfterChange1__c', Schema.SObjectType.Case.fields.SubscribersAddressAfterChange1__c.label));

            } else if (RecordTypes[0].DeveloperName == 'AutomobileMaturity') {
                //レコードタイプ：自動車満期
                //（新）契約者住所
                options.add(new SelectOption('SubscribersAddressAfterChange1__c', Schema.SObjectType.Case.fields.SubscribersAddressAfterChange1__c.label));

            } else if (RecordTypes[0].DeveloperName == 'AutomobileTransfers') {
                //レコードタイプ：自動車異動
                //（新）契約者住所
                options.add(new SelectOption('SubscribersAddressAfterChange1__c', Schema.SObjectType.Case.fields.SubscribersAddressAfterChange1__c.label));
            }
                
            return options;
        }
    }

    public String UniqueKey{get; set;} //住所マスタユニークキー

    public List<SelectOption> SelectAddressMasters {
        get {
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('', '--選択してください--'));
            for(AddressMaster__c address : [SELECT State__c         //漢字都道府県名
                                                  ,City__c          //漢字市区群名
                                                  ,Town__c          //漢字町村以下名
                                                  ,State_Kana__c    //カナ都道府県名
                                                  ,City_Kana__c     //カナ市区群名
                                                  ,Town_Kana__c     //カナ町村以下名
                                                  ,UniqueKey__c     //ユニークキー
                                              FROM AddressMaster__c 
                                             WHERE PostalCode__c =:PostCode
                                             ORDER BY Name ASC]){
                options.add(new SelectOption(address.UniqueKey__c, address.State__c + address.City__c + address.Town__c));
            }
            return options;
        }
    }

    public AddressSearchController (ApexPages.StandardController controller) {
        
        currentRecord = (Case)controller.getRecord();

        List<Case> cases = [SELECT CaseNumber
                                  ,PolicyholderZipCode__c               //契約者郵便番号
                                  ,ContractorAddress__c                 //契約者住所
                                  //,Policyholder_SAddressInKana__c       //契約者住所カナ

                                  ,CancellationCompletion_PostalCode__c //解約完了_送付先郵便番号
                                  ,CancellationCompletion_Address__c    //解約完了_送付先住所

                                  ,Incomplete_PostalCode__c             //書類不備_送付先郵便番号
                                  ,Incomplete_Address__c                //書類不備_送付先住所
                                
                                  ,PostalCode__c                        //送付先郵便番号
                                  ,MailingAddress__c                    //送付先住所

                                  ,Post_ChangeSubscriber_ZipCode__c     //（新）契約者郵便番号
                                  ,SubscribersAddressAfterChange1__c    //（新）契約者住所
                                  //,Post_ChangeSubscriber_AddressKana__c //（新）契約者住所カナ

                                  ,Insured_PostalCodeAfterChange__c     //（新）被保険者郵便番号
                                  ,Insured_AddressAfterChange1__c       //（新）被保険者住所
                                  //,Insured_AddressAfterChange_Kana__c   //（新）被保険者住所カナ
                                  ,RecordTypeId
                              FROM Case WHERE Id =:currentRecord.Id];
        caseRecord = cases.get(0);

        ModeFlag = '1';
        isShowButton = true;

        //レコードタイプの取得
        RecordTypes = [SELECT DeveloperName FROM RecordType WHERE Id =:caseRecord.RecordTypeId];
        
        //汎用、自動継続停止、証券再発行、自動車試算SDの場合
        if (RecordTypes[0].DeveloperName == 'GeneralPurpose' || 
            RecordTypes[0].DeveloperName == 'Auto_ContinuationStop' ||
            RecordTypes[0].DeveloperName == 'ReissuanceOfSecurities' ||
            RecordTypes[0].DeveloperName == 'SD') {
                isShowButton = false;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '郵便番号の入力はありません。'));
        }
    }

    //次へボタン
    public void goInsert() {
        ModeFlag = '2';

        if (TargetField == 'ContractorAddress__c') {
            //契約者住所（自動車新規）
            PostCodeLabel = Schema.SObjectType.Case.fields.PolicyholderZipCode__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.ContractorAddress__c.label;
            PostCode = caseRecord.PolicyholderZipCode__c;
            JusyoKanji = caseRecord.ContractorAddress__c;
        
        } else if (TargetField == 'SubscribersAddressAfterChange1__c') {
            //（新）契約者住所（火新異動、富国異動、自動車満期、自動車異動）
            PostCodeLabel = Schema.SObjectType.Case.fields.Post_ChangeSubscriber_ZipCode__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.SubscribersAddressAfterChange1__c.label;
            PostCode = caseRecord.Post_ChangeSubscriber_ZipCode__c;
            JusyoKanji = caseRecord.SubscribersAddressAfterChange1__c;
            
        } else if (TargetField == 'Insured_AddressAfterChange1__c') {
            //（新）被保険者住所（火新異動）
            PostCodeLabel = Schema.SObjectType.Case.fields.Insured_PostalCodeAfterChange__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.Insured_AddressAfterChange1__c.label;
            PostCode = caseRecord.Insured_PostalCodeAfterChange__c;
            JusyoKanji = caseRecord.Insured_AddressAfterChange1__c;
            
        } else if (TargetField == 'MailingAddress__c') {
            //送付先住所（自賠責解約）
            PostCodeLabel = Schema.SObjectType.Case.fields.PostalCode__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.MailingAddress__c.label;
            PostCode = caseRecord.PostalCode__c;
            JusyoKanji = caseRecord.MailingAddress__c;

        } else if (TargetField == 'Incomplete_Address__c') {
            //書類不備_送付先住所（自賠責解約）
            PostCodeLabel = Schema.SObjectType.Case.fields.Incomplete_PostalCode__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.Incomplete_Address__c.label;
            PostCode = caseRecord.Incomplete_PostalCode__c;
            JusyoKanji = caseRecord.Incomplete_Address__c;

        } else if (TargetField == 'CancellationCompletion_Address__c') {
            //解約完了_送付先住所（自賠責解約）
            PostCodeLabel = Schema.SObjectType.Case.fields.CancellationCompletion_PostalCode__c.label;
            JusyoKanjiLabel = Schema.SObjectType.Case.fields.CancellationCompletion_Address__c.label;
            PostCode = caseRecord.CancellationCompletion_PostalCode__c;
            JusyoKanji = caseRecord.CancellationCompletion_Address__c;
        }
    }

    //次へボタン
    public void goSearch() {

        if(isInputErrorCheck()) return;

        ModeFlag = '3';
    }

    //入力チェック
    public Boolean isInputErrorCheck(){

        if (String.isBlank(PostCode)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, PostCodeLabel + 'を入力してください。'));
            return true;
        }

        List<AddressMaster__c> AddressMasters = [SELECT Name FROM AddressMaster__c WHERE PostalCode__c =:PostCode];
        if (AddressMasters.isEmpty()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '入力された郵便番号が住所マスタに存在しません。'));
            return true;
        }

        return false;
    }

    //決定ボタン
    public PageReference confirm(){

        if(updateCase()) return null;

        String prevURL = '/' + caseRecord.Id;
        PageReference pageRef = new PageReference(prevURL);
        return pageRef; 
    }

    public Boolean updateCase(){

        try{
            List<AddressMaster__c> AddressMasters = [SELECT State__c        //漢字都道府県名
                                                           ,City__c         //漢字市区群名
                                                           ,Town__c         //漢字町村以下名
                                                           ,State_Kana__c   //カナ都道府県名
                                                           ,City_Kana__c    //カナ市区群名
                                                           ,Town_Kana__c    //カナ町村以下名
                                                           ,PostalCode__c   //郵便番号
                                                       FROM AddressMaster__c 
                                                      WHERE UniqueKey__c =:UniqueKey];
            
            String UpdPostCode = AddressMasters[0].PostalCode__c;
            String UpdJusyoKanji = AddressMasters[0].State__c + AddressMasters[0].City__c + AddressMasters[0].Town__c;
            String UpdJusyoKana = AddressMasters[0].State_Kana__c + AddressMasters[0].City_Kana__c + AddressMasters[0].Town_Kana__c;
            
            Case caseRcd = new Case();
            caseRcd.Id = caseRecord.Id;

            if (TargetField == 'ContractorAddress__c') {
                //契約者住所（自動車新規）
                caseRcd.PolicyholderZipCode__c = UpdPostCode;           //契約者郵便番号            
                caseRcd.ContractorAddress__c = UpdJusyoKanji;           //契約者住所                 
                caseRcd.Policyholder_SAddressInKana__c = UpdJusyoKana;  //契約者住所カナ  
            
            } else if (TargetField == 'SubscribersAddressAfterChange1__c') {
                //（新）契約者住所（火新異動、富国異動、自動車満期、自動車異動）
                caseRcd.Post_ChangeSubscriber_ZipCode__c = UpdPostCode;         //（新）契約者郵便番号
                caseRcd.SubscribersAddressAfterChange1__c = UpdJusyoKanji;      //（新）契約者住所
                caseRcd.Post_ChangeSubscriber_AddressKana__c = UpdJusyoKana;    //（新）契約者住所カナ
                
            } else if (TargetField == 'Insured_AddressAfterChange1__c') {
                //（新）被保険者住所（火新異動）
                caseRcd.Insured_PostalCodeAfterChange__c = UpdPostCode;     //（新）被保険者郵便番号
                caseRcd.Insured_AddressAfterChange1__c = UpdJusyoKanji;     //（新）被保険者住所
                caseRcd.Insured_AddressAfterChange_Kana__c = UpdJusyoKana;  //（新）被保険者住所カナ
                
            } else if (TargetField == 'MailingAddress__c') {
                //送付先住所（自賠責解約）
                caseRcd.PostalCode__c = UpdPostCode;        //送付先郵便番号
                caseRcd.MailingAddress__c = UpdJusyoKanji;  //送付先住所
    
            } else if (TargetField == 'Incomplete_Address__c') {
                //書類不備_送付先住所（自賠責解約）
                caseRcd.Incomplete_PostalCode__c = UpdPostCode; //書類不備_送付先郵便番号
                caseRcd.Incomplete_Address__c = UpdJusyoKanji;  //書類不備_送付先住所

            } else if (TargetField == 'CancellationCompletion_Address__c') {
                //解約完了_送付先住所（自賠責解約）
                caseRcd.CancellationCompletion_PostalCode__c = UpdPostCode; //解約完了_送付先郵便番号
                caseRcd.CancellationCompletion_Address__c = UpdJusyoKanji;  //解約完了_送付先住所
            }

            update caseRcd;

            return false;
            
        }catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return true;
        }
    }

    //戻るボタン
    public void goBackSelect(){
        ModeFlag = '1';
    }

    //戻るボタン
    public void goBackInsert(){
        ModeFlag = '2';
    }

    //キャンセルボタン
    public PageReference goBack(){
        String prevURL = '/' + caseRecord.Id;
        PageReference pageRef = new PageReference(prevURL);
        return pageRef; 
    }
}