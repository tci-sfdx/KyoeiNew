trigger ManagementTrigger on AccidentReception_Management__c (before update, 
                                            before insert,after insert,after update) {
    ManagementTriggerController handler = new ManagementTriggerController(Trigger.isExecuting, Trigger.size);
	CaseTriggerHandler caseHandler = new CaseTriggerHandler();
    List<AccidentReception_Management__c> bedoreExclusionList = new List<AccidentReception_Management__c>();
	List<string> bedoreLinkedSessionIdList = new List<string>();
    List<AccidentReception_Management__c> accidentReceptionVideoList = new List<AccidentReception_Management__c>(); 
    
    if(Trigger.isInsert && Trigger.isBefore){
        for ( AccidentReception_Management__c newManagement : Trigger.new ) {
            if(string.isBlank(newManagement.BedoreSessionID__c)){
                bedoreExclusionList.add(newManagement);
            }
            if(string.isNotBlank(newManagement.AccidentReceptionVideoUid__c )){
                accidentReceptionVideoList.add(newManagement);
            }
		}
        handler.OnBeforeInsert(bedoreExclusionList);
        handler.ChangePhaseOwerId(accidentReceptionVideoList);

    }else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new);
    }
	if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        for ( AccidentReception_Management__c newManagement : Trigger.new ) {
            if(string.isNotBlank(newManagement.BedoreSessionID__c)){
                system.debug('BedoreSessionID__c:'+newManagement.BedoreSessionID__c);
                bedoreLinkedSessionIdList.add(newManagement.BedoreSessionID__c);
            }
		}
    system.debug('bedoreLinkedSessionIdList:'+bedoreLinkedSessionIdList);                                            
	caseHandler.updateBedoreLinkedCase(bedoreLinkedSessionIdList); 
	}
}