public class CallDataTriggerController {
    
        public CallDataTriggerController(boolean isExecuting, integer size){
            
        }
    	//ChangeData
        public void ChangeData(AccidentReception_CallData__c newCallData){
            Datetime myDate = Datetime.now();
            String strConvertedDate = myDate.format('yyyy/MM/dd/HH:mm', 'Asia/Tokyo');
            system.debug(strConvertedDate);
        	PostingDate au = new PostingDate();
			
        	newCallData.IncomingCallDay__c = au.Posting(strConvertedDate);
            newCallData.IncomingCallTime__c = au.PostingTime(strConvertedDate);
        }
    
    //OnBeforeInsert
    public void OnBeforeInsert(AccidentReception_CallData__c[] newCallDatas){
        for(AccidentReception_CallData__c newCallData : newCallDatas){
            system.debug(newCallData.IncomingCallDayAuto__c);
            system.debug(newCallData.IncomingCallDay__c);
            if(string.isBlank(newCallData.BedoreSessionID__c)){
                ChangeData(newCallData);
            }else{
                if(String.isBlank(newCallData.Name)){
                    newCallData.Name = 'フメイ';
                }
            }
        }
    }

}