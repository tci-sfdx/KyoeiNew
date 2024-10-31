@isTest
public class GetOnlinePrintProcRestTests{
    private static String setJSONMsg(String caseId, String procNumber){
        System.debug('"gyoumu_Id" : "'+caseId.left(15) + procNumber +'",');
        String JSONMsg = '{';
        JSONMsg +='"gyoumu_Id" : "'+caseId.left(15) + procNumber +'",';
        JSONMsg +='"ccRnki_InstRnbn" : "A11111",';
        JSONMsg +='"ccRnki_SyknNo" : "13467890",';
        JSONMsg +='"ccRnki_SyknNoEdbn" : "00000",';
        JSONMsg +='"ccRnki_HknSiki" : "R010101",';
        JSONMsg +='"ccRnki_P1_HknSyki"  : "R010101",';
        JSONMsg +='"ccRnki_P2_HknSyki" : "R010102",';
        JSONMsg +='"ccRnki_P3_HknSyki" : "R010103",';
        JSONMsg +='"p1_HrikmHuhu" : "1",';
        JSONMsg +='"p2_HrikmHuhu" : "2",';
        JSONMsg +='"p3_HrikmHuhu"  : "3",';
        JSONMsg +='"ccRnki_P1_HrikmHuhu" : "1",';
        JSONMsg +='"ccRnki_P2_HrikmHuhu"  : "2",';
        JSONMsg +='"ccRnki_P3_HrikmHuhu" : "3",';
        JSONMsg +='"ccRnki_P1_GukiHknr" : "1",';
        JSONMsg +='"ccRnki_P2_GukiHknr" : "2",';
        JSONMsg +='"ccRnki_P3_GukiHknr" : "3",';
        JSONMsg +='"pdfFilePath" : "c:\\test.txt",';
        JSONMsg +='"pdfFiledata" : "text"}';
        return JSONMsg;
    }
	@isTest
    static void processIncomingDataTest01(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '01');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
    
	@isTest
    static void processIncomingDataTest02(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '02');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest11(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '11');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest12(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '12');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest13(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '13');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest14(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '14');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest21(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '21');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest22(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '22');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest23(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '23');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest24(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '24');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest31(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '31');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
	@isTest
    static void processIncomingDataTest32(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        String testCaseId = testCase.Id;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetPrintDataInfo';
        String JSONMsg = setJSONMsg(testCaseId, '32');
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetOnlinePrintProcRest.processIncomingData();

        Test.stopTest();
    }
}