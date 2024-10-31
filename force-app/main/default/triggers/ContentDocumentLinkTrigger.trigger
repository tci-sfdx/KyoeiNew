trigger ContentDocumentLinkTrigger on ContentDocumentLink (before delete, before insert) {
	ContentDocumentLinkTriggerHandler handler = new ContentDocumentLinkTriggerHandler();
    
    	if(Trigger.isInsert && Trigger.isBefore){
            handler.postingFileName(Trigger.new);
    	}else if(Trigger.isDelete && Trigger.isBefore){
            handler.deleteFileName(Trigger.old);
    	}
}