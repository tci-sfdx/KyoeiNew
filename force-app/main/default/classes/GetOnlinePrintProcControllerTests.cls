@isTest
public class GetOnlinePrintProcControllerTests{

	@isTest
    static void processIncomingDataTest(){ 
        Contact c = new Contact(LastName = 'test',PhoneNumber__c='1112223333');
        RecordType ParsonType = [SELECT Id, Name, SobjectType FROM RecordType Where SobjectType = 'Contact' And Name = '顧客'];
        c.RecordTypeId = ParsonType.Id;
        Insert c;
        Case testCase = new Case();
        Insert testCase;
        PageReference getOnlinePrintProcPage = Page.getOnlinePrintProc;

        getOnlinePrintProcPage.getParameters().put('gyoumu_Id',testCase.Id);
        getOnlinePrintProcPage.getParameters().put('ccRnki_InstRnbn','A11111');
        getOnlinePrintProcPage.getParameters().put('ccRnki_SyknNo','13467890');
        getOnlinePrintProcPage.getParameters().put('ccRnki_SyknNoEdbn','00000');
        getOnlinePrintProcPage.getParameters().put('ccRnki_HknSiki','R010101');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P1_HknSyki','R010101');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P2_HknSyki','R010102');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P3_HknSyki','R010103');
        getOnlinePrintProcPage.getParameters().put('p1_HrikmHuhu','1');
        getOnlinePrintProcPage.getParameters().put('p2_HrikmHuhu','2');
        getOnlinePrintProcPage.getParameters().put('p3_HrikmHuhu','3');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P1_HrikmHuhu','1');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P2_HrikmHuhu','2');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P3_HrikmHuhu','3');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P1_GukiHknr','100');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P2_GukiHknr','1000');
        getOnlinePrintProcPage.getParameters().put('ccRnki_P3_GukiHknr','10000');
        getOnlinePrintProcPage.getParameters().put('pdfFilePath','c:\\test.txt');
        getOnlinePrintProcPage.getParameters().put('pdfFiledata','text');
        Test.startTest();

        // テスト対象ページのカレントページ化
        Test.setCurrentPage(getOnlinePrintProcPage);
        {
          GetOnlinePrintProcController TestController = new GetOnlinePrintProcController();
          TestController.processIncomingData();
        }

        Test.stopTest();
    }
}