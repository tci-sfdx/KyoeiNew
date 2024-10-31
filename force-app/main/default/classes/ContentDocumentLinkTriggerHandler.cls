public with sharing class ContentDocumentLinkTriggerHandler {
	public ContentDocumentLinkTriggerHandler(){}
    
    public void postingFileName(ContentDocumentLink[] contentDocumentLinks){
        Map<Id, Id> contentIdToLinkedManagementIdMap  = new Map<Id, Id>();
        Map<Id, String> managementIdToTitleMap = new Map<Id, String>();
        
        for(ContentDocumentLink contentDocumentLink : contentDocumentLinks){
        	system.debug('ContentDocumentId:' + contentDocumentLink.ContentDocumentId);
        	system.debug('LinkedEntityId:' + contentDocumentLink.LinkedEntityId);
            if(contentDocumentLink.LinkedEntityId != null && String.valueOf(contentDocumentLink.LinkedEntityId).left(3) == System.Label.ManagemntObjId){
                contentIdToLinkedManagementIdMap.put(contentDocumentLink.ContentDocumentId, contentDocumentLink.LinkedEntityId);
            }
        }
        
        system.debug('contentIdToLinkedManagementIdMap:' + contentIdToLinkedManagementIdMap);
        
        List<ContentDocument> contentDocuments = [SELECT Title FROM ContentDocument WHERE Id = :contentIdToLinkedManagementIdMap.keySet()];
        for (ContentDocument contentDocument : contentDocuments) {
            managementIdToTitleMap.put(contentIdToLinkedManagementIdMap.get(contentDocument.Id), contentDocument.Title);
        }
        
        system.debug('managementIdToTitleMap:'+managementIdToTitleMap);
        
        if(managementIdToTitleMap.keySet().isEmpty()){
            return;
        }
        system.debug('managementIdToTitleMap:'+managementIdToTitleMap);
        List<AccidentReception_Management__c> managements = [SELECT Id,OutputFileList__c FROM AccidentReception_Management__c WHERE Id IN: managementIdToTitleMap.keySet()];
        for (AccidentReception_Management__c management : managements) {
            String fileTitle = managementIdToTitleMap.get(management.Id);
            if(management.OutputFileList__c == null){
                management.OutputFileList__c = fileTitle;
            }else{
                management.OutputFileList__c += ','+fileTitle;
            }
		}
        update managements;            
	}
    
	public void deleteFileName(ContentDocumentLink[] contentDocumentLinks){
        Map<Id, Id> contentIdToLinkedManagementIdMap  = new Map<Id, Id>();
        Map<Id, String> managementIdToTitleMap = new Map<Id, String>();
        
        for(ContentDocumentLink contentDocumentLink : contentDocumentLinks){
        	system.debug('ContentDocumentId:' + contentDocumentLink.ContentDocumentId);
        	system.debug('LinkedEntityId:' + contentDocumentLink.LinkedEntityId);
            if(contentDocumentLink.LinkedEntityId != null && String.valueOf(contentDocumentLink.LinkedEntityId).left(3) == System.Label.ManagemntObjId){
                contentIdToLinkedManagementIdMap.put(contentDocumentLink.ContentDocumentId, contentDocumentLink.LinkedEntityId);
            }
        }
        
        system.debug('contentIdToLinkedManagementIdMap:' + contentIdToLinkedManagementIdMap);
        
        List<ContentDocument> contentDocuments = [SELECT Title FROM ContentDocument WHERE Id = :contentIdToLinkedManagementIdMap.keySet()];
        for (ContentDocument contentDocument : contentDocuments) {
            managementIdToTitleMap.put(contentIdToLinkedManagementIdMap.get(contentDocument.Id), contentDocument.Title);
        }
        
        system.debug('managementIdToTitleMap:'+managementIdToTitleMap);
        
		if(managementIdToTitleMap.keySet().isEmpty()){
        	return;    
        }
        system.debug('managementIdToTitleMap:'+managementIdToTitleMap);
        List<AccidentReception_Management__c> managements = [SELECT Id,OutputFileList__c FROM AccidentReception_Management__c WHERE Id IN: managementIdToTitleMap.keySet()];
        for (AccidentReception_Management__c management : managements) {
            	List<String> FileTitleLists = management.OutputFileList__c.split(',');
                FileTitleLists.remove(FileTitleLists.indexOf(managementIdToTitleMap.get(management.Id)));
                management.OutputFileList__c = null;
            	if(FileTitleLists.size() == 1){
                	management.OutputFileList__c = FileTitleLists[0];
                }else{
                    management.OutputFileList__c = String.join(FileTitleLists,',');
                }
        }
        update managements;
	}	
}