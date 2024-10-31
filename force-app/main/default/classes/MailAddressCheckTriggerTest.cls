@isTest
public class MailAddressCheckTriggerTest {
    
    // 送信成功
    @isTest
    static void testEmailUtility01() {
        Test.StartTest();
        List<String> fromAddresses = new List<String>{'test1@kyoeikasai.co.jp','test2@kyoeikasai.co.jp'};
        orgWideEmailAddress orgAddress  = getValidOrgWideEmailAddress();
        System.assert(orgAddress != null);
        sendPlainTextEmail(fromAddresses , orgAddress.Id, 'Unit Test X[添付なし]', 'Unit Test');
        
        // Apex電子メール送信検証
        System.assertEquals(1, Limits.getEmailInvocations());
        Test.stopTest();
    }
    // 送信失敗
    @isTest
    static void testEmailUtility02() {
        Test.StartTest();
        try{
            List<String> fromAddresses = new List<String>{'test@kyoeikasai.co.jp.invalid','test@kyoeikasai.co.jp'};
            orgWideEmailAddress orgAddress  = getValidOrgWideEmailAddress();
            System.assert(orgAddress != null);
            sendPlainTextEmail(fromAddresses , orgAddress.Id, 'Unit Test X[添付なし]', 'Unit Test');
        }catch(Exception err){
            System.assert(err.getMessage().contains(System.Label.MailInvalidToAddressMessage));
        }
        // Apex電子メール送信検証
        System.assertEquals(0, Limits.getEmailInvocations());
        Test.stopTest();
    }
    // 送信失敗
    @isTest
    static void testEmailUtility03() {
        Test.StartTest();
        try{
            List<String> fromAddresses = new List<String>{'test1@kyoeikasai.co.jp','test2@kyoeikasai.co.jp'};
            Case c  = new Case();
            insert c;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setWhatId(c.Id);
            mail.setToAddresses(fromAddresses);
            mail.setSubject('subject');
            mail.setPlainTextBody('body');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception err){
        }
        // Apex電子メール送信検証
        System.assertEquals(1, Limits.getEmailInvocations());
        Test.stopTest();
    }
    private static orgWideEmailAddress getValidOrgWideEmailAddress(){
        List<OrgWideEmailAddress> orgWideEmailAddresses =[SELECT Id, Address, Purpose, DisplayName FROM OrgWideEmailAddress Where DisplayName = '事故受付担当'];
        if(orgWideEmailAddresses.isEmpty()){
            return null;
        }
        return orgWideEmailAddresses.get(0);
    }
    
    private static void sendPlainTextEmail(List<String> addresses, Id orgWideEmailAddressId, String subject, String body) {
        
        AccidentReception_Management__c management  = new AccidentReception_Management__c();
        insert management;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setWhatId(management.Id);
        mail.setOrgWideEmailAddressId(orgWideEmailAddressId);
        mail.setToAddresses(addresses);
        mail.setCcAddresses(addresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
}