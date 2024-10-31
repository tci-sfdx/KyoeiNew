public with sharing class OnlineSearchFormController{

    @AuraEnabled(cacheable=true)
    public static List<User> getUserOnlineInfo(){

        String userId = userinfo.getUserId();

        List<User> users= [
                SELECT
                    Id,
                    OnlineId__c , OnlinePW__c
                FROM
                    User
                WHERE
                    Id = :userId
                LIMIT 1
        ];

        return users;
    }

}