public with sharing class CreateManagementController {
    
    public CreateManagementController() {   }
    
    @AuraEnabled
    public static string managementCase(Id managementRecordTypeId, Id accidentRecordId) {
        // Create new Management        
        AccidentReception_Management__c managementObj = new AccidentReception_Management__c();
        
        // レコードタイプを設定
        managementObj.RecordTypeId = managementRecordTypeId;
        if(string.isNotBlank(accidentRecordId)){
            managementObj.ContractorName__c = accidentRecordId;
        }
        
        insert managementObj;
        return managementObj.id;        
    }
}