public with sharing class ReportDocumentPreController {
    public Case currentRecord{get; set;}
    private Case caseRecord;

    public Boolean isShowReport1_1{get; set;}
    public Boolean isShowReport1_2{get; set;}
    public Boolean isShowReport1_3{get; set;}
    public Boolean isShowReport1_4{get; set;}
    public Boolean isShowReport1_5{get; set;}
    public Boolean isShowReport1_6{get; set;}
    public Boolean isShowReport1_7{get; set;}
    public Boolean isShowReport1_8{get; set;}
    public Boolean isShowReport2_1{get; set;}
    public Boolean isShowReport2_2{get; set;}
    public Boolean isShowReport2_3{get; set;}
    public Boolean isShowReport2_4{get; set;}
    public Boolean isShowReport2_5{get; set;}
    public Boolean isShowReport3_1{get; set;}
    public Boolean isShowReport3_2{get; set;}
    public Boolean isShowReport3_3{get; set;}
    public Boolean isShowReport3_4{get; set;}
    public Boolean isShowReport3_5{get; set;}
    public Boolean isShowReport4_1{get; set;}
    public Boolean isShowReport4_2{get; set;}
    public Boolean isShowReport5_1{get; set;}
    public Boolean isShowReport5_2{get; set;}
    public Boolean isShowReport5_3{get; set;}
    public Boolean isShowReport6_1{get; set;}
    public Boolean isShowReport7_1{get; set;}
    public Boolean isShowReport7_2{get; set;}
    public Boolean isShowReport7_3{get; set;}
    public Boolean isShowReport8_1{get; set;}
    public Boolean isShowReport8_2{get; set;}
    public Boolean isShowReport8_3{get; set;}
    public Boolean isShowReport9_1{get; set;}
    public Boolean isShowReport10_1{get; set;}
    public Boolean isShowReport11_1{get; set;}
    public Boolean isShowReport11_2{get; set;}
    public Boolean isShowReport11_3{get; set;}
    public Boolean isShowReport12_1{get; set;}
    public Boolean isShowReport12_2{get; set;}
    public Boolean isShowReport12_3{get; set;}
    public Boolean isShowReport12_4{get; set;}
    public Boolean isShowReport13_1{get; set;}
    public Boolean isShowReport13_2{get; set;}
    public Boolean isShowReport14_1{get; set;}
    public Boolean isShowReport14_2{get; set;}
    public Boolean isShowReport15_1{get; set;}

    public Boolean isShowButton7_1{get; set;}
    public Boolean isShowButton7_2{get; set;}
    public Boolean isShowButton7_3{get; set;}
    public Boolean isShowButton8_1{get; set;}
    public Boolean isShowButton8_2{get; set;}
    public Boolean isShowButton8_3{get; set;}
    public Boolean isShowButton9_1{get; set;}
    public Boolean isShowButton10_1{get; set;}
    public Boolean isShowButton11_1{get; set;}
    public Boolean isShowButton11_2{get; set;}
    public Boolean isShowButton11_3{get; set;}
    public Boolean isShowButton12_1{get; set;}
    public Boolean isShowButton12_2{get; set;}
    public Boolean isShowButton12_3{get; set;}
    public Boolean isShowButton12_4{get; set;}
    public Boolean isShowButton13_1{get; set;}

    public Boolean isInsertMode{get;set;} //登録モードフラグ
    public Boolean isUpdate{get;set;} //更新済みフラグ
    public Boolean isShowGreeting{get; set;} //あいさつ文表示フラグ
    public Boolean isShowGreetingHosoku{get; set;} //あいさつ文補足表示フラグ
    public Boolean isShowEnclosure{get; set;} //今回お送りした書類表示フラグ
    public Boolean isShowReplyDoc{get; set;} //ご返送いただく書類表示フラグ
    public Boolean isShowCommunicationColumn{get; set;} //ご連絡事項表示フラグ
    public Boolean isShowCommunicationColumn2{get; set;} //ご連絡事項2表示フラグ
    public Boolean isShowInquiry{get; set;} //連絡先表示フラグ
    public Boolean isShowCheckDetail1{get; set;} //確認内容1表示フラグ
    public Boolean isShowCheckDetail2{get; set;} //確認内容2表示フラグ
    public Boolean isShowCheckDetail3{get; set;} //確認内容3表示フラグ
    public Boolean isShowSofuShorui{get; set;} //送付書類表示フラグ
    public Boolean isShowKigenDate{get; set;} //期限日表示フラグ
    public Boolean isShowReceptDetails{get; set;} //受付内容の区分表示フラグ
    public Boolean isShowFirstFeeTransDate{get; set;} //初回保険料振替日表示フラグ
    public Boolean isShowFirstFeeTransDateHosoku{get; set;} //初回保険料振替日補足表示フラグ

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
    public String SofuShorui{get; set;} //送付書類
    public case conditionCase{get; set;} //期限日
    public String ReceptDetails{get; set;} //受付内容の区分
    public String FirstFeeTransDate{get; set;} //初回保険料振替日
    public String FirstFeeTransDateHosoku{get; set;} //初回保険料振替日補足

    public List<SelectOption> SelectReceptDetails {
        get {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('', '-'));
            options.add(new SelectOption('電話', '電話'));
            options.add(new SelectOption('郵送', '郵送'));
            return options;
        }
    }

    public ReportDocumentPreController (ApexPages.StandardController controller) {
        
        currentRecord = (Case)controller.getRecord();

        List<Case> cases = [SELECT CaseNumber, RecordTypeId FROM Case WHERE Id =:currentRecord.Id];
        caseRecord = cases.get(0);

        //変数の初期化
        initVariable();
        initShowReport();
        //レコードタイプで判定
        judgementRecordType();
        initTemplate();
    }

    //変数の初期化
    public void initVariable() {
        isInsertMode = false;
        isUpdate = false;

        isShowGreeting = false;
        isShowGreetingHosoku = false;
        isShowEnclosure = false;
        isShowReplyDoc = false;
        isShowCommunicationColumn = false;
        isShowCommunicationColumn2 = false;
        isShowInquiry = false;
        isShowCheckDetail1 = false;
        isShowCheckDetail2 = false;
        isShowCheckDetail3 = false;
        isShowSofuShorui = false;
        isShowKigenDate = false;
        isShowFirstFeeTransDate = false;
        isShowFirstFeeTransDateHosoku = false;
        isShowReceptDetails = false;

        Greeting = ''; //あいさつ文
        GreetingHosoku = ''; //あいさつ文補足
        Enclosure = ''; //今回お送りした書類
        ReplyDoc = ''; //ご返送いただく書類
        CommunicationColumn = ''; //ご連絡事項
        CommunicationColumn2 = ''; //ご連絡事項2
        Inquiry = ''; //連絡先
        CheckItem1 = ''; //確認項目1
        CheckItem2 = ''; //確認項目2
        CheckItem3 = ''; //確認項目3
        CheckDetail1 = ''; //確認内容1
        CheckDetail2 = ''; //確認内容2
        CheckDetail3 = ''; //確認内容3
        SofuShorui = ''; //送付書類
        conditionCase = new Case(); //期限日
        ReceptDetails = ''; //受付内容の区分
        FirstFeeTransDate = ''; //初回保険料振替日
        FirstFeeTransDateHosoku = ''; //初回保険料振替日補足

        isShowButton7_1 = false;
        isShowButton7_2 = false;
        isShowButton7_3 = false;
        isShowButton8_1 = false;
        isShowButton8_2 = false;
        isShowButton8_3 = false;
        isShowButton9_1 = false;
        isShowButton10_1 = false;
        isShowButton11_1 = false;
        isShowButton11_2 = false;
        isShowButton11_3 = false;
        isShowButton12_1 = false;
        isShowButton12_2 = false;
        isShowButton12_3 = false;
        isShowButton12_4 = false;
        isShowButton13_1 = false;
    }

    public void initShowReport() {
        isShowReport1_1 = false;
        isShowReport1_2 = false;
        isShowReport1_3 = false;
        isShowReport1_4 = false;
        isShowReport1_5 = false;
        isShowReport1_6 = false;
        isShowReport1_7 = false;
        isShowReport1_8 = false;
        isShowReport2_1 = false;
        isShowReport2_2 = false;
        isShowReport2_3 = false;
        isShowReport2_4 = false;
        isShowReport2_5 = false;
        isShowReport3_1 = false;
        isShowReport3_2 = false;
        isShowReport3_3 = false;
        isShowReport3_4 = false;
        isShowReport3_5 = false;
        isShowReport4_1 = false;
        isShowReport4_2 = false;
        isShowReport5_1 = false;
        isShowReport5_2 = false;
        isShowReport5_3 = false;
        isShowReport6_1 = false;
        isShowReport7_1 = false;
        isShowReport7_2 = false;
        isShowReport7_3 = false;
        isShowReport8_1 = false;
        isShowReport8_2 = false;
        isShowReport8_3 = false;
        isShowReport9_1 = false;
        isShowReport10_1 = false;
        isShowReport11_1 = false;
        isShowReport11_2 = false;
        isShowReport11_3 = false;
        isShowReport12_1 = false;
        isShowReport12_2 = false;
        isShowReport12_3 = false;
        isShowReport12_4 = false;
        isShowReport13_1 = false;
        isShowReport13_2 = false;
        isShowReport14_1 = false;
        isShowReport14_2 = false;
        isShowReport15_1 = false;
    }
    //あいさつ文
    public List<SelectOption> GreetingItems{get; set;}
    public String GreetingTemplate{get;set;}
    public boolean hasGreetingItems{get;set;}

    //あいさつ文補足
    public List<SelectOption> GreetingHosokuItems{get; set;}
    public String GreetingHosokuTemplate{get;set;}
    public boolean hasGreetingHosokuItems{get;set;}
    
    //今回お送りした書類
    public List<SelectOption> EnclosureItems{get; set;}
    public String EnclosureTemplate{get;set;}
    public boolean hasEnclosureItems{get;set;}
    
    //ご返送いただく書類
    public List<SelectOption> ReplyDocItems{get; set;}
    public String ReplyDocTemplate{get;set;}
    public boolean hasReplyDocItems{get;set;}
    
    //送付書類
    public List<SelectOption> SofuShoruiItems{get; set;}
    public String SofuShoruiTemplate{get;set;}
    public boolean hasSofuShoruiItems{get;set;}

    //ご連絡事項
    public List<SelectOption> CommunicationColumnItems{get; set;}
    public String CommunicationColumnTemplate{get;set;}
    public boolean hasCommunicationColumnItems{get;set;}

    //連絡先
    public List<SelectOption> InquiryItems{get; set;}
    public String InquiryTemplate{get;set;}
    public boolean hasInquiryItems{get;set;}
    
    private void initTemplate(){
        //帳票テンプレートレコード取得
        List<ReportTemplate__c> templates = [Select Id,Name, Type__c From ReportTemplate__c ORDER BY Name ASC];
        
        //あいさつ文
        GreetingItems = new List<SelectOption>();
        GreetingItems.add(new SelectOption('-','-'));
        hasGreetingItems = false;

        //あいさつ文補足
        GreetingHosokuItems = new List<SelectOption>();
        GreetingHosokuItems.add(new SelectOption('-','-'));
        hasGreetingHosokuItems = false;

        //今回お送りした書類
        EnclosureItems = new List<SelectOption>();
        EnclosureItems.add(new SelectOption('-','-'));
        hasEnclosureItems = false;

        //ご返送いただく書類
        ReplyDocItems = new List<SelectOption>();
        ReplyDocItems.add(new SelectOption('-','-'));
        hasReplyDocItems = false;

        //送付書類
        SofuShoruiItems = new List<SelectOption>();
        SofuShoruiItems.add(new SelectOption('-','-'));
        hasSofuShoruiItems = false;

        //ご連絡事項
        CommunicationColumnItems = new List<SelectOption>();
        CommunicationColumnItems.add(new SelectOption('-','-'));
        hasCommunicationColumnItems = false;

        //連絡先
        InquiryItems = new List<SelectOption>();
        InquiryItems.add(new SelectOption('-','-'));
        hasInquiryItems = false;

        for(ReportTemplate__c template : templates){
            if(template.Type__c == 'あいさつ文'){
                hasGreetingItems = true;
                GreetingItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == 'あいさつ文補足'){
                hasGreetingHosokuItems = true;
                GreetingHosokuItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == '今回お送りした書類'){
                hasEnclosureItems = true;
                EnclosureItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == 'ご返送いただく書類'){
                hasReplyDocItems = true;
                ReplyDocItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == '送付書類'){
                hasSofuShoruiItems = true;
                SofuShoruiItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == 'ご連絡事項'){
                hasCommunicationColumnItems = true;
                CommunicationColumnItems.add(new SelectOption(template.Name,template.Name));

            }else if(template.Type__c == '連絡先'){
                hasInquiryItems = true;
                InquiryItems.add(new SelectOption(template.Name,template.Name));

            }
        }

    }

    public void changeGreetingTemplate(){
        system.debug(GreetingTemplate);
        if(GreetingTemplate == '-') return;
        Greeting = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = 'あいさつ文' And Name = :GreetingTemplate].get(0).Contents__c ;
    }

    public void changeGreetingHosokuTemplate(){
        system.debug(GreetingHosokuTemplate);
        if(GreetingHosokuTemplate == '-') return;
        GreetingHosoku = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = 'あいさつ文補足' And Name = :GreetingHosokuTemplate].get(0).Contents__c ;
    }

    public void changeEnclosureTemplate(){
        system.debug(EnclosureTemplate);
        if(EnclosureTemplate == '-') return;
        Enclosure = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = '今回お送りした書類' And Name = :EnclosureTemplate].get(0).Contents__c ;
    }

    public void changeReplyDocTemplate(){
        system.debug(ReplyDocTemplate);
        if(ReplyDocTemplate == '-') return;
        ReplyDoc = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = 'ご返送いただく書類' And Name = :ReplyDocTemplate].get(0).Contents__c ;
    }

    public void changeSofuShoruiTemplate(){
        system.debug(SofuShoruiTemplate);
        if(SofuShoruiTemplate == '-') return;
        SofuShorui = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = '送付書類' And Name = :SofuShoruiTemplate].get(0).Contents__c ;
    }

    public void changeCommunicationColumnTemplate(){
        system.debug(CommunicationColumnTemplate);
        if(CommunicationColumnTemplate == '-') return;
        CommunicationColumn = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = 'ご連絡事項' And Name = :CommunicationColumnTemplate].get(0).Contents__c ;
    }

    public void changeInquiryTemplate(){
        system.debug(InquiryTemplate);
        if(InquiryTemplate == '-') return;
        Inquiry = [Select Id,Name, Contents__c, Type__c From ReportTemplate__c 
            Where Type__c = '連絡先' And Name = :InquiryTemplate].get(0).Contents__c ;
    }

    //レコードタイプで判定
    public void judgementRecordType() {
        
        List<RecordType> RecordTypes = [SELECT DeveloperName FROM RecordType WHERE Id =:caseRecord.RecordTypeId];

        if (RecordTypes[0].DeveloperName == 'GeneralPurpose') {
            //汎用
            isShowReport1_2 = true;
            isShowReport1_5 = true;
            isShowReport1_6 = true;
            isShowReport1_7 = true;
            isShowReport1_8 = true;
            isShowReport2_1 = true;
            isShowReport2_2 = true;
            isShowReport2_3 = true;
            isShowReport2_5 = true;

        } else if (RecordTypes[0].DeveloperName == 'Fire') {
            //火新異動
            isShowReport1_3 = true;

        } else if (RecordTypes[0].DeveloperName == 'Auto_ContinuationStop') {
            //自動継続停止
            isShowReport1_1 = true;

        } else if (RecordTypes[0].DeveloperName == 'AutomotiveNew') {
            //自動車新規
            isShowReport3_1 = true;
            isShowReport3_3 = true;
            isShowReport3_4 = true;
            isShowReport5_1 = true;
            isShowReport6_1 = true;
            isShowReport7_1 = true;
            isShowReport7_2 = true;
            isShowReport8_2 = true;
            isShowReport9_1 = true;
            isShowReport10_1 = true;
            isShowReport11_1 = true;
            isShowReport12_1 = true;
            isShowReport12_2 = true;
            isShowReport12_3 = true;
            isShowReport12_4 = true;
            isShowReport14_1 = true;
            isShowReport14_2 = true;
                
        } else if (RecordTypes[0].DeveloperName == 'AutomobileMaturity') {
            //自動車満期
            isShowReport3_1 = true;
            isShowReport3_2 = true;
            isShowReport3_3 = true;
            isShowReport3_4 = true;
            isShowReport5_1 = true;
            isShowReport5_2 = true;
            isShowReport5_3 = true;
            isShowReport6_1 = true;
            isShowReport7_2 = true;
            isShowReport8_1 = true;
            isShowReport8_3 = true;
            isShowReport9_1 = true;
            isShowReport11_1 = true;
            isShowReport11_2 = true;
            isShowReport11_3 = true;
            isShowReport12_1 = true;
            isShowReport12_2 = true;
            isShowReport12_3 = true;
            isShowReport12_4 = true;
            isShowReport13_2 = true;
            isShowReport14_1 = true;
            isShowReport14_2 = true;

        } else if (RecordTypes[0].DeveloperName == 'AutomobileTransfers') {
            //自動車異動
            isShowReport3_1 = true;
            isShowReport3_4 = true;
            isShowReport5_1 = true;
            isShowReport5_2 = true;
            isShowReport6_1 = true;
            isShowReport7_2 = true;
            isShowReport7_3 = true;
            isShowReport8_1 = true;
            isShowReport11_1 = true;
            //isShowReport13_2 = true;
                
        } else if (RecordTypes[0].DeveloperName == 'TransferOfWealth') {
            //富国異動
            isShowReport3_1 = true;
            isShowReport3_5 = true;
            isShowReport4_1 = true;
            isShowReport4_2 = true;
            isShowReport6_1 = true;
            isShowReport7_2 = true;
            isShowReport7_3 = true;
            isShowReport8_1 = true;
            isShowReport11_1 = true;
            //isShowReport13_2 = true;
            isShowReport15_1 = true;

        } else if (RecordTypes[0].DeveloperName == 'ReissuanceOfSecurities') {
            //証券再発行
            isShowReport1_4 = true;

        } else if (RecordTypes[0].DeveloperName == 'IndemnityTermination') {
            //自賠責解約
            isShowReport2_4 = true;

        } else if (RecordTypes[0].DeveloperName == 'SD') {
            //自動車試算SD
            isShowReport13_1 = true;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '出力対象の帳票はありません。'));
        }
    }

    public PageReference displayPDF1_1(){
        PageReference pageRef = Page.ReportDocument1_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-1'); 

        insertAttachment(pageRef, '1-1（営業店）継続案内DM_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_2(){
        PageReference pageRef = Page.ReportDocument1_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-2'); 

        insertAttachment(pageRef, '1-2（営業店）信金窓販_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_3(){
        PageReference pageRef = Page.ReportDocument1_3;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-3'); 

        insertAttachment(pageRef, '1-3（営業店）火新住変_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_4(){
        PageReference pageRef = Page.ReportDocument1_4;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-4'); 

        insertAttachment(pageRef, '1-4（営業店）証券再発行_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_5(){
        PageReference pageRef = Page.ReportDocument1_5;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-5'); 

        insertAttachment(pageRef, '1-5（営統企画）カードテレマインバウンド_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_6(){
        PageReference pageRef = Page.ReportDocument1_6;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-6'); 

        insertAttachment(pageRef, '1-6（営統企画）カードテレマインバウンド_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_7(){
        PageReference pageRef = Page.ReportDocument1_7;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-7'); 

        insertAttachment(pageRef, '1-7（関西京都）ニッセンDM_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF1_8(){
        PageReference pageRef = Page.ReportDocument1_8;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '1-8'); 

        insertAttachment(pageRef, '1-8（営業店）窓販職員_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF2_1(){
        PageReference pageRef = Page.ReportDocument2_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '2-1'); 

        insertAttachment(pageRef, '2-1（営業店）お問合せ窓口_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF2_2(){
        PageReference pageRef = Page.ReportDocument2_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '2-2'); 

        insertAttachment(pageRef, '2-2（営業店）契約確認DM_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF2_3(){
        PageReference pageRef = Page.ReportDocument2_3;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '2-3'); 

        insertAttachment(pageRef, '2-3（営業店）長期がん・医療_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF2_4(){
        PageReference pageRef = Page.ReportDocument2_4;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '2-4'); 

        insertAttachment(pageRef, '2-4（営業店）自賠責解約受付センター_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF2_5(){
        PageReference pageRef = Page.ReportDocument2_5;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '2-5'); 

        insertAttachment(pageRef, '2-5（営業店）文科省問合せ_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF3_1(){
        PageReference pageRef = Page.ReportDocument3_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '3-1'); 

        insertAttachment(pageRef, '3-1（営業店）自動車全般_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF3_2(){
        PageReference pageRef = Page.ReportDocument3_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '3-2'); 

        insertAttachment(pageRef, '3-2（営業店）自動車満期_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF3_3(){
        //PageReference pageRef = Page.ReportDocument3_3;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '3-3'); 

        //insertAttachment(pageRef, '3-3（営業店）重複未解消報告_対応依頼票');
        //return pageRef;
        
        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton202406130959579530t7');
        pr.getParameters().put('id', caseRecord.Id);
        return pr; 
    }

    public PageReference displayPDF3_4(){
        PageReference pageRef = Page.ReportDocument3_4;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '3-4'); 

        insertAttachment(pageRef, '3-4（営業店）【発信】自動車全般_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF3_5(){
        //PageReference pageRef = Page.ReportDocument3_5;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '3-5'); 

        //insertAttachment(pageRef, '3-5（相対店）富国解約試算_対応依頼票');
        //return pageRef;

        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton2024061309543825928t');
        pr.getParameters().put('id', caseRecord.Id);
        return pr; 
    }

    public PageReference displayPDF4_1(){
        PageReference pageRef = Page.ReportDocument4_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '4-1'); 

        insertAttachment(pageRef, '4-1（代理店）富国異動_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF4_2(){
        //PageReference pageRef = Page.ReportDocument4_2;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '4-2'); 

        //insertAttachment(pageRef, '4-2（代理店）富国解約_対応依頼票');
        //return pageRef;

        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton20240613100227120BNq');
        pr.getParameters().put('id', caseRecord.Id);
        return pr; 
    }

    public PageReference displayPDF5_1(){
        PageReference pageRef = Page.ReportDocument5_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '5-1'); 

        insertAttachment(pageRef, '5-1（代理店）自動車満期_対応依頼票');
        return pageRef; 
    }
    
    public PageReference displayPDF5_2(){
        PageReference pageRef = Page.ReportDocument5_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '5-2'); 

        insertAttachment(pageRef, '5-2（代理店）【発信】自動車満期_対応依頼票');
        return pageRef; 
    }

    public PageReference displayPDF5_3(){
        //PageReference pageRef = Page.ReportDocument5_3;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '5-3'); 

        //insertAttachment(pageRef, '5-3（代理店）【発信・電話不通】自動車満期_対応依頼票');
        //return pageRef;
        
        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton20240613100252240mAK');
        pr.getParameters().put('id', caseRecord.Id);
        return pr;
    }

    public PageReference displayPDF6_1(){
        PageReference pageRef = Page.ReportDocument6_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '6-1'); 

        insertAttachment(pageRef, '6-1各種書類訂正内容確認書_裏貼用');
        return pageRef; 
    }

    public PageReference displayPDF7_1(){
        PageReference pageRef = Page.ReportDocument7_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '7-1'); 

        insertAttachment(pageRef, '7-1（顧客）資料請求送付状');
        return pageRef; 
    }

    public PageReference displayPDF7_2(){
        PageReference pageRef = Page.ReportDocument7_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '7-2');  

        insertAttachment(pageRef, '7-2（顧客）不備書類再送送付状');
        return pageRef;
    }

    public PageReference displayPDF7_3(){
        PageReference pageRef = Page.ReportDocument7_3;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '7-3');  

        insertAttachment(pageRef, '7-3（顧客）自動車異動フォローレター');
        return pageRef;
    }

    public PageReference displayPDF8_1(){
        PageReference pageRef = Page.ReportDocument8_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '8-1');  

        insertAttachment(pageRef, '8-1（顧客）不備入電依頼_期日なし');
        return pageRef;
    }

    public PageReference displayPDF8_2(){
        PageReference pageRef = Page.ReportDocument8_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '8-2');  

        insertAttachment(pageRef, '8-2（顧客）自動車新規フォローレター');
        return pageRef;
    }

    public PageReference displayPDF8_3(){
        PageReference pageRef = Page.ReportDocument8_3;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '8-3');  

        insertAttachment(pageRef, '8-3（顧客）自動車満期フォローレター');
        return pageRef;
    }

    public PageReference displayPDF9_1(){
        //PageReference pageRef = Page.ReportDocument9_1;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '9-1');  

        //insertAttachment(pageRef, '9-1（顧客）不備入電依頼_期日あり');
        //return pageRef;

        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton20240613100309398Fuw');
        pr.getParameters().put('id', caseRecord.Id);
        return pr;
    }

    public PageReference displayPDF10_1(){
        PageReference pageRef = Page.ReportDocument10_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '10-1');  

        insertAttachment(pageRef, '10-1（顧客）新規見積り送付状');
        return pageRef;
    }

    public PageReference displayPDF11_1(){
        PageReference pageRef = Page.ReportDocument11_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '11-1');  

        insertAttachment(pageRef, '11-1（顧客）自動車送付状_再送用');
        return pageRef;
    }

    public PageReference displayPDF11_2(){
        PageReference pageRef = Page.ReportDocument11_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '11-2');  

        insertAttachment(pageRef, '11-2（顧客）自動車送付状_満期初回');
        return pageRef;
    }

    public PageReference displayPDF11_3(){
        //PageReference pageRef = Page.ReportDocument11_3;
        //pageRef.getParameters().put('Id', caseRecord.Id);
        //pageRef.getParameters().put('cId', '11-3');  

        //insertAttachment(pageRef, '11-3（顧客）自動車送付状_満期初回NF多割');
        //return pageRef;

        PageReference pr = new PageReference('/apex/svfcloud__PreviewPage');
        pr.getParameters().put('buttonFullName', 'SVFCaseButton20240613100325098Z3c');
        pr.getParameters().put('id', caseRecord.Id);
        return pr;
    }

    public PageReference displayPDF12_1(){
        PageReference pageRef = Page.ReportDocument12_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '12-1');  

        insertAttachment(pageRef, '12-1（顧客）通知書');
        return pageRef;
    }

    public PageReference displayPDF12_2(){
        PageReference pageRef = Page.ReportDocument12_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '12-2');  

        insertAttachment(pageRef, '12-2（顧客）通知書_重複未解消');
        return pageRef;
    }

    public PageReference displayPDF12_3(){
        PageReference pageRef = Page.ReportDocument12_3;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '12-3');  

        insertAttachment(pageRef, '12-3（顧客）通知書_月ズレ計上');
        return pageRef;
    }

    public PageReference displayPDF12_4(){
        PageReference pageRef = Page.ReportDocument12_4;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '12-4');  

        insertAttachment(pageRef, '12-4（顧客）通知書_コンビニ');
        return pageRef;
    }

    public PageReference displayPDF13_1(){
        PageReference pageRef = Page.ReportDocument13_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '13-1');  

        insertAttachment(pageRef, '13-1（代理店SD）試算結果送付状');
        return pageRef;
    }

    public PageReference displayPDF13_2(){
        PageReference pageRef = Page.ReportDocument13_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '13-2');  

        insertAttachment(pageRef, '13-2（代理店）満期対象外書類回送送付状');
        return pageRef;
    }

    public PageReference displayPDF14_1(){
        PageReference pageRef = Page.ReportDocument14_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '14-1');  

        insertAttachment(pageRef, '14-1（代理店）構成員確認書作成依頼状');
        return pageRef;
    }

    public PageReference displayPDF14_2(){
        PageReference pageRef = Page.ReportDocument14_2;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '14-2');  

        insertAttachment(pageRef, '14-2（代理店）月ズレ計上連絡票');
        return pageRef;
    }

    public PageReference displayPDF15_1(){
        PageReference pageRef = Page.ReportDocument15_1;
        pageRef.getParameters().put('Id', caseRecord.Id);
        pageRef.getParameters().put('cId', '15-1');  

        insertAttachment(pageRef, '15-1（営開業務）移管契約計上連絡票');
        return pageRef;
    }

    public void displayEntryForm7_1(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton7_1 = true;
    }

    public void displayEntryForm7_2(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowReplyDoc = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton7_2 = true;
    }

    public void displayEntryForm7_3(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowReplyDoc = true;
        //isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton7_3 = true;
    }

    public void displayEntryForm8_1(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowInquiry = true;

        isShowButton8_1 = true;
    }

    public void displayEntryForm8_2(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowInquiry = true;

        isShowButton8_2 = true;
    }

    public void displayEntryForm8_3(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowInquiry = true;

        isShowButton8_3 = true;
    }

    public void displayEntryForm9_1(){
        isInsertMode = true;

        isShowCheckDetail1 = true;
        isShowCheckDetail2 = true;
        isShowCheckDetail3 = true;
        isShowKigenDate = true;
        isShowInquiry = true;

        isShowButton9_1 = true;
    }

    public void displayEntryForm10_1(){
        isInsertMode = true;

        isShowSofuShorui = true;
        isShowInquiry = true;

        isShowButton10_1 = true;
    }

    public void displayEntryForm11_1(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowReplyDoc = true;
        isShowCommunicationColumn = true;
        isShowKigenDate = true;
        isShowInquiry = true;

        isShowButton11_1 = true;
    }

    public void displayEntryForm11_2(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowReplyDoc = true;
        isShowKigenDate = true;
        isShowInquiry = true;

        isShowButton11_2 = true;
    }

    public void displayEntryForm11_3(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowReplyDoc = true;
        isShowKigenDate = true;
        isShowInquiry = true;

        isShowButton11_3 = true;
    }

    public void displayEntryForm12_1(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowGreetingHosoku = true;
        isShowReceptDetails = true;
        //isShowFirstFeeTransDate = true;
        //isShowFirstFeeTransDateHosoku = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton12_1 = true;
    }

    public void displayEntryForm12_2(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowGreetingHosoku = true;
        isShowReceptDetails = true;
        //isShowFirstFeeTransDate = true;
        //isShowFirstFeeTransDateHosoku = true;
        isShowCommunicationColumn = true;
        //isShowCommunicationColumn2 = true;
        isShowInquiry = true;

        isShowButton12_2 = true;
    }

    public void displayEntryForm12_3(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowGreetingHosoku = true;
        isShowReceptDetails = true;
        isShowFirstFeeTransDate = true;
        //isShowFirstFeeTransDateHosoku = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton12_3 = true;
    }

    public void displayEntryForm12_4(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowGreetingHosoku = true;
        isShowReceptDetails = true;
        //isShowFirstFeeTransDate = true;
        //isShowFirstFeeTransDateHosoku = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton12_4 = true;
    }

    public void displayEntryForm13_1(){
        isInsertMode = true;

        isShowGreeting = true;
        isShowEnclosure = true;
        isShowCommunicationColumn = true;
        isShowInquiry = true;

        isShowButton13_1 = true;
    }

    //確定ボタン
    public void confirm(){

        if(isInputErrorCheck()) return;

        if(updateCase()) return;

        isUpdate = true;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '帳票出力準備ができました。帳票を出力してください。'));
    }

    //入力チェック
    public Boolean isInputErrorCheck(){

        String errorField ='';

        if (isShowGreeting && String.isBlank(Greeting)) errorField +='「あいさつ文」';
        //if (isShowGreetingHosoku && String.isBlank(GreetingHosoku)) errorField +='「あいさつ文補足」';
        if (isShowEnclosure && String.isBlank(Enclosure)) errorField +='「今回お送りした書類」';
        if (isShowReplyDoc && String.isBlank(ReplyDoc)) errorField +='「ご返送いただく書類」';
        if (isShowReceptDetails && String.isBlank(ReceptDetails)) errorField +='「受付内容の区分」';
        if (isShowFirstFeeTransDate && String.isBlank(FirstFeeTransDate)) errorField +='「初回保険料振替日」';
        if (isShowFirstFeeTransDateHosoku && String.isBlank(FirstFeeTransDateHosoku)) errorField +='「初回保険料振替日補足」';
        //if (isShowCommunicationColumn && String.isBlank(CommunicationColumn)) errorField +='「ご連絡事項」';
        //if (isShowCommunicationColumn2 && String.isBlank(CommunicationColumn2)) errorField +='「ご連絡事項2」';
        if (isShowCheckDetail1 && String.isBlank(CheckItem1)) errorField +='「確認事項1」';
        if (isShowCheckDetail1 && String.isBlank(CheckDetail1)) errorField +='「確認内容1」';
        if (isShowSofuShorui && String.isBlank(SofuShorui)) errorField +='「送付書類」';
        if (isShowKigenDate && conditionCase.KigenDate__c == null) errorField +='「期限日」';
        if (isShowInquiry && String.isBlank(Inquiry)) errorField +='「連絡先」';

        if(!String.isEmpty(errorField)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorField + 'を入力してください。'));
            return true;
        }

        return false;
    }

    //帳票選択に戻るボタン
    public void goSelect(){
        initVariable();
    }

    public Boolean updateCase(){
        try{
            Case caseRcd = new Case();
            caseRcd.Id = caseRecord.Id;
            caseRcd.Greeting__c = Greeting; //あいさつ文
            caseRcd.GreetingHosoku__c = GreetingHosoku; //あいさつ文補足
            caseRcd.Enclosure__c = Enclosure; //今回お送りした書類
            caseRcd.ReplyDoc__c = ReplyDoc; //ご返送いただく書類
            caseRcd.CommunicationColumn__c = CommunicationColumn; //ご連絡事項
            caseRcd.CommunicationColumn2__c = CommunicationColumn2; //ご連絡事項2
            caseRcd.Inquiry__c = Inquiry; //連絡先
            caseRcd.CheckItem1__c = CheckItem1; //確認項目1
            caseRcd.CheckItem2__c = CheckItem2; //確認項目2
            caseRcd.CheckItem3__c = CheckItem3; //確認項目3
            caseRcd.CheckDetail1__c = CheckDetail1; //確認内容1
            caseRcd.CheckDetail2__c = CheckDetail2; //確認内容2
            caseRcd.CheckDetail3__c = CheckDetail3; //確認内容3
            caseRcd.SofuShorui__c = SofuShorui; //送付書類
            caseRcd.KigenDate__c = conditionCase.KigenDate__c; //期限日
            caseRcd.ReceptDetails__c = ReceptDetails; //受付内容の区分
            caseRcd.FirstFeeTransDate__c = FirstFeeTransDate; //初回保険料振替日
            //caseRcd.FirstFeeTransDateHosoku__c = FirstFeeTransDateHosoku; //初回保険料振替日補足
            update caseRcd;

            return false;
            
        }catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return true;
        }
    }

    public void insertAttachment(PageReference page, String ReportTitle){
        Attachment caseAttachment = new Attachment();
        caseAttachment.Name = ReportTitle + '_' + Datetime.now().format('yyyy-MM-dd') + '_' + caseRecord.CaseNumber + '.pdf';
        caseAttachment.Body = Test.isRunningTest()? Blob.valueof('test') : page.getContent();
        caseAttachment.ParentId = caseRecord.Id;
        insert caseAttachment;
    }

    //戻るボタン
    public PageReference goBack(){
        String prevURL = '/' + caseRecord.Id;
        PageReference pageRef = new PageReference(prevURL);
        return pageRef; 
    }
}