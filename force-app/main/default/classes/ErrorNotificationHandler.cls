public  class ErrorNotificationHandler {
    public static void sendEmailMessage(Exception e){
        String errorMsgToAdmin = '';
        errorMsgToAdmin += '実行ユーザ名: ' + UserInfo.getUserName();
        errorMsgToAdmin += '\n\n';
        errorMsgToAdmin += e.getTypeName() + ' ' + e.getMessage();
        errorMsgToAdmin += '\n';
        errorMsgToAdmin += e.getStackTraceString();
        Messaging.SingleEmailMessage mailToAdmin = new Messaging.SingleEmailMessage();
        mailToAdmin.setToAddresses(new List<String>{System.Label.NotificationAdminMailAddress});
        mailToAdmin.setSubject(System.Label.ErrorMessageSubject);
        mailToAdmin.setPlainTextBody(errorMsgToAdmin);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mailToAdmin});
    }
	public static void sendChatterMessage(){
        String groupName = System.Label.NotificationChatterGroupName;
        String adminName = System.Label.AdminName;
        List<CollaborationGroup> svGroups = [select Id ,Name from CollaborationGroup where Name =: groupName limit 1];
        User admin = [select Id from User where Name =: adminName limit 1];
        String errorMsgToCC = System.Label.NotificationChatterMessage;
        FeedItem feed = new FeedItem();
        feed.parentId = svGroups.isEmpty() ? UserInfo.getUserId() :svGroups.get(0).Id;
        feed.CreatedById = admin.Id;
        feed.body = errorMsgToCC;
        insert feed; 
    }
}