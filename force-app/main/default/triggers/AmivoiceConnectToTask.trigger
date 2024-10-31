trigger AmivoiceConnectToTask on Task (after insert, after update) {
    
	for (Task t : Trigger.new){
		if(trigger.isupdate){
			Task oldTask = trigger.oldMap.get(t.id);
			
			if(oldTask.InteractionUri__c == t.InteractionUri__c && oldTask.WhatId == t.WhatId ){
				continue;
			}
		}
		if (t.InteractionUri__c == null){
			continue;
		}
		Integer conversationKeyIndex = t.InteractionUri__c.lastIndexOf('/');
		if(conversationKeyIndex < 0){
			continue;
		}
		String key = t.InteractionUri__c.right(t.InteractionUri__c.length() - conversationKeyIndex -1);
		AmivoiceConnect.calloutor(key,t.Id,t.WhatId);
	}

}