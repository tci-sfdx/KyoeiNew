trigger CaseTrigger on Case (after insert, after update, before delete) {
    CaseTriggerHandler handler = new CaseTriggerHandler();
    List<Case> bedoreCompletedVoiceList = new List<Case>();
	if(Trigger.isInsert && Trigger.isAfter){
        for ( Case newCase : Trigger.new ) {
            if(String.isNotEmpty(newCase.SessionID__c)){
                if(newCase.DialogueResult__c.equals(System.Label.DialogueCompleted)){
                    bedoreCompletedVoiceList.add(newCase);
                }          
            }
		}
	}
    if(Trigger.isUpdate && Trigger.isAfter){
        for ( Case newCase : Trigger.new ) {
            if(String.isNotEmpty(newCase.SessionID__c)){
                if(String.isNotEmpty(newCase.DialogueResult__c)){
                    if(newCase.DialogueResult__c.equals(System.Label.DialogueCompleted) && !newCase.IsLinked__c){
                        bedoreCompletedVoiceList.add(newCase);
                    }   
                }                
            }
		}
    }
    if(Trigger.isDelete && Trigger.isBefore){
        Map<ID, Profile> profileMap = new Map<ID, Profile>([SELECT Id, Name FROM Profile]);
        for ( Case newCase : Trigger.old ) {
            if(profileMap.containsKey(UserInfo.getProfileId()) && profileMap.get(UserInfo.getProfileId()).name == '計上G' ) {
                newCase.adderror('コールデータの削除はできません');             
            }
		}
    }
    system.debug(bedoreCompletedVoiceList);
    if(!bedoreCompletedVoiceList.isEmpty()){
        handler.ConvertBedoreVoice(bedoreCompletedVoiceList);
    }
}