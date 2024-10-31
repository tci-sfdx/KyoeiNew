@isTest
public class ReportDocumentPreControllerTest {
    //テストデータ
    @testSetup
    private static void createTestDatas() {

        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = a1.Id;
        ca1.contactId = con1.Id;
        ca1.counterparty_Kana__c = 'テストカナ１';
        ca1.InquiryDetails__c = 'テスト問い合わせ詳細';
        ca1.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('GeneralPurpose').getRecordTypeId();
        insert ca1;

        //帳票文言マスタ
        WordMaster__c word = new WordMaster__c();
        word.Name = 'テスト帳票';
        insert word;

        //帳票テンプレート
        List<ReportTemplate__c> repoTemps = new List<ReportTemplate__c>();
        
        ReportTemplate__c repoTemp1 = new ReportTemplate__c();
        repoTemp1.Name = 'あいさつ文A';
        repoTemp1.Type__c = 'あいさつ文';
        repoTemp1.Contents__c = 'あいさつ文１２３４５６７８９０';
        repoTemps.add(repoTemp1);

        ReportTemplate__c repoTemp2 = new ReportTemplate__c();
        repoTemp2.Name = 'あいさつ文補足A';
        repoTemp2.Type__c = 'あいさつ文補足';
        repoTemp2.Contents__c = 'あいさつ文補足１２３４５６７８９０';
        repoTemps.add(repoTemp2);

        ReportTemplate__c repoTemp3 = new ReportTemplate__c();
        repoTemp3.Name = '今回お送りした書類A';
        repoTemp3.Type__c = '今回お送りした書類';
        repoTemp3.Contents__c = '今回お送りした書類１２３４５６７８９０';
        repoTemps.add(repoTemp3);

        ReportTemplate__c repoTemp4 = new ReportTemplate__c();
        repoTemp4.Name = 'ご返送いただく書類A';
        repoTemp4.Type__c = 'ご返送いただく書類';
        repoTemp4.Contents__c = 'ご返送いただく書類１２３４５６７８９０';
        repoTemps.add(repoTemp4);

        ReportTemplate__c repoTemp5 = new ReportTemplate__c();
        repoTemp5.Name = '送付書類A';
        repoTemp5.Type__c = '送付書類';
        repoTemp5.Contents__c = '送付書類１２３４５６７８９０';
        repoTemps.add(repoTemp5);

        ReportTemplate__c repoTemp6 = new ReportTemplate__c();
        repoTemp6.Name = 'ご連絡事項A';
        repoTemp6.Type__c = 'ご連絡事項';
        repoTemp6.Contents__c = 'ご連絡事項１２３４５６７８９０';
        repoTemps.add(repoTemp6);

        ReportTemplate__c repoTemp7 = new ReportTemplate__c();
        repoTemp7.Name = '連絡先A';
        repoTemp7.Type__c = '連絡先';
        repoTemp7.Contents__c = '連絡先１２３４５６７８９０';
        repoTemps.add(repoTemp7);

        insert repoTemps;
    }

