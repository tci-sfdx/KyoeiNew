@isTest
public class PrintSerialNumberTriggerTests { 
	@testSetup
    static void caseSetup() {
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

    }
    @isTest
    private static void PrintSerialNumberTests() {
        //データ取得
        List<Case> caseList = [SELECT id, CaseNumber FROM Case LIMIT 1];
        Case ca1 = caseList.get(0);
        PrintSerialNumber__c print = new PrintSerialNumber__c(CaseId__c = ca1.Id, CaseLastModifiedByName__c = 'テスト', ProcName__c = '処理名', Name = 'JA1111', DoReporting__c = true);
        insert print;
        print.CaseLastModifiedByName__c = 'テスト2';
        update print;
        delete print;
        PrintSerialNumber__c print2 = new PrintSerialNumber__c(CaseId__c = ca1.Id, CaseLastModifiedByName__c = 'テスト', ProcName__c = '処理名', Name = 'BA1111', DoReporting__c = true);
        insert print2;
        update print2;
        delete print2;

    }
}