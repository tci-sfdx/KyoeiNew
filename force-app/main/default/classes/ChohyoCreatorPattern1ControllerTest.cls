@isTest
public class ChohyoCreatorPattern1ControllerTest {

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
        ca1.InquiryDetails__c = 'テスト問い合わせ詳細';
        ca1.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        insert ca1;

        //帳票文言マスタ
        WordMaster__c word = new WordMaster__c();
        word.Name = 'テスト帳票';
        insert word;
    }

    private static testMethod void ChohyoCreateTest() {

        //データ取得
        List<Case> caseList = [SELECT CaseNumber FROM Case LIMIT 1];

        PageReference pageRef = Page.ReportDocument1_1;
        pageRef.getParameters().put('Id', caseList[0].Id);
        pageRef.getParameters().put('cId', 'テスト帳票');
        Test.setCurrentPage(pageRef);

        ChohyoCreatorPattern1Controller ctrl = new ChohyoCreatorPattern1Controller() ;
    }
}