    private static testMethod void ChohyoCreateTest() {
        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テストカナ１'];

        PageReference pageRef = Page.ReportDocumentPrePage;
        //pageRef.getParameters().put('Id', caseList[0].Id);
        //pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        ReportDocumentPreController ctrl = new ReportDocumentPreController(stdCon) ;

        //受付内容の区分の選択リスト
        List<SelectOption> receptDetails = ctrl.SelectReceptDetails;

        //帳票テンプレートの選択
        ctrl.GreetingTemplate = 'あいさつ文A';
        ctrl.changeGreetingTemplate();

        ctrl.GreetingHosokuTemplate = 'あいさつ文補足A';
        ctrl.changeGreetingHosokuTemplate();

        ctrl.EnclosureTemplate = '今回お送りした書類A';
        ctrl.changeEnclosureTemplate();

        ctrl.ReplyDocTemplate = 'ご返送いただく書類A';
        ctrl.changeReplyDocTemplate();

        ctrl.SofuShoruiTemplate = '送付書類A';
        ctrl.changeSofuShoruiTemplate();

        ctrl.CommunicationColumnTemplate = 'ご連絡事項A';
        ctrl.changeCommunicationColumnTemplate();

        ctrl.InquiryTemplate = '連絡先A';
        ctrl.changeInquiryTemplate();

        //帳票選択に戻るボタン
        ctrl.goSelect();
        //戻るボタン
        PageReference pageRefGoback = ctrl.goBack();

        //各帳票表示ボタン
        PageReference pageRef1_1 = ctrl.displayPDF1_1();
        PageReference pageRef1_2 = ctrl.displayPDF1_2();
        PageReference pageRef1_3 = ctrl.displayPDF1_3();
        PageReference pageRef1_4 = ctrl.displayPDF1_4();
        PageReference pageRef1_5 = ctrl.displayPDF1_5();
        PageReference pageRef1_6 = ctrl.displayPDF1_6();
        PageReference pageRef1_7 = ctrl.displayPDF1_7();
        PageReference pageRef1_8 = ctrl.displayPDF1_8();

        PageReference pageRef2_1 = ctrl.displayPDF2_1();
        PageReference pageRef2_2 = ctrl.displayPDF2_2();
        PageReference pageRef2_3 = ctrl.displayPDF2_3();
        PageReference pageRef2_4 = ctrl.displayPDF2_4();
        PageReference pageRef2_5 = ctrl.displayPDF2_5();

        PageReference pageRef3_1 = ctrl.displayPDF3_1();
        PageReference pageRef3_2 = ctrl.displayPDF3_2();
        PageReference pageRef3_3 = ctrl.displayPDF3_3();
        PageReference pageRef3_4 = ctrl.displayPDF3_4();
        PageReference pageRef3_5 = ctrl.displayPDF3_5();

        PageReference pageRef4_1 = ctrl.displayPDF4_1();
        PageReference pageRef4_2 = ctrl.displayPDF4_2();

        PageReference pageRef5_1 = ctrl.displayPDF5_1();
        PageReference pageRef5_2 = ctrl.displayPDF5_2();
        PageReference pageRef5_3 = ctrl.displayPDF5_3();

        PageReference pageRef6_1 = ctrl.displayPDF6_1();

        ctrl.displayEntryForm7_1();
        //未入力
        ctrl.confirm();
        //入力
        ctrl.Greeting = 'テスト';
        ctrl.Enclosure = 'テスト';
        ctrl.ReplyDoc = 'テスト';
        ctrl.CommunicationColumn = 'テスト';
        ctrl.Inquiry = 'テスト';
        ctrl.confirm();
        PageReference pageRef7_1 = ctrl.displayPDF7_1();

        ctrl.displayEntryForm7_2();
        ctrl.confirm();
        PageReference pageRef7_2 = ctrl.displayPDF7_2();

        ctrl.displayEntryForm7_3();
        ctrl.confirm();
        PageReference pageRef7_3 = ctrl.displayPDF7_3();

        ctrl.displayEntryForm8_1();
        ctrl.confirm();
        PageReference pageRef8_1 = ctrl.displayPDF8_1();

        ctrl.displayEntryForm8_2();
        ctrl.confirm();
        PageReference pageRef8_2 = ctrl.displayPDF8_2();

        ctrl.displayEntryForm8_3();
        ctrl.confirm();
        PageReference pageRef8_3 = ctrl.displayPDF8_3();

        ctrl.displayEntryForm9_1();
        ctrl.confirm();
        PageReference pageRef9_1 = ctrl.displayPDF9_1();

        ctrl.displayEntryForm10_1();
        ctrl.confirm();
        PageReference pageRef10_1 = ctrl.displayPDF10_1();

        ctrl.displayEntryForm11_1();
        ctrl.confirm();
        PageReference pageRef11_1 = ctrl.displayPDF11_1();

        ctrl.displayEntryForm11_2();
        ctrl.confirm();
        PageReference pageRef11_2 = ctrl.displayPDF11_2();

        ctrl.displayEntryForm11_3();
        ctrl.confirm();
        PageReference pageRef11_3 = ctrl.displayPDF11_3();

        ctrl.displayEntryForm12_1();
        ctrl.confirm();
        PageReference pageRef12_1 = ctrl.displayPDF12_1();

        ctrl.displayEntryForm12_2();
        ctrl.confirm();
        PageReference pageRef12_2 = ctrl.displayPDF12_2();

        ctrl.displayEntryForm12_3();
        ctrl.confirm();
        PageReference pageRef12_3 = ctrl.displayPDF12_3();

        ctrl.displayEntryForm12_4();
        ctrl.confirm();
        PageReference pageRef12_4 = ctrl.displayPDF12_4();

        ctrl.displayEntryForm13_1();
        ctrl.confirm();
        PageReference pageRef13_1 = ctrl.displayPDF13_1();

        PageReference pageRef13_2 = ctrl.displayPDF13_2();

        PageReference pageRef14_1 = ctrl.displayPDF14_1();
        PageReference pageRef14_2 = ctrl.displayPDF14_2();
        PageReference pageRef15_1 = ctrl.displayPDF15_1();
    }

    //自動車新規
    private static testMethod void ShowTestAutomotiveNew() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ１';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomotiveNew').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ１'];

        PageReference pageRef = Page.ReportDocumentPrePage;
        //pageRef.getParameters().put('Id', caseList[0].Id);
        //pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        ReportDocumentPreController ctrl = new ReportDocumentPreController(stdCon);
    }

    //自動車満期
    private static testMethod void ShowTestAutomobileMaturity() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ２';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomobileMaturity').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ２'];

        PageReference pageRef = Page.ReportDocumentPrePage;
        //ageRef.getParameters().put('Id', caseList[0].Id);
        //pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        ReportDocumentPreController ctrl = new ReportDocumentPreController(stdCon);
    }

    //自動車異動
    private static testMethod void ShowTestAutomobileTransfers() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ３';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomobileTransfers').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ３'];

        PageReference pageRef = Page.ReportDocumentPrePage;
        //pageRef.getParameters().put('Id', caseList[0].Id);
        //pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        ReportDocumentPreController ctrl = new ReportDocumentPreController(stdCon);
    }

    //富国異動
    private static testMethod void ShowTestTransferOfWealth() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ４';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('TransferOfWealth').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ４'];

        PageReference pageRef = Page.ReportDocumentPrePage;
        //pageRef.getParameters().put('Id', caseList[0].Id);
        //pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        ReportDocumentPreController ctrl = new ReportDocumentPreController(stdCon);
    }
}