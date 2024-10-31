public class ManagementTriggerController {
    
    public ManagementTriggerController(boolean isExecuting, integer size){

    }
    
    public void CheckInputValue(AccidentReception_Management__c management){
        system.debug('------management------------'+management);
        
        final String errMsgDate = '日付形式（例：R3/1/1）で入力してください。';
        final String errMsgDateInsurance = '日付形式（例：【R3/1/1】,【H 22.10. 1】）で入力してください。';
        final String errMsgTime = '時間形式（例：MM:SS）で入力してください。';
        final String errMsgBaseText = '字以内の文字数を入力してください。';
        final String errMsgOverText = '文字超えています。';
        
        String errMsgText = '';
        String errMsgCode = '郵便番号形式（例：134-8541）で入力してください。';
        String errMsgHyphen = 'ハイフン含む半角1４文字を入力してください。';
        String errMsgHyphenYot = 'ハイフン含む半角1８文字を入力してください。';
        String errMsgTel = 'ハイフン含む半角1３文字を入力してください。';
        String errMsgHalfSize = '半角文字を入力してください。';  
           
        Pattern DatePattern = Pattern.compile('(R|H|S|T|M)\\d{1,2}/\\d{1,2}/\\d{1,2}'); // 日付形式限定（R3/1/1）前０つけないR・H・S・T・M
        Pattern DatePatternInsurance = Pattern.compile('(R|H|S|T|M) ( |\\d){2}.( |\\d){2}.( |\\d){2}'); //【H 21.10. 1】【H 22.10. 1】　※半角スペースも含まれています。
        Pattern TimePattern = Pattern.compile('\\d{1,2}:\\d{1,2}');// 時間形式限定 MM:SS    
        Pattern TimePatternAdd = Pattern.compile('\\d{1,2}[:：]\\d{1,2}');// 時間形式限定 MM:SS    
        Pattern HalfPattern = Pattern.compile('[0-9a-zA-Z\\-]+');// 半角英数字　ハイフン
        Pattern HalfSizePattern = Pattern.compile('[0-9a-zA-Z]+');// 半角
        Pattern PostalCodePattern = Pattern.compile('^([0-9]{3}-[0-9]{4})?$|^[0-9]{7}+$');// 郵便番号形式

        Util mu = new Util();
        
        
        /* 
         * 文字数チェック
        */
        
        InputCheck__c[] inputChks = [select id,name,InputItemAPIName__c,Size__c,InputCheckType__c from InputCheck__c];
        system.debug('inputChk:'+inputChks);
        for(InputCheck__c inputChk:inputChks){
            if(string.isNotBlank(inputChk.InputItemAPIName__c)){
                Object o = management.get(inputChk.InputItemAPIName__c);
                String str = String.valueOf(o);
                if (string.isNotBlank(str) && (str.length() > inputChk.Size__c)) {
                    errMsgText = String.valueOf(str.length() - inputChk.Size__c)+ errMsgOverText + String.valueOf(inputChk.Size__c) + errMsgBaseText;                  
                    management.addError(inputChk.InputItemAPIName__c, errMsgText);
                }
            }
        }
        
        /* 
         * 日付形式チェック
        */
        
        // 入電日
        if(string.isNotBlank(management.CallDate__c)){
            if(!DatePattern.matcher(management.CallDate__c).matches()){
                management.CallDate__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.CallDate__c) == System.Label.InvalidDateLabel){
                    management.CallDate__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.CallDateS__c = Date.parse(mu.ChangeToSCalender(management.CallDate__c));
                }
            }
        }else{
            management.CallDateS__c = null;
        }
        // 保険始期日① 
        if(string.isNotBlank(management.InsurancePeriod1From__c)){
            if( DatePattern.matcher(management.InsurancePeriod1From__c).matches()){
                if(mu.ChangeToSCalender(management.InsurancePeriod1From__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod1From__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod1FromS__c = Date.parse(mu.ChangeToSCalender(management.InsurancePeriod1From__c));
                }
            }else if(DatePatternInsurance.matcher(management.InsurancePeriod1From__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InsurancePeriod1From__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod1From__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod1FromS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InsurancePeriod1From__c));
                }
            }else{
                management.InsurancePeriod1From__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InsurancePeriod1FromS__c = null;
        }
        // 保険始期日②
        if(string.isNotBlank(management.InsurancePeriod2From__c)){
            if( DatePattern.matcher(management.InsurancePeriod2From__c).matches()){
                if(mu.ChangeToSCalender(management.InsurancePeriod2From__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod2From__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod2FromS__c = Date.parse(mu.ChangeToSCalender(management.InsurancePeriod2From__c));
                }
            }else if(DatePatternInsurance.matcher(management.InsurancePeriod2From__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InsurancePeriod2From__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod2From__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod2FromS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InsurancePeriod2From__c));
                }
            }else{
                management.InsurancePeriod2From__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InsurancePeriod2FromS__c = null;
        }
        // 保険終期日①   
        if(string.isNotBlank(management.InsurancePeriod1To__c)){
            if( DatePattern.matcher(management.InsurancePeriod1To__c).matches()){
                if(mu.ChangeToSCalender(management.InsurancePeriod1To__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod1To__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod1ToS__c = Date.parse(mu.ChangeToSCalender(management.InsurancePeriod1To__c));
                }
            }else if(DatePatternInsurance.matcher(management.InsurancePeriod1To__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InsurancePeriod1To__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod1To__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod1ToS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InsurancePeriod1To__c));
                }
            }else{
                management.InsurancePeriod1To__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InsurancePeriod1ToS__c = null;
        }
        // 保険終期日② 
        if(string.isNotBlank(management.InsurancePeriod2To__c)){
            if( DatePattern.matcher(management.InsurancePeriod2To__c).matches()){
                if(mu.ChangeToSCalender(management.InsurancePeriod2To__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod2To__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod2ToS__c = Date.parse(mu.ChangeToSCalender(management.InsurancePeriod2To__c));
                }
            }else if(DatePatternInsurance.matcher(management.InsurancePeriod2To__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InsurancePeriod2To__c) == System.Label.InvalidDateLabel){
                    management.InsurancePeriod2To__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsurancePeriod2ToS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InsurancePeriod2To__c));
                }
            }else{
                management.InsurancePeriod2To__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InsurancePeriod2ToS__c = null;
        }
        // 事故日 
        if(string.isNotBlank(management.AccidentDateInputW__c)){ 
            if(!DatePattern.matcher(management.AccidentDateInputW__c).matches()){
                management.AccidentDateInputW__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.AccidentDateInputW__c) == System.Label.InvalidDateLabel){
                    management.AccidentDateInputW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.AccidentDateInput__c = Date.parse(mu.ChangeToSCalender(management.AccidentDateInputW__c));
                }
            }
        }else{
            management.AccidentDateInput__c = null;
        }
        // 生年月日（被保険者）
        if(string.isNotBlank(management.InsuredPersonBirthW__c)){
            if( DatePattern.matcher(management.InsuredPersonBirthW__c).matches()){
                if(mu.ChangeToSCalender(management.InsuredPersonBirthW__c) == System.Label.InvalidDateLabel){
                    management.InsuredPersonBirthW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsuredPersonBirth__c = Date.parse(mu.ChangeToSCalender(management.InsuredPersonBirthW__c));
                }
            }else if(DatePatternInsurance.matcher(management.InsuredPersonBirthW__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InsuredPersonBirthW__c) == System.Label.InvalidDateLabel){
                    management.InsuredPersonBirthW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InsuredPersonBirth__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InsuredPersonBirthW__c));
                }
            }else{
                management.InsuredPersonBirthW__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InsuredPersonBirth__c = null;
        }
        // 生年月日（相手情報）
        if(string.isNotBlank(management.OtherPartyBirthW__c)){
            if( DatePattern.matcher(management.OtherPartyBirthW__c).matches()){
                if(mu.ChangeToSCalender(management.OtherPartyBirthW__c) == System.Label.InvalidDateLabel){
                    management.OtherPartyBirthW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.OtherPartyBirth__c = Date.parse(mu.ChangeToSCalender(management.OtherPartyBirthW__c));
                }
            }else if(DatePatternInsurance.matcher(management.OtherPartyBirthW__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.OtherPartyBirthW__c) == System.Label.InvalidDateLabel){
                    management.OtherPartyBirthW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.OtherPartyBirth__c = Date.parse(mu.ChangeToSCalenderInsurance(management.OtherPartyBirthW__c));
                }
            }else{
                management.OtherPartyBirthW__c.addError(errMsgDateInsurance);
            }
        }else{
            management.OtherPartyBirth__c = null;
        }
        /* 通院見込み（開始）
        if(string.isNotBlank(management.ExpectedHospitalFrom__c) && !DatePattern.matcher(management.ExpectedHospitalFrom__c).matches()){
            management.ExpectedHospitalFrom__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.ExpectedHospitalFrom__c)){
            if(!DatePattern.matcher(management.ExpectedHospitalFrom__c).matches()){
                management.ExpectedHospitalFrom__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.ExpectedHospitalFrom__c) == System.Label.InvalidDateLabel){
                    management.ExpectedHospitalFrom__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.ExpectedHospitalFromS__c = Date.parse(mu.ChangeToSCalender(management.ExpectedHospitalFrom__c));
                }
            }
        }else{
            management.ExpectedHospitalFromS__c = null;
        }
        
        
        /*// 通院見込み（終了）
        if(string.isNotBlank(management.ExpectedHospitalTo__c) && !DatePattern.matcher(management.ExpectedHospitalTo__c).matches()){
            management.ExpectedHospitalTo__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.ExpectedHospitalTo__c)){
            if(!DatePattern.matcher(management.ExpectedHospitalTo__c).matches()){
                management.ExpectedHospitalTo__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.ExpectedHospitalTo__c) == System.Label.InvalidDateLabel){
                    management.ExpectedHospitalTo__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.ExpectedHospitalToS__c = Date.parse(mu.ChangeToSCalender(management.ExpectedHospitalTo__c));
                }
            }
        }else{
            management.ExpectedHospitalToS__c = null;
        }
        
        /*// 入院見込み（開始）
        if(string.isNotBlank(management.ExpectedHospitalizationFrom__c) && !DatePattern.matcher(management.ExpectedHospitalizationFrom__c).matches()){
            management.ExpectedHospitalizationFrom__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.ExpectedHospitalizationFrom__c)){
            if(!DatePattern.matcher(management.ExpectedHospitalizationFrom__c).matches()){
                management.ExpectedHospitalizationFrom__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.ExpectedHospitalizationFrom__c) == System.Label.InvalidDateLabel){
                    management.ExpectedHospitalizationFrom__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.ExpectedHospitalizationFromS__c = Date.parse(mu.ChangeToSCalender(management.ExpectedHospitalizationFrom__c));
                }
            }
        }else{
            management.ExpectedHospitalizationFromS__c = null;
        }
        /*// 入院見込み（終了）
        if(string.isNotBlank(management.ExpectedHospitalizationTo__c) && !DatePattern.matcher(management.ExpectedHospitalizationTo__c).matches()){
            management.ExpectedHospitalizationTo__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.ExpectedHospitalizationTo__c)){
            if(!DatePattern.matcher(management.ExpectedHospitalizationTo__c).matches()){
                management.ExpectedHospitalizationTo__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.ExpectedHospitalizationTo__c) == System.Label.InvalidDateLabel){
                    management.ExpectedHospitalizationTo__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.ExpectedHospitalizationToS__c = Date.parse(mu.ChangeToSCalender(management.ExpectedHospitalizationTo__c));
                }
            }
        }else{
            management.ExpectedHospitalizationToS__c = null;
        }
        /*// 固定期間見込み（開始）
        if(string.isNotBlank(management.CastFixedPeriodFrom__c) && !DatePattern.matcher(management.CastFixedPeriodFrom__c).matches()){
            management.CastFixedPeriodFrom__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.CastFixedPeriodFrom__c)){
            if(!DatePattern.matcher(management.CastFixedPeriodFrom__c).matches()){
                management.CastFixedPeriodFrom__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.CastFixedPeriodFrom__c) == System.Label.InvalidDateLabel){
                    management.CastFixedPeriodFrom__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.CastFixedPeriodFromS__c = Date.parse(mu.ChangeToSCalender(management.CastFixedPeriodFrom__c));
                }
            }
        }else{
            management.CastFixedPeriodFromS__c = null;
        }
        /*// 固定期間見込み（終了）
        if(string.isNotBlank(management.CastFixedPeriodTo__c) && !DatePattern.matcher(management.CastFixedPeriodTo__c).matches()){
            management.CastFixedPeriodTo__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.CastFixedPeriodTo__c)){
            if(!DatePattern.matcher(management.CastFixedPeriodTo__c).matches()){
                management.CastFixedPeriodTo__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.CastFixedPeriodTo__c) == System.Label.InvalidDateLabel){
                    management.CastFixedPeriodTo__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.CastFixedPeriodToS__c = Date.parse(mu.ChangeToSCalender(management.CastFixedPeriodTo__c));
                }
            }
        }else{
            management.CastFixedPeriodToS__c = null;
        }
      
        // 生年月日(運転者)    
        if(string.isNotBlank(management.DriverBirthInputW__c)){
            if( DatePattern.matcher(management.DriverBirthInputW__c).matches()){
                if(mu.ChangeToSCalender(management.DriverBirthInputW__c) == System.Label.InvalidDateLabel){
                    management.DriverBirthInputW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.DriverBirth__c = Date.parse(mu.ChangeToSCalender(management.DriverBirthInputW__c));
                }
            }else if(DatePatternInsurance.matcher(management.DriverBirthInputW__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.DriverBirthInputW__c) == System.Label.InvalidDateLabel){
                    management.DriverBirthInputW__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.DriverBirth__c = Date.parse(mu.ChangeToSCalenderInsurance(management.DriverBirthInputW__c));
                }
            }else{
                management.DriverBirthInputW__c.addError(errMsgDateInsurance);
            }
        }else{
            management.DriverBirth__c = null;
        }
        /*// 受託日    
        if(string.isNotBlank(management.EntrustContractDate__c) && !DatePattern.matcher(management.EntrustContractDate__c).matches()){
            management.EntrustContractDate__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.EntrustContractDate__c)){
            if(!DatePattern.matcher(management.EntrustContractDate__c).matches()){
                management.EntrustContractDate__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.EntrustContractDate__c) == System.Label.InvalidDateLabel){
                    management.EntrustContractDate__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.EntrustContractDateS__c = Date.parse(mu.ChangeToSCalender(management.EntrustContractDate__c));
                }
            }
        }else{
            management.EntrustContractDateS__c = null;
        }
        /*// 納車日    DeliveryDate__c 
        if(string.isNotBlank(management.DeliveryDate__c) && !DatePattern.matcher(management.DeliveryDate__c).matches()){
            management.DeliveryDate__c.addError(errMsgDate);
        }*/
        if(string.isNotBlank(management.DeliveryDate__c)){
            if(!DatePattern.matcher(management.DeliveryDate__c).matches()){
                management.DeliveryDate__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.DeliveryDate__c) == System.Label.InvalidDateLabel){
                    management.DeliveryDate__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.DeliveryDateS__c = Date.parse(mu.ChangeToSCalender(management.DeliveryDate__c));
                }
            }
        }else{
            management.DeliveryDateS__c = null;
        }
        // 生年月日(負傷者火新対人)
        if(string.isNotBlank(management.InjuredBirthday__c)){
            if( DatePattern.matcher(management.InjuredBirthday__c).matches()){
                if(mu.ChangeToSCalender(management.InjuredBirthday__c) == System.Label.InvalidDateLabel){
                    management.InjuredBirthday__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InjuredBirthdayS__c = Date.parse(mu.ChangeToSCalender(management.InjuredBirthday__c));
                }
            }else if(DatePatternInsurance.matcher(management.InjuredBirthday__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InjuredBirthday__c) == System.Label.InvalidDateLabel){
                    management.InjuredBirthday__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InjuredBirthdayS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InjuredBirthday__c));
                }
            }else{
                management.InjuredBirthday__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InjuredBirthdayS__c = null;
        }
        // 生年月日(負傷者自動車人損)
        if(string.isNotBlank(management.InjuredBirthdayCL__c)){
            if( DatePattern.matcher(management.InjuredBirthdayCL__c).matches()){
                if(mu.ChangeToSCalender(management.InjuredBirthdayCL__c) == System.Label.InvalidDateLabel){
                    management.InjuredBirthdayCL__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InjuredBirthdayCLS__c = Date.parse(mu.ChangeToSCalender(management.InjuredBirthdayCL__c));
                }
            }else if(DatePatternInsurance.matcher(management.InjuredBirthdayCL__c).matches()){
                if(mu.ChangeToSCalenderInsurance(management.InjuredBirthdayCL__c) == System.Label.InvalidDateLabel){
                    management.InjuredBirthdayCL__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.InjuredBirthdayCLS__c = Date.parse(mu.ChangeToSCalenderInsurance(management.InjuredBirthdayCL__c));
                }
            }else{
                management.InjuredBirthdayCL__c.addError(errMsgDateInsurance);
            }
        }else{
            management.InjuredBirthdayCLS__c = null;
        }
        // 第一報入電日
        if(string.isNotBlank(management.IncomingCallDayCD__c)){
            if(!DatePattern.matcher(management.IncomingCallDayCD__c).matches()){
                management.IncomingCallDayCD__c.addError(errMsgDate);
            }else{
                if(mu.ChangeToSCalender(management.IncomingCallDayCD__c) == System.Label.InvalidDateLabel){
                    management.IncomingCallDayCD__c.addError(System.Label.InvalidDateLabel);
                }else{
                    management.IncomingCallDayCDS__c = Date.parse(mu.ChangeToSCalender(management.IncomingCallDayCD__c));
                }
            }
        }else{
            management.IncomingCallDayCDS__c = null;
        }
        /* 
         * 時間形式チェック
        */
        
        // 入電時間
        if(string.isNotBlank(management.CallDataIncomingCallTime__c) && !TimePatternAdd.matcher(management.CallDataIncomingCallTime__c).matches()){
            management.CallDataIncomingCallTime__c.addError(errMsgTime);
        }
        
        // 受託時間 EntrustContractTime__c  入力規制：時間形式限定
        if(string.isNotBlank(management.EntrustContractTime__c) && !TimePattern.matcher(management.EntrustContractTime__c).matches()){
            management.EntrustContractTime__c.addError(errMsgTime);
        }
        
        // 納車時間 DeliveryTime__c 入力規制：時間形式限定
        if(string.isNotBlank(management.DeliveryTime__c) && !TimePattern.matcher(management.DeliveryTime__c).matches()){
            management.DeliveryTime__c.addError(errMsgTime);
        }
        
        // 事故時間 AccidentTimeNisei__c    入力規制：時間形式限定
        if(string.isNotBlank(management.AccidentTimeNisei__c) && !TimePattern.matcher(management.AccidentTimeNisei__c).matches()){
            management.AccidentTimeNisei__c.addError(errMsgTime);
        }
        
        // 終話時間 EndTime__c  入力規制：時間形式限定
        if(string.isNotBlank(management.EndTime__c) && !TimePatternAdd.matcher(management.EndTime__c).matches()){
            management.EndTime__c.addError(errMsgTime);
        }
        
        /* 
         * 郵便番号形式チェック
        */
        
        // 郵便番号　ハイフン込み半角８文字        
        if(string.isNotBlank(management.InsuredZipCode__c) && !PostalCodePattern.matcher(management.InsuredZipCode__c).matches()){
            management.InsuredZipCode__c.addError(errMsgCode);
        }
        
        /* 
         * ハイフン含む半角形式チェック
        */
        
        // 証券番号①　ハイフン含む半角１４文字　SecuritiesNumberInput1__c
        if(string.isNotBlank(management.SecuritiesNumberInput1__c)){
            if(!HalfPattern.matcher(management.SecuritiesNumberInput1__c).matches() || management.SecuritiesNumberInput1__c.length() > 14){
                management.SecuritiesNumberInput1__c.addError(errMsgHyphen);
            }
        }
        // 証券番号②　ハイフン含む半角１４文字　SecuritiesNumberInput2__c
        if(string.isNotBlank(management.SecuritiesNumberInput2__c)){
            if(!HalfPattern.matcher(management.SecuritiesNumberInput2__c).matches() || management.SecuritiesNumberInput2__c.length() > 14){
                management.SecuritiesNumberInput2__c.addError(errMsgHyphen);
            }
        }
        
        // 証券番号（伝言管理）　ハイフン含む半角１４文字　PolicyNumberMsg__c
        if(string.isNotBlank(management.PolicyNumberMsg__c)){
            if(!HalfPattern.matcher(management.PolicyNumberMsg__c).matches() || management.PolicyNumberMsg__c.length() > 14){
                management.PolicyNumberMsg__c.addError(errMsgHyphen);
            }
        }    
        // 証券番号 SecuritiesNumbeYot__c   ハイフン含む半角１４文字→ハイフン含む半角18文字に変更
        if(string.isNotBlank(management.SecuritiesNumbeYot__c)){
            if(!HalfPattern.matcher(management.SecuritiesNumbeYot__c).matches() || management.SecuritiesNumbeYot__c.length() > 18){
                management.SecuritiesNumbeYot__c.addError(errMsgHyphenYot);
            }
        }
        // 委託者TEL   EntrusterPhoneNumber__c 入力規制：ハイフン込みの半角13文字　　
        if(string.isNotBlank(management.EntrusterPhoneNumber__c)){
            if(!HalfPattern.matcher(management.EntrusterPhoneNumber__c).matches() || management.EntrusterPhoneNumber__c.length() > 13){
                management.EntrusterPhoneNumber__c.addError(errMsgTel);
            }
        }
        
        /* 
         * 半角形式チェック
        */
        // 枝番①
        if(string.isNotBlank(management.SecuritiesBranchNumber1__c) && !HalfSizePattern.matcher(management.SecuritiesBranchNumber1__c).matches()){
            management.SecuritiesBranchNumber1__c.addError(errMsgHalfSize);
        }
        // 枝番②
        if(string.isNotBlank(management.SecuritiesBranchNumber2__c) && !HalfSizePattern.matcher(management.SecuritiesBranchNumber2__c).matches()){
            management.SecuritiesBranchNumber2__c.addError(errMsgHalfSize);
        }
        
        // 枝番（証券番号）　SecuritiesBranchNumberMsg__c
        if(string.isNotBlank(management.SecuritiesBranchNumberMsg__c) && !HalfSizePattern.matcher(management.SecuritiesBranchNumberMsg__c).matches()){
            management.SecuritiesBranchNumberMsg__c.addError(errMsgHalfSize);
        }
    }
    
    public void ChangeData(AccidentReception_Management__c management){       
        
        // 補記が入力がある場合、「有」、なしの場合、「無」
        if(string.isNotBlank(management.Supplement__c)){
            management.PresenceAbsence__c = '有';
        }else{
            management.PresenceAbsence__c = '無';
        }

        if(management.destination__c == null){
            management.MailLongText__c = '';
            return;
        }else{
            if(!destinationMap.containsKey(management.destination__c)) return ;
            Destination__c destination =  destinationMap.get(management.destination__c);
            management.MailLongText__c = destination.longText__c;
        }
        
    }
    public void autoInputDate(AccidentReception_Management__c management){
            Datetime createdDate = Datetime.now();
            String strConvertedDate = createdDate.format('yyyy/MM/dd/HH:mm', 'Asia/Tokyo');
            system.debug(strConvertedDate);
            PostingDate inputDate = new PostingDate();
            
            management.CallDate__c = inputDate.Posting(strConvertedDate);
    }
    
    public void setCallData(AccidentReception_Management__c management){
        AccidentReception_CallData__c calldata = [select id, ContractorName__c,AccidentDate__c,
                             PolicyNumber__c,IncomingCallTime__c,
                             IncomingCallDay__c,RegisteredPhoneNumber1__c,
                             RegisteredPhoneNumber2__c,Relationship__c,
                             CallerContactInformation1__c, CallerContactInformation2__c,AgencyChk__c,
                             Name from AccidentReception_CallData__c where id=:management.ContractorName__c];

        // 契約者名
        if(string.isNotBlank(calldata.ContractorName__c)){
            management.ContractorNameCD__c = calldata.ContractorName__c;
        }else{
            management.ContractorNameCD__c = '';
        }
        // 事故日
        if(string.isNotBlank(calldata.AccidentDate__c)){
            management.AccidentDateCD__c = calldata.AccidentDate__c;
        }else{
            management.AccidentDateCD__c = '';
        }
        // 証券番号
        if(string.isNotBlank(calldata.PolicyNumber__c)){
            management.PolicyNumberCD__c = calldata.PolicyNumber__c;}
        else{
            management.PolicyNumberCD__c = '';
        }
        // 第一報入電時間
        if(string.isNotBlank(calldata.IncomingCallTime__c)){
            management.IncomingCallTimeCD__c = calldata.IncomingCallTime__c;}
        else{
            management.IncomingCallTimeCD__c = '';
        }
        // 第一報入電日
        if(string.isNotBlank(calldata.IncomingCallDay__c)){
            management.IncomingCallDayCD__c = calldata.IncomingCallDay__c;}
        else{
            management.IncomingCallDayCD__c = '';
        }
        // 登録の電話番号1
        if(string.isNotBlank(calldata.RegisteredPhoneNumber1__c)){
            management.RegisteredPhoneNumber1CD__c = calldata.RegisteredPhoneNumber1__c;}
         else{
            management.RegisteredPhoneNumber1CD__c = '';
        }
        // 登録の電話番号2
        if(string.isNotBlank(calldata.RegisteredPhoneNumber2__c)){
            management.RegisteredPhoneNumber2CD__c = calldata.RegisteredPhoneNumber2__c;}
        else{
            management.RegisteredPhoneNumber2CD__c = '';
        }
        // 入電者と契約者の関係
        if(string.isNotBlank(calldata.Relationship__c)){
            management.RelationshipCD__c = calldata.Relationship__c;}
        else{
            management.RelationshipCD__c = '';
        }
        // 入電者の連絡先1
        if(string.isNotBlank(calldata.CallerContactInformation1__c)){
            management.CallerContactInformationCD__c = calldata.CallerContactInformation1__c;}  
        else{
            management.CallerContactInformationCD__c = '';
        }
        // 入電者の連絡先2
        if(string.isNotBlank(calldata.CallerContactInformation2__c)){
            management.CallerContactInformation2CD__c = calldata.CallerContactInformation2__c;}
        else{
            management.CallerContactInformation2CD__c = '';
        }
        // 入電者名
        if(string.isNotBlank(calldata.Name)){
            management.NameCD__c = calldata.Name;}
        else{
            management.NameCD__c = '';
        }
        system.debug('calldata');
        
    }
    private Map<Id, Destination__c> destinationMap;
    private void initDestinationMap(){
        destinationMap = new Map<Id, Destination__c>([SELECT Id, Name, longText__c FROM Destination__c]);
    }
    public void OnBeforeInsert(AccidentReception_Management__c[] newManagements){
        //メール本文用（全件抽出）
        initDestinationMap();
        
        // 初期設定
        for (AccidentReception_Management__c management:newManagements){
            
            // コールデータ画面から引き続き
            if(string.isNotBlank(management.ContractorName__c)){
                setCallData(management);
            }
            
            // 入力チェック
            CheckInputValue(management);
            
            // 各種変換
            ChangeData(management);
            
            // 自動入力
            if(string.isBlank(management.BedoreSessionID__c) && string.isBlank(management.CallDate__c)){
                autoInputDate(management);
            }  
            
            // 個人情報同意 複数回変更された場合、初回保存時に保存日時、作成者を反映 初回のみ更新
            // 個人情報の同意確認日（ConfirmationDate__c）、同意者（PersonInfoConfirmInput__c）                
            system.debug('確認有無'+management.PersonInfoConfirm__c);
            if(string.isNotBlank(management.PersonInfoConfirm__c)
               &&(management.PersonInfoConfirm__c =='案内のうえ了承済み')){
                   management.ConfirmationDate__c = Date.valueOf(management.LastModifiedDate);                
               }
            system.debug('management:'+management);
        }
    }

    public void ChangePhaseOwerId(AccidentReception_Management__c[] newManagements){

        //承認待ちキュー
        Group que = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'ApprovalQueue'];

        for (AccidentReception_Management__c management : newManagements){
            if (management.Phase__c == '対応中'){
                management.Phase__c = 'SV承認待ち';
                management.OwnerId = que.Id;
            }
        }
    }
    
    // 初期値設定
    public void OnBeforeUpdate(AccidentReception_Management__c[] oldManagements, AccidentReception_Management__c[] newManagements){
        //メール本文用（全件抽出）
        initDestinationMap();
        
        // 初期設定
        for (AccidentReception_Management__c management:newManagements){
            for(AccidentReception_Management__c oldmanagement:oldManagements){
                if (oldmanagement.id != management.id) continue;
                system.debug('id:'+management.ContractorName__c);
                // コールデータ画面から引き続き
                if(string.isNotBlank(management.ContractorName__c)){
                    setCallData(management);
                }
                
                // 入力チェック
                CheckInputValue(management);                
                
                // 各種変換、設定
                ChangeData(management);
                               
                // SV設定 フェーズを帳票出力に変えた人
                if(management.Phase__c == 'SV確認中'){
                    management.SV__c = UserInfo.getName();
                }
                
                // 所有者設定                
                if((oldmanagement.Phase__c <> 'SV承認待ち')&&(management.Phase__c == 'SV承認待ち')){
                    Group que = [Select Id From Group where Name = '承認待ちキュー' limit 1];
                    if(string.isNotBlank(que.id)){
                        management.OwnerId = que.id;
                    }
                }
                
                if((oldmanagement.Phase__c <> '対応中')&&(management.Phase__c == '対応中')){
                    Group que = [Select Id From Group where Name = '差戻しキュー' limit 1];
                    if(string.isNotBlank(que.id)){
                        management.OwnerId = que.id;
                    }
                }
                
                if((oldmanagement.Phase__c <> 'メール送信済み')&&(management.Phase__c == 'メール送信済み')){
                    Group que = [Select Id From Group where Name = '承認待ちキュー' limit 1];
                    if(string.isNotBlank(que.id)){
                        management.OwnerId = que.id;
                    }
                }
                // ログインユーザロールの設定
                
                UserRole user =  [Select  Name from UserRole  where id =: UserInfo.getUserRoleId()];                          
                management.UserRole__c = user.Name;
                
                
                // 個人情報同意 複数回変更された場合、初回保存時に保存日時、作成者を反映 初回のみ更新
                // 個人情報の同意確認日（ConfirmationDate__c）、同意者（PersonInfoConfirmInput__c）                
                system.debug('確認有無'+management.PersonInfoConfirm__c);
                if(string.isBlank(oldmanagement.PersonInfoConfirm__c)
                    &&string.isNotBlank(management.PersonInfoConfirm__c)
                       &&(management.PersonInfoConfirm__c =='案内のうえ了承済み')){
                    management.ConfirmationDate__c = Date.valueOf(management.LastModifiedDate);                
                }
                system.debug('management:'+management);
            }            
        }
    }
}