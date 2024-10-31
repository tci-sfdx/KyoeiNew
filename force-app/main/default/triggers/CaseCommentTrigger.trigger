trigger CaseCommentTrigger on CaseComment (after insert,after update) {
	
    Set<Id> caseIds = new Set<Id>();
    for ( CaseComment newCase : Trigger.new ) {
        caseIds.add(newCase.ParentId);
    }
    List<Case> targetCases = [select id, CaseNumber, description, (Select Id,CommentBody,CreatedBy.name, CreatedDate From CaseComments order by Createddate desc) 
                              from Case Where Id in : caseIds order by caseNumber];
    String messages = '';
    String keyCaseNumber = targetCases.get(0).CaseNumber;
    for(Case c : targetCases){
        for(CaseComment comm : c.CaseComments){
            System.debug(comm.CommentBody);
            messages += '<< ' + comm.CreatedBy.name + ' ' +  comm.CreatedDate.format('yyyy/MM/dd HH:mm:ss','JST') + ' >>\n' + comm.CommentBody + '\n';
        }
        System.debug('mes is:' + messages);
        c.CaseCommentForReport__c = messages;
        messages = '';
	}
    update targetCases;
}