@isTest
public class CaseCommentTriggerTests { 
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
    private static void CaseCommentTests() {
        //データ取得
        List<Case> caseList = [SELECT id, CaseNumber FROM Case LIMIT 1];
        Case ca1 = caseList.get(0);
        CaseComment comment1 = new CaseComment(ParentId = ca1.Id, CommentBody = 'comment\n');
        insert comment1;
        comment1.CommentBody = 'comment2\n';
        update comment1;
    }
}