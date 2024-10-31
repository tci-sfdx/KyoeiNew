@isTest
private class AmivoiceConnectToTaskTest {

    @isTest static void calloutorTest(){
        Test.startTest();
        Task todo = new Task();
        todo.subject = 'subject';
        todo.InteractionUri__c = 'https://test.com';
        insert todo;

        Test.stopTest();
    }
}