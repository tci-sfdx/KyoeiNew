public class AgencyMailCompController {

    public String InquiryDetails{get; set;} //問い合わせ詳細
    public String AnswerDetails{get; set;} //回答詳細

    public Id agencyId { get;
        set {
            System.debug(value);

            List<DairitenSaport_CallData__c> DairitenSaports = [SELECT InquiryDetails__c
                                                                      ,AnswerDetails__c
                                                                  FROM DairitenSaport_CallData__c
                                                                 WHERE Id =:value];
        
            for(DairitenSaport_CallData__c Dairiten : DairitenSaports){
                InquiryDetails = framingString(Dairiten.InquiryDetails__c, 32); //問い合わせ詳細
                AnswerDetails = framingString(Dairiten.AnswerDetails__c, 45); //回答詳細
            }
        }
    }

    public String framingString(String paramString, Integer lineLength){

        if (String.isBlank(paramString)) return '';

        String tempString = '';
        Boolean isFirstRow = true;
            
        for(String str : paramString.split('\r\n|\r|\n')){
            if (!isFirstRow) tempString += '<br/>';
            tempString += formatNewLine(str, lineLength);
            isFirstRow = false;
        }
        return tempString;
    }
    
    //改行挿入処理
    private String formatNewLine(String str,Integer maxlength){

        if (String.isBlank(str)) return '';
        
        Integer strLength = str.length();
        String retStr = '';
        decimal nowLength = 0;
		for(Integer i = 0 ; i < str.length(); i++){
            String chr;
            Integer byteSize;
     
            // 1文字取得する
            chr = str.substring(i, (i + 1));
            // 1文字のバイト数を取得する
            byteSize = Blob.valueOf(chr).size();
            // 複数バイトの場合は全角とする
            if(byteSize > 1){
                nowLength += 1;
            }else{
            	nowLength += 0.6;
            }
            if(nowLength >= maxlength){
                retStr += '<br/>' + chr;
                nowLength = 0;
            }else{
                retStr += chr;
            }
        }
        return retStr;
    }
}