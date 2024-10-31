@isTest
public class AgencyMailCompControllerTest {

    //テストデータ
    @testSetup
    private static void createTestDatas() {
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;
    }

    private static testMethod void SearchTest_ContractorAddress() {
        //代理店コールデータ
        DairitenSaport_CallData__c da1 = new DairitenSaport_CallData__c();
        da1.AgencyReference__c = [SELECT Name FROM Account LIMIT 1].Id;
        da1.Category1__c = '0010ＷＥＢオンライン';
        da1.Category2__c = '0010申込書';
        da1.InquiryDetails__c = 'テスト問い合わせ詳細あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        da1.AnswerDetails__c = 'テスト回答詳細あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        da1.RecordTypeId = Schema.SObjectType.DairitenSaport_CallData__c.getRecordTypeInfosByDeveloperName().get('Automobile').getRecordTypeId();
        insert da1;

        AgencyMailCompController ctrl = new AgencyMailCompController() ;
        ctrl.agencyId = da1.Id;
    }
}