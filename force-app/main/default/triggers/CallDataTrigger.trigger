trigger CallDataTrigger on AccidentReception_CallData__c (after delete, after insert, after undelete, after update, 
														before delete, before insert, before update) {
	CallDataTriggerController handler = new CallDataTriggerController(Trigger.isExecuting, Trigger.size);
    if(Trigger.isInsert && Trigger.isBefore){
		handler.OnBeforeInsert(Trigger.new);
	} 
}