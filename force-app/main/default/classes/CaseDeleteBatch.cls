global class CaseDeleteBatch implements Database.Batchable<sObject>{
    
    public static final String WithdrawalDialogue = System.Label.Withdrawal;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT id FROM Case WHERE IsDelete__c = true AND (IsLinked__c = true OR DialogueResult__c =: WithdrawalDialogue)'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Case> caseList) {  
        List<Case> delelteCaseList = new List<Case>(caseList);
   		Delete delelteCaseList;
	}
    
    global void finish(Database.BatchableContext bc){
		AsyncApexJob completedJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems,ExtendedStatus
							FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        if(completedJob.NumberOfErrors == 0){
            return;
        }
        sendErrorMail(completedJob.NumberOfErrors , completedJob.Id , completedJob.ExtendedStatus , completedJob.Status);
    }
    global void sendErrorMail(Integer NumberOfErrors, String jobId, String ExtendedStatus, String Status){
        String text = '';
        text += '削除ケースバッチ処理にてエラーが発生しました。';
        text += '\n';
        text += 'エラー' + NumberOfErrors +'件';
        text += '\n';
        text += '対象のジョブID：' + jobId;
        text += '\n';
        text += 'エラー詳細：' + ExtendedStatus;
        Messaging.SingleEmailMessage mailToAdmin = new Messaging.SingleEmailMessage();
        mailToAdmin.setToAddresses(new List<String>{System.Label.NotificationAdminMailAddress});
        mailToAdmin.setSubject('ケース削除バッチ' + Status);
        mailToAdmin.setPlainTextBody(text);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mailToAdmin});
    }
}