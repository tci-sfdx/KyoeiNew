@isTest
public class OnlinePrintProcControllerTests{

	@isTest
    static void getUserOnlineInfoTest(){
		  List<User> users = OnlinePrintProcController.getUserOnlineInfo();
    }
  @isTest
    static void getPrintDatasTest(){
      Case c = new Case();
      Insert c;

      PrintSerialNumber__c p = new PrintSerialNumber__c();
      p.Name = 'A1111';
      p.CaseId__c = c.Id;
      p.InsurancePeriodA__c = 'R010101';
      p.InsurancePeriodB__c = 'R010102';
      p.InsurancePeriodC__c = 'R010103';
      p.SumInsuranceFeeA__c = 100;
      p.SumInsuranceFeeB__c = 200;
      p.SumInsuranceFeeC__c = 300;
      Insert p;

      List<Map<String, String>>  maps = OnlinePrintProcController.getPrintDatas(c.Id);
    }
}