public with sharing class CaseTriggerHandler {
	public CaseTriggerHandler(){}
        public static final String integerRegulation = '[^0-9]';
        public static final String replacement = '/';
    public void convertBedoreVoice(Case[] bedoreVoiceLogList){
        List<Case> bedoreVoiceList = new List<Case>(bedoreVoiceLogList);
        List<AccidentReception_CallData__c> callDataList = new List<AccidentReception_CallData__c>();
        List<AccidentReception_Management__c> managementList = new List<AccidentReception_Management__c>();
        system.debug('bedoreVoiceList'+bedoreVoiceList);
        try{
            for(Case bedoreVoice:bedoreVoiceList){
                 system.debug('傷害事故シナリオ'+bedoreVoice.ScenarioType__c);
                AccidentReception_Management__c management = new AccidentReception_Management__c();
                switch on bedoreVoice.ScenarioType__c {
                    when '傷害事故シナリオ' {
                        management = generateDisabilityAccidentScenario(bedoreVoice);
                    }
                    when '賠償事故シナリオ' {
                        management = generateCompensationAccidentScenario(bedoreVoice);
                    }
                    when '携行品・用品事故シナリオ' {
                        management = generateCarryingItemsAccidentScenario(bedoreVoice);
                    }
                    when '第三分野事故シナリオ' {
                        management = generateThirdSectorAccidentScenario(bedoreVoice);
                    }
                    when 'その他事故シナリオ' {
                        management = generateOtherAccidentScenario(bedoreVoice);
                    }
                    when '台風事故シナリオ' {
                        management = generateTyphoonAccidentScenario(bedoreVoice);
                    }
                    when '地震事故シナリオ' {
                        management = generateEarthquakeAccidentScenario(bedoreVoice);
                    }
                    when '物損事故シナリオ' {
                        management = generatePropertyDamageAccidentScenario(bedoreVoice);
                    }
                    when '既報事故シナリオ' {
                        management = generateReportedAccidentScenario(bedoreVoice);
                    }
                    when '契約関連シナリオ' {
                        management = generateContractRelatedScenario(bedoreVoice);
                    }
                    when 'その他問合せシナリオ' {
                        management = generateOtherInquiriesScenario(bedoreVoice);
                    }
                }
                management = generateCommonManagement(management,bedoreVoice);
                AccidentReception_CallData__c callData = generateCallDate(management);
                callDataList.add(callData); 
                ManagementList.add(management); 
            }
    
            system.debug('callDataList:'+callDataList);    
            insert callDataList;
                for(AccidentReception_CallData__c insertedCallData:callDataList){
                    for(AccidentReception_Management__c management:ManagementList){
                        if(insertedCallData.BedoreSessionID__c.equals(management.BedoreSessionID__c)){
                            system.debug(insertedCallData.BedoreSessionID__c);
                            management.ContractorName__c = insertedCallData.ID;
                        }
                    }
                }
            system.debug('m:'+ManagementList.get(0));   
            insert ManagementList;  
        }catch(Exception e) {
            system.debug('e'+e);
            ErrorNotificationHandler.sendEmailMessage(e);
            ErrorNotificationHandler.sendChatterMessage();
        }
    }
    
    //コールデータ   
    public AccidentReception_CallData__c generateCallDate(AccidentReception_Management__c bedoreVoice){
        String ContractorRelation = bedoreVoice.CallerContractorRelationInput__c;
        String ContractorName = bedoreVoice.ContractorNameInput1__c;
        if(String.isEmpty(bedoreVoice.CallerContractorRelationInput__c)){
            ContractorRelation = bedoreVoice.OperatorContractorRelationMsg__c;
        }
        if(String.isEmpty(bedoreVoice.ContractorNameInput1__c)){
            ContractorName = bedoreVoice.ContractorNameMsg__c;
        }
        AccidentReception_CallData__c callData = new AccidentReception_CallData__c(ContractorName__c = ContractorName,
        Relationship__c = ContractorRelation,Name = bedoreVoice.CallerNameInput__c,CallerContactInformation1__c = bedoreVoice.CallerContactInfo__c,
        BedoreScenarioType__c = bedoreVoice.BedoreScenarioType__c, BedoreSessionID__c = bedoreVoice.BedoreSessionID__c,
        VoiceLogURL__c = bedoreVoice.VoiceLogURL__c,BedorePolicyNumber__c = bedoreVoice.BedorePolicyNumber__c,
        IncomingCallDay__c = bedoreVoice.CallDate__c,IncomingCallTime__c = bedoreVoice.CallDataIncomingCallTime__c,AccidentDate__c = bedoreVoice.AccidentDateInputW__c
        );
        return callData;
    }
    //傷害事故
    public AccidentReception_Management__c generateDisabilityAccidentScenario(Case bedoreVoice){
        system.debug('シナリオ:'+bedoreVoice.ScenarioType__c);
        String AccidentSituation;
        String DamageDate;
        String ContractorName = bedoreVoice.ContractorName__c;
        String SiteSymptoms = '';
        String AccidentSituationText = '';
        String Remarks = '';
        String Necessity;
        String ContactDate = '';
        String Addition;
        if(String.isNotEmpty(bedoreVoice.SiteSymptoms__c)){
            SiteSymptoms = bedoreVoice.SiteSymptoms__c;
        }
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);

        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.SiteSymptoms + SiteSymptoms + 
                				 System.Label.AccidentSituation + AccidentSituationText;
            Necessity = System.Label.Unnecessary;
            Addition = System.Label.SupplementMsg;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.SiteSymptoms + SiteSymptoms + 
            System.Label.AccidentSituation + AccidentSituationText;
            Necessity = System.Label.Necessary;
            ContactDate = System.Label.ContactDate;
            Addition = System.Label.SupplementShortMsg;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,
                                                           AccidentDateInputW__c = DamageDate,AccidentTime__c = System.Label.Unlistened,
                                                           LocationTypeSupplement__c = System.Label.Unlistened,AccidentSituationStatement__c = AccidentSituation,
                                                           InsuredKana__c = bedoreVoice.InsuredNameKana__c,HospitalName__c = System.Label.Unlistened,
                                                           InsuranceYesNo__c = System.Label.Unlistened,BillingAddressInput__c = bedoreVoice.ShippingAddressAndName__c,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = Necessity,
                                                           ContactAddressInput__c = System.Label.ToCaller,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = Addition,ContactDateW__c = ContactDate,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + System.Label.RemarksMsg,
                                                           RecordTypeId = System.Label.TypeFireRecordType);
        return management;
    }
    //賠償事故
    public AccidentReception_Management__c generateCompensationAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String OtherName;
        String AccidentSituationText = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String OtherPartyKana;
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.CompensationReception + AccidentSituationText;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.CompensationReception + AccidentSituationText;
        }
        if(bedoreVoice.VictimIdentityVerification__c.equals(System.Label.False)){
            OtherName = System.Label.UnknownOtherInformation;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        if(String.isEmpty(bedoreVoice.OtherNameKana__c)){
            OtherPartyKana = bedoreVoice.OtherPartyCorporateName__c;
        }else{
            OtherPartyKana = bedoreVoice.OtherNameKana__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,
                                                           AccidentTime__c = System.Label.Unlistened,
                                                           LocationTypeSupplement__c = System.Label.Unlistened,AccidentSituationStatement__c = AccidentSituation,
                                                           InsuranceYesNo__c = System.Label.Unlistened,BillingAddressInput__c = System.Label.Unlistened,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = System.Label.Necessary,
                                                           ContactAddressInput__c = System.Label.ToCaller,
                                                           ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           InconvenientTime__c = System.Label.Unlistened,Remarks__c = System.Label.MessageToManager + 
                                                           Remarks + System.Label.RemarksMsg,
                                                           OtherPartyName__c = OtherName,OtherPartyKana__c = OtherPartyKana,
                                                           OtherPartyContactInfoA__c = bedoreVoice.OtherPhoneNumber__c,
                                                           ContactDateW__c = System.Label.ContactDate,
                                                           Addition__c = System.Label.SupplementShortMsg,RecordTypeId = System.Label.TypeFireRecordType);
        return management;
    }
    //携行品・用品事故
    public AccidentReception_Management__c generateCarryingItemsAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String AccidentSituationText = '';
        String Remarks = '';
        String CarryingItems = '';
        String Necessity;
        String ContactDate = '';
        String Addition;
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        if(String.isNotEmpty(bedoreVoice.CarryingItems__c)){
            CarryingItems = bedoreVoice.CarryingItems__c;
        }
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.CarryingItems+ CarryingItems+ System.Label.AccidentSituation + AccidentSituationText;
            Necessity = System.Label.Unnecessary;
            Addition = System.Label.SupplementMsg;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.CarryingItems + CarryingItems+ System.Label.AccidentSituation + AccidentSituationText;
            Necessity = System.Label.Necessary;
            ContactDate = System.Label.ContactDate;
            Addition = System.Label.SupplementShortMsg;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,AccidentTime__c = System.Label.Unlistened,
                                                           LocationTypeSupplement__c = System.Label.Unlistened,AccidentSituationStatement__c = AccidentSituation,
                                                           InsuredKana__c = bedoreVoice.InsuredNameKana__c,InsuranceYesNo__c = System.Label.Unlistened,
                                                           BillingAddressInput__c = bedoreVoice.ShippingAddressAndName__c,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = Necessity,
                                                           ContactAddressInput__c = System.Label.ToCaller,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           InconvenientTime__c = System.Label.Unlistened,ContactDateW__c = ContactDate,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + System.Label.RemarksMsg,
                                                           Addition__c = Addition,
                                                           RecordTypeId = System.Label.TypeFireRecordType);
        return management;
    }
    //その他事故
    public AccidentReception_Management__c generateOtherAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String AccidentSituationText = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation = AccidentSituationText;
        }else{
           AccidentSituation  = System.Label.UnknownDate +' '+ AccidentSituationText; 
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,
                                                           AccidentTime__c = System.Label.Unlistened,
                                                           LocationTypeSupplement__c = System.Label.Unlistened,
                                                           AccidentSituationStatement__c = AccidentSituation,
                                                           InsuranceYesNo__c = System.Label.Unlistened,
                                                           BillingAddressInput__c = System.Label.Unlistened,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = System.Label.Necessary,
                                                           ContactAddressInput__c = System.Label.ToCaller,
                                                           ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementOtherMsg,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + System.Label.RemarksMsg,
                                                           RecordTypeId = System.Label.TypeFireRecordType);
        return management;
    }
    //台風事故
    public AccidentReception_Management__c generateTyphoonAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String DisasterName;
        String DisasterDetail;
        String AccidentSituationText = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String BillingDocumentsConfirmation;
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.Damages+ AccidentSituationText;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.Damages + AccidentSituationText;
        }
        if(bedoreVoice.DisasterVerification__c.equals(System.Label.True)){
            DisasterName = bedoreVoice.DisasterName__c;
            DisasterDetail = bedoreVoice.DisasterName__c;
        }else{
            DisasterName = System.Label.UnknownTyphoons;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        if(bedoreVoice.BillingDocumentsConfirmation__c.equals(System.Label.True)){
            BillingDocumentsConfirmation = System.Label.BillingAddress;
        }else{
            BillingDocumentsConfirmation = bedoreVoice.ShippingAddressAndName__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(DisasterType__c = System.Label.Typhoon,CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,
                                                           AccidentSituationStatement__c = AccidentSituation,
                                                           InsuranceYesNo__c = System.Label.Unlistened,
                                                           BillingAddressInput__c = BillingDocumentsConfirmation,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = System.Label.Unnecessary,
                                                           ContactAddressInput__c = System.Label.ToNotifier,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementMsg,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + 
                                                           System.Label.RemarksMsg,RecordTypeId = System.Label.TypeFireRecordType,
                                                           DisasterName__c = DisasterName,DisasterDetails__c = DisasterDetail,
                                                           DestinationLocation__c = bedoreVoice.DamagedPropertyAddress__c);
        return management;
    }
    //地震事故
    public AccidentReception_Management__c generateEarthquakeAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String DisasterName;
        String DisasterDetail;
        String AccidentSituationText = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName =  bedoreVoice.ContractorCorporateName__c;
        }
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.Damages+ AccidentSituationText;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.Damages + AccidentSituationText;
        }
        if(bedoreVoice.DisasterVerification__c.equals(System.Label.True)){
            DisasterName = bedoreVoice.DisasterName__c;
            DisasterDetail = bedoreVoice.DisasterName__c;
        }else{
            DisasterName = System.Label.UnknownUarthquake;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(DisasterType__c = System.Label.Earthquake,CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,
                                                           AccidentSituationStatement__c = AccidentSituation,
                                                           InsuranceYesNo__c = System.Label.Unlistened,BillingAddressInput__c = System.Label.Unlistened,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = System.Label.Necessary,
                                                           ContactAddressInput__c = System.Label.ToNotifier,
                                                           ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementOtherMsg,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + System.Label.RemarksMsg,
                                                           RecordTypeId = System.Label.TypeFireRecordType,
                                                           DisasterName__c = DisasterName,DisasterDetails__c = DisasterDetail,
                                                           DestinationLocation__c = bedoreVoice.DamagedPropertyAddress__c);
        return management;
    }
    //物損事故
    public AccidentReception_Management__c generatePropertyDamageAccidentScenario(Case bedoreVoice){
        String AccidentSituation;
        String DamageDate;
        String DisasterName;
        String DisasterDetail;
        String Damages = '';
        String CauseOfDamages = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.Damages__c)){
            Damages = bedoreVoice.Damages__c;
        }
        if(String.isNotEmpty(bedoreVoice.CauseOfDamages__c)){
            CauseOfDamages = bedoreVoice.CauseOfDamages__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        String ContractorRelation = convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c, bedoreVoice.CallerRelation__c);
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        if(bedoreVoice.AccidentDateRevealed__c.equals(System.Label.True)){
            AccidentSituation  = System.Label.Damages + Damages + System.Label.CauseOfDamage+ CauseOfDamages;
        }else{
            AccidentSituation  = System.Label.UnknownDate + System.Label.Damages + Damages + System.Label.CauseOfDamage+ CauseOfDamages;
        }
        if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
            DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentDateInputW__c = DamageDate,
                                                           AccidentTime__c = System.Label.Unlistened,
                                                           AccidentSituationStatement__c = AccidentSituation,
                                                           InsuranceYesNo__c = System.Label.Unlistened,BillingAddressInput__c = System.Label.Unlistened,
                                                           PrecautionsUntilArrival__c = System.Label.Unguided,Necessity__c = System.Label.Necessary,
                                                           ContactAddressInput__c = System.Label.ToNotifier,
                                                           ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementOtherMsg,
                                                           Remarks__c = System.Label.MessageToManager+ Remarks + System.Label.RemarksMsg,
                                                           RecordTypeId = System.Label.TypeFireRecordType,DestinationLocation__c = bedoreVoice.DamagedPropertyAddress__c);
        return management;
    }
    
    //既報事故
    public AccidentReception_Management__c generateReportedAccidentScenario(Case bedoreVoice){
        String MessageText;
        String DamageDate;
        String ReferenceNumber = '';
        String InquiryContents = '';
        if(String.isNotEmpty(bedoreVoice.ReferenceNumber__c)){
            ReferenceNumber = bedoreVoice.ReferenceNumber__c;
        }
        if(String.isNotEmpty(bedoreVoice.InquiryContents__c)){
            InquiryContents = bedoreVoice.InquiryContents__c;
        }
        String ContractorRelation =  convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c,bedoreVoice.CallerRelation__c);
        String ContractorName = bedoreVoice.ContractorName__c;
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        if(bedoreVoice.ReferralNumberVerification__c.equals(System.Label.True)){
            MessageText = System.Label.ReferenceNumber + ReferenceNumber;
        }else{
            if(String.isNotEmpty(bedoreVoice.DamageDate__c)){
                DamageDate = convertDate(bedoreVoice.DamageDate__c.replaceAll(integerRegulation, replacement));
            	MessageText = System.Label.AccidentDate + DamageDate;
            }else{
                MessageText = System.Label.UnknownAccidentdate;
            }            
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(MessageMiscellaneousDetails__c = bedoreVoice.Message__c,OperatorContractorRelationMsg__c = ContractorRelation,
                                                           ContractorNameMsg__c = ContractorName,HeadingMsg__c = System.Label.Headline,
                                                           TextMsg__c = MessageText + '\n'+ System.Label.Inquiry + InquiryContents,
                                                           Necessity__c = System.Label.Necessary,ContactAddressInput__c = System.Label.ToNotifier,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementShortMsg,
                                                           RecordTypeId = System.Label.CallManagementRecordType,AccidentDateInputW__c = DamageDate
                                                           );
        return management;
    }
    //契約関連
    public AccidentReception_Management__c generateContractRelatedScenario(Case bedoreVoice){
        String ContractorRelation =  convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c,bedoreVoice.CallerRelation__c);
        String ContractorName = bedoreVoice.ContractorName__c;
        String InquiryContents = '';
        if(String.isNotEmpty(bedoreVoice.InquiryContents__c)){
            InquiryContents = bedoreVoice.InquiryContents__c;
        }
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(MessageMiscellaneousDetails__c = bedoreVoice.Message__c,OperatorContractorRelationMsg__c = ContractorRelation,
                                                           ContractorNameMsg__c = ContractorName,HeadingMsg__c = System.Label.PreReported,TextMsg__c = System.Label.Inquiry + InquiryContents,
                                                           Necessity__c = System.Label.Necessary,ContactAddressInput__c = System.Label.ToNotifier,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementOtherMsg,
                                                           RecordTypeId = System.Label.CallManagementRecordType
                                                           );
        return management;
    }
    //その他問い合わせ
    public AccidentReception_Management__c generateOtherInquiriesScenario(Case bedoreVoice){
        String ContractorRelation = '';
        String ContractorName = bedoreVoice.ContractorName__c;
        String InquiryContents = '';
        if(String.isNotEmpty(bedoreVoice.InquiryContents__c)){
            InquiryContents = bedoreVoice.InquiryContents__c;
        }
        if(bedoreVoice.AgreementKyoei__c.equals(System.Label.False)){
            ContractorRelation = System.Label.NotAgreementKyoei;
        }else{
            if(String.isEmpty(bedoreVoice.ContractorIdentityVerification__c)){
                if(String.isNotEmpty(bedoreVoice.CallerRelation__c)){
                    ContractorRelation = System.Label.Contractor+bedoreVoice.CallerRelation__c;
                }
            }else{
                if(bedoreVoice.ContractorIdentityVerification__c.equals(System.Label.True)){
                    ContractorRelation = System.Label.ContractorHimself;
                }else{
                	if(String.isNotEmpty(bedoreVoice.CallerRelation__c)){
                    	ContractorRelation = System.Label.Contractor+bedoreVoice.CallerRelation__c;
                	}
                }
            }
        }
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(OperatorContractorRelationMsg__c = ContractorRelation,
                                                           ContractorNameMsg__c = ContractorName,HeadingMsg__c = System.Label.PreReported,TextMsg__c = System.Label.Inquiry + InquiryContents,
                                                           Necessity__c = System.Label.Necessary,ContactAddressInput__c = System.Label.ToNotifier,ContactPhoneNumber__c = bedoreVoice.ReceivedNumber__c,
                                                           ContactDateW__c = System.Label.ContactDate,
                                                           InconvenientTime__c = System.Label.Unlistened,Addition__c = System.Label.SupplementOtherMsg,
                                                           RecordTypeId = System.Label.CallManagementRecordType);
        return management;
    }
    //第三分野事故
    public AccidentReception_Management__c generateThirdSectorAccidentScenario(Case bedoreVoice){
        String ContractorName = bedoreVoice.ContractorName__c;
        String ContractorRelation =  convertContractorRelation(bedoreVoice.ContractorIdentityVerification__c,bedoreVoice.CallerRelation__c);
        String AccidentSituationText = '';
        String Remarks = '';
        if(String.isNotEmpty(bedoreVoice.AccidentSituation__c)){
            AccidentSituationText = bedoreVoice.AccidentSituation__c;
        }
        if(String.isNotEmpty(bedoreVoice.Remarks__c)){
            Remarks = bedoreVoice.Remarks__c;
        }
        if(String.isEmpty(bedoreVoice.ContractorName__c)){
            ContractorName = bedoreVoice.ContractorCorporateName__c;
        }
        AccidentReception_Management__c management = new AccidentReception_Management__c(CallerContractorRelationInput__c = ContractorRelation,
                                                           ContractorNameInput1__c = ContractorName,AccidentSituation__c = AccidentSituationText+System.Label.MessageToManager+ Remarks+System.Label.RemarksMsg,
                                                           InsuredKana__c = bedoreVoice.InsuredNameKana__c,InsuranceYesNo__c = System.Label.Unlistened,ContactDateT__c = System.Label.ContactDateUnguided,
                                                           ContactAddressInput2__c = System.Label.ToNotifier,ContactPhoneNumber2__c = bedoreVoice.ReceivedNumber__c,
                                                           InconvenientTime2__c = System.Label.Unlistened,PersonInfoConfirm__c = System.Label.Agreed,RecordTypeId = System.Label.ThirdFieldRecordType);
        return management;
    }
    //事故受付・伝言管理共通項目
    public AccidentReception_Management__c generateCommonManagement(AccidentReception_Management__c management,Case callData){
        String ReceivedTime;
        String ReceivedDate;
        String CallerName;
        String ContractorName = callData.ContractorName__c;
        if(String.isEmpty(callData.ContractorName__c)){
            ContractorName = callData.ContractorCorporateName__c;
        }
        if(String.isNotEmpty(callData.ReceivedDateTime__c)){
            ReceivedDate = convertDate(callData.ReceivedDateTime__c.substringBefore(' '));
            ReceivedTime = callData.ReceivedDateTime__c.substringAfter(' ').left(5);
        }
        if(String.isEmpty(callData.ContractorIdentityVerification__c)){
            CallerName = callData.CallerName__c;
        }else{
            if(callData.ContractorIdentityVerification__c.equals(System.Label.True)){
                CallerName = System.Label.ContractorHimself;
            }else{
                CallerName = callData.CallerName__c;
            }
        }

        management.OwnerID = System.Label.ApprovalPendingQue;
        management.Phase__c = System.Label.WaitingSVApproval;
        management.BedoreScenarioType__c = callData.ScenarioType__c;
        management.VoiceLogURL__c = callData.VoiceLogURL__c;
        management.SendSV__c = System.Label.BedoreReception;
        management.PrintForm__c = callData.PrintForm__c;
        management.RespondentInfo__c = System.Label.AutomaticVoice;
        management.RespondentInfoPart__c = System.Label.TokyoC;
        management.DisasterChk__c = callData.DisasterChk__c;
        management.Broadcast__c = callData.Broadcast__c;
        management.BedoreSessionID__c = callData.SessionID__c;
        management.CallDate__c = ReceivedDate;
        management.CallDataIncomingCallTime__c = ReceivedTime;
        management.CallerNameInput__c = CallerName;
        management.CallerContactInfo__c = callData.ReceivedNumber__c;
        management.BedorePolicyNumber__c = callData.PolicyNumber__c;
        return management;
    }
    public string convertDate(string westernCalendar){
        system.debug('westernCalendar:'+westernCalendar);
        PostingDate convertDate = new PostingDate();
		String japaneseCalendar = convertDate.Posting(westernCalendar);
        return japaneseCalendar;
    }
    public string convertContractorRelation(string ContractorIdentityVerification,string ContractorName){
        String ContractorRelation = '';
        if(String.isEmpty(ContractorIdentityVerification)){
            if(String.isNotEmpty(ContractorName)){
            	ContractorRelation = System.Label.Contractor+ContractorName;                
            }
        }else{
            if(ContractorIdentityVerification.equals(System.Label.True)){
                ContractorRelation = System.Label.ContractorHimself;
            }else{
                if(String.isNotEmpty(ContractorName)){
                    ContractorRelation = System.Label.Contractor+ContractorName;                
                }
            }
        }

        return ContractorRelation;
    }
    public void updateBedoreLinkedCase(string[] newManagements){
	List<Case> linkedCaseList = [Select Id,IsLinked__c From Case Where SessionID__c IN :newManagements ];
        for(Case linkedCase : linkedCaseList){
            linkedCase.IsLinked__c = true;
        }
        update linkedCaseList;
    }
}