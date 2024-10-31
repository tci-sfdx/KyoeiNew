@isTest
private class CreateManagementControllerTests {
    public static AccidentReception_Management__c app;

    @isTest static void managementCaseTest1(){
       
        // test start
        try{
            AccidentReception_CallData__c contact = new AccidentReception_CallData__c(
                MobilePhone__c = '03-1234-5678' ,
                Name = 'トランス',
                ContractorName__c='aa', AccidentDate__c = 'R3/1/1',
                PolicyNumber__c='266262-111', IncomingCallTime__c = '22:22',
                IncomingCallDay__c = 'R2/12/11', RegisteredPhoneNumber1__c = '151551',
                Relationship__c = 'aa', CallerContactInformation1__c = '111',
                RegisteredPhoneNumber2__c = '111',
                CallerContactInformation2__c = '22') ;
            insert contact;

            CreateManagementController.managementCase(System.label.TypeFireRecordType, contact.Id);
            
        }catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
}