trigger MailAddressCheckTrigger on EmailMessage (before insert) {
    static final String TARGET_FROMADDRESS = System.Label.MailValidTargetFromAddress.toLowerCase();
    static final String VALID_DOMAINS = System.Label.MailValidToAddress.toLowerCase(); 
    static final String MAILADDRESS_DELIMITER = ';| |,|\n';
    static final String INPUT_ERROR_MESSAGE = System.Label.MailInvalidToAddressMessage;
    static final String KCC_INTERNAL_INVALID_FROMADDRESS_MESSAGE = System.Label.KCC_Internal_Invalid_FromAddress_Message;
    static final String KCC_EXTERNAL_INVALID_FROMADDRESS_MESSAGE = System.Label.KCC_External_Invalid_FromAddress_Message;
    static final String KCC_INTERNAL_CORRECT_FROMADDRESS = System.Label.KCC_Internal_FromAddress;
    static final String KCC_EXTERNAL_CORRECT_FROMADDRESS = System.Label.KCC_External_FromAddress;
    
    if (Trigger.new.isEmpty() || Trigger.new.size() != 1) {
        return;
    }
    List<OrgWideEmailAddress> validationTargets = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress Where DisplayName =: TARGET_FROMADDRESS];
    if(validationTargets.isEmpty()) return;
    String userRoleId = UserInfo.getUserRoleId();
    List<UserRole> roles = [Select Id , Name From UserRole Where Id = :userRoleId];
    if(validationTargets.isEmpty())return ;
    for(EmailMessage eMsg : Trigger.new) {
        if(roles.isEmpty()) continue;
        String targetValidationAddress = eMsg.FromAddress == null ? eMsg.ValidatedFromAddress : eMsg.FromAddress; 
        if(targetValidationAddress == null) continue;
        if (!targetValidationAddress.contains(validationTargets.get(0).Address)) 
            if (roles.get(0).Name.contains('カスタマー') ) {{
            	String targetsObjectId = eMsg.RelatedToId == null ? eMsg.ParentId : eMsg.RelatedToId;
                if(targetsObjectId == null) continue;
                System.debug('@todo error');
                if(targetsObjectId.left(3) == '500' && !targetValidationAddress.contains(KCC_INTERNAL_CORRECT_FROMADDRESS)){
                    Trigger.new[0].addError(KCC_INTERNAL_INVALID_FROMADDRESS_MESSAGE);
                }else if(targetsObjectId.left(3) == 'a2c' && targetValidationAddress.contains(KCC_EXTERNAL_CORRECT_FROMADDRESS)){
                    Trigger.new[0].addError(KCC_EXTERNAL_INVALID_FROMADDRESS_MESSAGE);
                }
                break;
            }
            continue;
        }
        if (eMsg.Incoming == true) {
            continue;
        }
        List<String> mailList = eMsg.ToAddress.split(MAILADDRESS_DELIMITER);
        if (eMsg.CcAddress != null) {
            List<String> ccMailList = eMsg.CcAddress.split(MAILADDRESS_DELIMITER);
            mailList.addAll(ccMailList);
        }
        
        if (mailList == null || mailList.isEmpty()) {
            continue;
        }
        for (String mail : mailList) {
            Integer atmarkIndex= mail.indexOf('@');
            if (atmarkIndex != -1) {
                String domainString = mail.substring(atmarkIndex, mail.length()).toLowerCase();    
                if (!VALID_DOMAINS.contains(domainString) ) {
                    Trigger.new[0].addError(INPUT_ERROR_MESSAGE);
                    break;
                }
            }
        }
    }
}