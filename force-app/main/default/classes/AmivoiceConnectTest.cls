@isTest
private class AmivoiceConnectTest {

    @isTest static void doLoginTest(){
            //insert 
            Test.startTest();
			AmivoiceConnect.doLogin();
            Test.stopTest();
    }
    
    @isTest static void doConversationGetTest(){
        //insert 
        Test.startTest();
        String cookies = 'cookies';
        String conversationKey = 'conversationKey';
        AmivoiceConnect.doConversationGet(cookies,conversationKey);
        Test.stopTest();
    }

    @isTest static void doGetCallInfoTest(){
        //insert 
        Test.startTest();
        String cookies = 'cookies';
        String conversationKey = 'conversationKey';
        AmivoiceConnect.doGetCallInfo(cookies,conversationKey);
        Test.stopTest();
    }

    @isTest static void calloutorTest(){
        Task todo = new Task();
        todo.subject = 'subject';
        insert todo;

        DairitenSaport_CallData__c calldata = new DairitenSaport_CallData__c();
        calldata.Category1__c = '0010ＷＥＢオンライン';
        calldata.Category2__c = '0010申込書';
        insert calldata;
        
        Case testCase = new Case();
        insert testCase;
        //insert 
        Test.startTest();
        String key = 'key';
        AmivoiceConnect.calloutor(key,todo.Id,calldata.Id);
        AmivoiceConnect.calloutor(key,todo.Id,testCase.Id);
        Test.stopTest();

    }

}