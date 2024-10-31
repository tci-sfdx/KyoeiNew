public with sharing class AmivoiceConnect{


    @RemoteAction
    public static string doLogin(){
		//@todo リテラルは外部設定化
        String endpoint = 'https://l7106g-msccs.amivoice.com/ControlCenter/Services';
        String userKey = 'TCI_API';
        String passphrase = 'TCI_API';
        String createAuthenticationTicket = 'true';

        HttpRequest req = new HttpRequest();
                
        req.setEndpoint(endpoint +'/Account.json/Login');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
        Map<String, String> bodyMap = new Map<String, String>();
        bodyMap.put('userKey', userKey);
        bodyMap.put('passphrase', passphrase);
        bodyMap.put('createAuthenticationTicket', createAuthenticationTicket);
        String body = '';
        for (String name : bodyMap.keySet()) {
            if (bodyMap.get(name) != null) {
                String value = bodyMap.get(name);
                body += '&' + name + '=' + EncodingUtil.urlDecode(value, 'utf-8');
            }
        }
        req.setBody(body.substring(1));
        System.debug('request body is:' + req.getBody());
        Http http = new Http();
        if(TEST.isRunningTest()) return null;
        HTTPResponse res = http.send(req);
        
        JSONParser parser = JSON.createParser(res.getBody());
        System.debug('response body is:' + res.getBody());
        for(String k : res.getHeaderKeys()){
        	System.debug(k + ':' + res.getHeader(k));        
			if(k == 'Set-Cookie' ) return res.getHeader(k);    
        }
        // dont use response body 
        Type requestItemType = Type.forName('AmivoiceConnect.doLoginResponse');
        doLoginResponse doLoginResponseItem = (doLoginResponse)parser.readValueAs(requestItemType);
        System.debug(doLoginResponseItem);
        
        return null;
         
    }
    public class doLoginResponse{
        String id;
        String token_type;
        String issued_at;
        String email;
        String gender;
        String ageGroup;
    }
    
    @RemoteAction
    public static doConversationGetResponse doConversationGet(String cookies, String conversationKey){

        String endpoint = 'https://l7106g-msccs.amivoice.com/ControlCenter/Services';
        String authenticationTicket = 'xxxxxx';
        //String serviceVersion;
        //String responseFormat;
        //
        String includeTextData = 'true';
        String includeConversationFilterDetections = 'true';
        String includeScores = 'true';
        //String op.emotionParameterKey;
        //String cu.emotionParameterKey;

        HttpRequest req = new HttpRequest();
                
        req.setEndpoint(endpoint +'/Conversation.json/Text/Get');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Cookie', cookies);
        Map<String, String> bodyMap = new Map<String, String>();
        bodyMap.put('conversationKey', conversationKey);
        bodyMap.put('includeTextData', includeTextData);
        String body = '';
        for (String name : bodyMap.keySet()) {
            if (bodyMap.get(name) != null) {
                String value = bodyMap.get(name);
                body += '&' + name + '=' + EncodingUtil.urlDecode(value, 'utf-8');
            }
        }
        req.setBody(body.substring(1));
        System.debug('request body is:' + req.getBody());
        Http http = new Http();
        if(TEST.isRunningTest()) return null;
        HTTPResponse res = http.send(req);
        
        System.debug('response body is:' + res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
        Type requestItemType = Type.forName('AmivoiceConnect.doConversationGetResponse');
        doConversationGetResponse doConversationGetResponseItem = (doConversationGetResponse)parser.readValueAs(requestItemType);
        System.debug(doConversationGetResponseItem);
        return doConversationGetResponseItem;
    }
    public class doConversationGetResponse{
        public String serviceVersion;
        public String statusCode;
        public String statusMessage;
        public textData content;
    }
    public class textData{
		public String revision;
        public String updateDateTime;
        public List<segment> segments;
    }
    public class segment{
		public String channelType;
		public String startTime;
		public String endTime;
		public String sentence;
		public String segmentId;
    }
 
    @RemoteAction
    public static doGetCallInfoResponse doGetCallInfo(String cookies, String conversationKey){

        String endpoint = 'https://l7106g-msccs.amivoice.com/ControlCenter/Services';
        String authenticationTicket = 'xxxxxx';
        //String serviceVersion;
        //String responseFormat;
        //
        String includeTextData = 'true';
        String includeConversationFilterDetections = 'true';
        String includeScores = 'true';
        //String op.emotionParameterKey;
        //String cu.emotionParameterKey;

        HttpRequest req = new HttpRequest();
                
        req.setEndpoint(endpoint +'/Conversation.json/Get');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Cookie', cookies);
        Map<String, String> bodyMap = new Map<String, String>();
        bodyMap.put('conversationKey', conversationKey);
        bodyMap.put('includeTextData', includeTextData);
        String body = '';
        for (String name : bodyMap.keySet()) {
            if (bodyMap.get(name) != null) {
                String value = bodyMap.get(name);
                body += '&' + name + '=' + EncodingUtil.urlDecode(value, 'utf-8');
            }
        }
        req.setBody(body.substring(1));
        System.debug('request body is:' + req.getBody());
        Http http = new Http();
        if(TEST.isRunningTest()) return null;
        HTTPResponse res = http.send(req);
        
        System.debug('response body is:' + res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
        Type requestItemType = Type.forName('AmivoiceConnect.doGetCallInfoResponse');
        doGetCallInfoResponse doGetCallInfoResponseItem = (doGetCallInfoResponse)parser.readValueAs(requestItemType);
        System.debug(doGetCallInfoResponseItem);
        return doGetCallInfoResponseItem;
    }
    
    public class doGetCallInfoResponse{
        public String serviceVersion;
        public String statusCode;
        public String statusMessage;
        public callInfo content;
    }
    public class callInfo{
		public String conversationKey;
        public String projectName;
        public datetime startDateTime;
        public datetime endDateTime;
        public String endStatus;
        public String duration;
        public String holdDuration;
        public Integer holdCount;
        public String updateDateTime;
    }
    public class queryResult{
        
        public String serviceVersion;
        public String statusCode;
        public String statusMessage;
        public queryResultContent content;
    }
    public class queryResultContent{
        public List<conversations> conversations;
    }
        
    public class conversations{
		public String conversationKey;
		public operator operator;
		public List<conversationAttributes> conversationAttributes;
    }
    public class operator{
		public String userKey;
    }
    public class conversationAttributes{
		public String conversationAttributeKey;
		public String conversationAttributeName;
		public String conversationAttributeValue;
        
    }
    
    @RemoteAction
    public static String doQuery(String cookies, String conversationKey){

        String endpoint = 'https://l7106g-msccs.amivoice.com/ControlCenter/Services';
        String authenticationTicket = 'xxxxxx';
        //String serviceVersion;
        //String responseFormat;
        //
        String includeTextData = 'true';
        String includeConversationFilterDetections = 'true';
        String includeScores = 'true';
        //String op.emotionParameterKey;
        //String cu.emotionParameterKey;

        HttpRequest req = new HttpRequest();
                
        req.setEndpoint(endpoint +'/Query.json/Query');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Cookie', cookies);
        Map<String, String> bodyMap = new Map<String, String>();
        bodyMap.put('query', 'd:1d s:dater');
        bodyMap.put('rows', '10000');
        bodyMap.put('includeConversationAttributeKey', 'amivoice.common.reference.global.id');
        String body = '';
        for (String name : bodyMap.keySet()) {
            if (bodyMap.get(name) != null) {
                String value = bodyMap.get(name);
                body += '&' + name + '=' + EncodingUtil.urlDecode(value, 'utf-8');
            }
        }
        req.setBody(body.substring(1));
        System.debug('request body is:' + req.getBody());
        Http http = new Http();
        if(TEST.isRunningTest()) return null;
        HTTPResponse res = http.send(req);
        System.debug('response body is:' + res.getBody());
            
        JSONParser parser = JSON.createParser(res.getBody());
        Type requestItemType = Type.forName('AmivoiceConnect.queryResult');
        queryResult queryResultItem = (queryResult)parser.readValueAs(requestItemType);
        System.debug(queryResultItem);
        User contextUser = [select id, Extension From User Where Id = :UserInfo.getUserId()];
        for(conversations conversation: queryResultItem.content.conversations){
        	System.debug(conversation);
        	System.debug(conversation.operator.userKey);
        	for(conversationAttributes conversationAttribute: conversation.conversationAttributes){
            	if(conversationAttribute.conversationAttributeValue == conversationKey && contextUser.Extension == conversation.operator.userKey){
                	return conversation.conversationKey;
                }
            }
        	System.debug(conversation);
        }
        return '';
    }
    @future (callout=true)
    public static void calloutor(String key ,Id taskId,Id callDataId){
            Task t = [Select Id,Description,CallerNumber__c From Task Where Id = :taskId];
            if(t == null) return;
            
            String cookies = AmivoiceConnect.doLogin();
            if(TEST.isRunningTest()) cookies = 'cookie for the test';
            String conversationKey = AmivoiceConnect.doQuery(cookies,key);
            if(conversationKey == ''){
                return;
            }
            AmivoiceConnect.doConversationGetResponse doConversationGetResponseItem = AmivoiceConnect.doConversationGet(cookies,conversationKey);
            if(TEST.isRunningTest()){
                doConversationGetResponseItem = new AmivoiceConnect.doConversationGetResponse();
                
                doConversationGetResponseItem.statusCode = '0';
                doConversationGetResponseItem.content = new textData();
                doConversationGetResponseItem.content.segments =  new List<segment>(); 

            }
            if(doConversationGetResponseItem.statusCode <> '0'){
                return;
            }
            //DML発効後にコールアウト不可のため、一律実行
            AmivoiceConnect.doGetCallInfoResponse doGetCallInfoResponseItem = AmivoiceConnect.doGetCallInfo(cookies,conversationKey);
            if(TEST.isRunningTest()){
                doGetCallInfoResponseItem = new AmivoiceConnect.doGetCallInfoResponse();
                
                doGetCallInfoResponseItem.content = new callInfo();
                doGetCallInfoResponseItem.content.duration = '100';
            }
            User contextUser = [select id, Extension From User Where Id = :UserInfo.getUserId()];
            String  descriptions = '' + doGetCallInfoResponseItem.content.startDateTime + ' ' + contextUser.Extension + '\n';
            
            for(AmivoiceConnect.segment segment : doConversationGetResponseItem.content.segments){
                
                system.debug(segment.sentence);
                descriptions = descriptions + segment.channelType + ':' + segment.sentence +'\n';
            }
            t.Description = descriptions;
            update t;
            System.debug(callDataId);
            if(callDataId == null) return;
            String callDataIdString = callDataId;
            if(callDataIdString.left(3) == 'a1W' ){            
                DairitenSaport_CallData__c d = [select Id,CallTime__c,AmiVoice__c,IncomingNumber__c from DairitenSaport_CallData__c Where Id = :callDataId];
                if(d==null) return;
                if( d.CallTime__c == null) d.CallTime__c = 0;
                d.CallTime__c =  d.CallTime__c + (Decimal.valueOf(doGetCallInfoResponseItem.content.duration) / 60).round(System.RoundingMode.UP).intValue();
                if( d.AmiVoice__c == null) d.AmiVoice__c = '';
                d.AmiVoice__c =  d.AmiVoice__c + '\n' + descriptions;
                if ( !String.isBlank(t.CallerNumber__c)){
                    String phoneNumber = t.CallerNumber__c.startsWith('+81') ? t.CallerNumber__c.replace('+81', '0') : t.CallerNumber__c;
                    System.debug(d.IncomingNumber__c);
                    if ( String.isEmpty(d.IncomingNumber__c) )  d.IncomingNumber__c = phoneNumber;
                }
                update d;
                return;
            }

            if(callDataIdString.left(3) == '500' ){            
                Case c = [select Id,CallTime__c,Caller_PhoneNumber__c from Case Where Id = :callDataId];
                if(c==null) return;
                if( c.CallTime__c == null) c.CallTime__c = 0;
                c.CallTime__c =  c.CallTime__c + (Decimal.valueOf(doGetCallInfoResponseItem.content.duration) / 60).round(System.RoundingMode.UP).intValue();
                if ( !String.isBlank(t.CallerNumber__c)){
                    String phoneNumber = t.CallerNumber__c.startsWith('+81') ? t.CallerNumber__c.replace('+81', '0') : t.CallerNumber__c;
                    if ( String.isEmpty(c.Caller_PhoneNumber__c) )  c.Caller_PhoneNumber__c = phoneNumber;
                }
                update c;
                return;
            }
    }
}