@isTest
public class AddressSearchControllerTest {
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

        //住所マスタ
        List<AddressMaster__c> addressMasters = new List<AddressMaster__c>();
        
        AddressMaster__c address1 = new AddressMaster__c();
        address1.PostalCode__c = '1500011';
        address1.State__c = '東京都';
        address1.City__c = '渋谷区';
        address1.Town__c = '東１丁目';
        address1.UniqueKey__c = '1500011東京都渋谷区東１丁目';
        addressMasters.add(address1);

        insert addressMasters;
    }

    //自動車新規　契約者住所
    private static testMethod void SearchTest_ContractorAddress() {

        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ１';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomotiveNew').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ１'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //戻るボタン
        PageReference pageRefGoback = ctrl.goBack();

        //対象項目の選択
        ctrl.TargetField = 'ContractorAddress__c'; //契約者住所
        //次へボタン
        ctrl.goInsert();
        //戻るボタン
        ctrl.goBackSelect();
        //次へボタン
        ctrl.goInsert();

        //郵便番号未入力
        ctrl.PostCode = '';
        ctrl.goSearch();

        //郵便番号該当なし
        ctrl.PostCode = '1600024';
        ctrl.goSearch();

        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        ctrl.goSearch();

        //戻るボタン
        ctrl.goBackInsert();

        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //火新異動　（新）契約者住所
    private static testMethod void SearchTest_SubscribersAddressAfterChange1() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ２';
        ca1.ReceiptItem_Reason_Multi__c = '契約者住所変更'; //受付項目（事由）_複数
        ca1.DateOfTransfer__c = system.today(); //異動日
        ca1.ChangeOfAddress__c = '無し'; //被保険者住所変更有無
        ca1.MovedOut__c = '転居済'; //転居済
        ca1.Post_ChangeSubscriber_ZipCode__c = '1600023'; //（新）契約者郵便番号
        ca1.SubscribersAddressAfterChange1__c = '東京都新宿区'; //（新）契約者住所
        ca1.Post_ChangeSubscriber_AddressKana__c = 'ｼﾞｭｳｼｮｶﾅ'; //（新）契約者住所カナ
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Fire').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ２'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'SubscribersAddressAfterChange1__c'; //（新）契約者住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //火新異動　（新）被保険者住所
    private static testMethod void SearchTest_Insured_AddressAfterChange1() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ３';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Fire').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ３'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'Insured_AddressAfterChange1__c'; //（新）被保険者住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //自賠責解約　送付先住所
    private static testMethod void SearchTest_MailingAddress() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ４';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('IndemnityTermination').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ４'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'MailingAddress__c'; //送付先住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //自賠責解約　書類不備_送付先住所
    private static testMethod void SearchTest_Incomplete_Address() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ５';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('IndemnityTermination').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ５'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'Incomplete_Address__c'; //書類不備_送付先住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //自賠責解約　解約完了_送付先住所
    private static testMethod void SearchTest_CancellationCompletion_Address() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ６';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('IndemnityTermination').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ６'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'CancellationCompletion_Address__c'; //解約完了_送付先住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //富国異動　（新）契約者住所
    private static testMethod void SearchTest_TransferOfWealth() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ７';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('TransferOfWealth').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ７'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'SubscribersAddressAfterChange1__c'; //（新）契約者住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //自動車満期　（新）契約者住所
    private static testMethod void SearchTest_AutomobileMaturity() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ８';
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomobileMaturity').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ８'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'SubscribersAddressAfterChange1__c'; //（新）契約者住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }

    //自動車異動　（新）契約者住所
    private static testMethod void SearchTest_AutomobileTransfers() {
        //Case
        Case ca1 = new Case();
        ca1.ReferenceAccount__c = [SELECT Name FROM Account LIMIT 1].Id;
        ca1.contactId = [SELECT Name FROM Contact LIMIT 1].Id;
        ca1.counterparty_Kana__c = 'テスト入電者カナ９';
        ca1.ChangeOfSubscriberInformation__c ='有'; //契約者情報変更の有無
        ca1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('AutomobileTransfers').getRecordTypeId();
        insert ca1;

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case WHERE counterparty_Kana__c = 'テスト入電者カナ９'];

        PageReference pageRef = Page.AddressSearchPage;
        Test.setCurrentPage(pageRef);

        //初期化
        ApexPages.StandardController stdCon = new ApexPages.StandardController(caseList[0]);
        AddressSearchController ctrl = new AddressSearchController(stdCon) ;

        //対象項目の選択リスト
        List<SelectOption> targetField = ctrl.SelectTargetFields;

        //対象項目の選択
        ctrl.TargetField = 'SubscribersAddressAfterChange1__c'; //（新）契約者住所
        //次へボタン
        ctrl.goInsert();
        
        //郵便番号該当あり
        ctrl.PostCode = '1500011';
        List<SelectOption> AddressMaster = ctrl.SelectAddressMasters;
        ctrl.goSearch();

        //住所を選択して登録
        ctrl.UniqueKey = '1500011東京都渋谷区東１丁目';
        ctrl.confirm();
    }
}