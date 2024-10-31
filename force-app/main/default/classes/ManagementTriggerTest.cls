@isTest
private class ManagementTriggerTest {
    public static AccidentReception_Management__c app;

    @isTest static void updateTest1(){
       
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='aa', AccidentDate__c = 'R3/1/1',
                                          PolicyNumber__c='266262-111', IncomingCallTime__c = '22:22',
                                          IncomingCallDay__c = 'R2/12/11', RegisteredPhoneNumber1__c = '151551',
                                          Relationship__c = 'aa', CallerContactInformation1__c = '111',
                                          RegisteredPhoneNumber2__c = '111',
                                          CallerContactInformation2__c = '22') ;
            insert calldata;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
                						Name = '契約者名①' ,
                                        InputItemAPIName__c = 'ContractorNameInput1__c',
                                        Size__c=13) ;
            insert inputChkobj;
            
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                CallerContactInfo__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                CallerNameInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                CallerContractorRelationInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                SecuritiesBranchNumber1__c = 'aaaaaaaaaaaaaaaaaaaa',
                SecuritiesBranchNumber2__c = 'aaaaaaaaaaaaaaaaaaaa',
                ContractorNameInput1__c = 'aaaaaaaaaaaaaaaaaaaa',
                ContractorNameInput2__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredPersonInput1__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredPersonInput2__c = 'aaaaaaaaaaaaaaaaaaaa',
                Agency1__c = 'aaaaaaaaaaaaaaaaaaaa',
                Agency2__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuranceItem1__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuranceItem2__c = 'aaaaaaaaaaaaaaaaaaaa',
                DisasterName__c = 'aaaaaaaaaaaaaaaaaaaa',
                AccidentSituation__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredKana__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredNameInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredAddress__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredContactInfoInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                InsuredContactInput2__c = 'aaaaaaaaaaaaaaaaaaaa',
                DestinationLocation__c = 'aaaaaaaaaaaaaaaaaaaa',
                OtherPartyKana__c = 'aaaaaaaaaaaaaaaaaaaa',
                OtherPartyName__c = 'aaaaaaaaaaaaaaaaaaaa',
                OtherPartyAddress__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                OtherPartyContactInfoA__c = 'aaaaaaaaaaaaaaaaaaaa',
                OtherPartyContactInfoB__c = 'aaaaaaaaaaaaaaaaaaaa',
                Damaged__c = 'aaaaaaaaaaaaaaaaaaaa',
                Part__c = 'aaaaaaaaaaaaaaaaaaaa',
                Symptoms__c = 'aaaaaaaaaaaaaaaaaaaa',
                HospitalName__c = 'aaaaaaaaaaaaaaaaaaaa',
                HospitalTel__c = 'aaaaaaaaaaaaaaaaaaaa',
                LocationTypeSupplement__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                
                CurrentSituationInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                RemarksInsurance__c = 'aaaaaaaaaaaaaaaaaaaa',
                RemarksReason__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                PersonInfoConfirmInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                BillingAddressInput__c = 'aaaaaaaaaaaaaaaaaaaa',
                ContactAddressInput__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                ContactPhoneNumber__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                InconvenientTime__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                PersonInfoConfirm__c = '案内のうえ了承済み',
                
                Remarks__c = 'aaaaaaaaaaaaaaaaaaaa',
                Supplement__c = 'aaaaaaaaaaaaaaaaaaaa',
                DepartmentNameInput1__c = 'aaaaaaaaaaaaaaaaaaaa',
                DepartmentNameInput2__c = 'aaaaaaaaaaaaaaaaaaaa',
                AccidentTime__c = 'aaaaaaaaaaaaaaaaaaaa',
                CallDate__c = 'R3/1/1',
                InsurancePeriod1From__c = 'R 21.10. 1',
                InsurancePeriod2From__c = 'H 21.10. 1',
                InsurancePeriod1To__c = 'S 21.10. 1',
                InsurancePeriod2To__c = 'M 21.10. 1',
                AccidentDateInputW__c = 'R2/12/3',
                InsuredPersonBirthW__c = 'S3/1/1',
                OtherPartyBirthW__c = 'S21/1/1',
                
                ExpectedHospitalFrom__c = 'S21/1/1',
                ExpectedHospitalTo__c = 'S21/1/1',
                ExpectedHospitalizationFrom__c = 'S21/1/1',
                ExpectedHospitalizationTo__c = 'S21/1/1',
                CastFixedPeriodFrom__c = 'S21/1/1',
                CastFixedPeriodTo__c = 'S21/1/1',
                ContactDateW__c = 'S21/1/1',
                
                CallDataIncomingCallTime__c = '12:11',                
                InsuredZipCode__c = 'X0044',
                SecuritiesNumberInput1__c = 'M',
                SecuritiesNumberInput2__c = 'M',
                
                
                DriverBirthInputW__c = 'S21/1/1',
                EntrustContractDate__c = 'S21/1/1',
                DeliveryDate__c = 'S21/1/1',
                InjuredBirthday__c = 'S21/1/1',
                InjuredBirthdayCL__c = 'S21/1/1',
                
                
                EntrustContractTime__c = '12:12',
                DeliveryTime__c = '::',
                
                SecuritiesNumbeYot__c = '/',                
                EntrusterPhoneNumber__c = '/'
                
            );
            
            //insert 
            Test.startTest();
			insert app;
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
    @isTest static void updateTest2(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='aa', AccidentDate__c = 'R3/1/1',
                                          PolicyNumber__c='266262-111', IncomingCallTime__c = '22:22',
                                          IncomingCallDay__c = 'R2/12/0', RegisteredPhoneNumber1__c = '151551',
                                          Relationship__c = 'aa', CallerContactInformation1__c = '111',
                                          CallerContactInformation2__c = '22') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                CallDate__c = 'R3/1/0',
                InsurancePeriod1From__c = 'R 21.10. 0',
                InsurancePeriod2From__c = 'H 21.10. 0',
                InsurancePeriod1To__c = 'S 21.10. 0',
                InsurancePeriod2To__c = 'M 21.10. 0',
                AccidentDateInputW__c = 'R3/2/1',
                InsuredPersonBirthW__c = 'S3/1/0',
                OtherPartyBirthW__c = 'S21/1/0',
                
                ExpectedHospitalFrom__c = 'R3/1/0',
                ExpectedHospitalTo__c = 'H3/1/0',
                ExpectedHospitalizationFrom__c = 'S3/1/0',
                ExpectedHospitalizationTo__c = 'M3/1/0',
                CastFixedPeriodFrom__c = 'R3/1/0',
                CastFixedPeriodTo__c = 'R3/1/0',
                ContactDateW__c = 'R3/1/0',
                
                CallDataIncomingCallTime__c = '12:',                
                InsuredZipCode__c = 'X0044',
                SecuritiesNumberInput1__c = 'R3/1/0',
                SecuritiesNumberInput2__c = 'R3/1/0',
                
                
                DriverBirthInputW__c = 'R3/1/0',
                EntrustContractDate__c = 'R3/1/0',
                DeliveryDate__c = 'R3/1/0',
                InjuredBirthday__c = 'R3/1/0',
                InjuredBirthdayCL__c = 'R3/1/0',
                
                
                EntrustContractTime__c = '12:',
                DeliveryTime__c = '12:12',
                
                SecuritiesNumbeYot__c = '123456',                
                EntrusterPhoneNumber__c = '123456',
                
                Phase__c = 'SV承認待ち'
                
                
                
                
            );
            
            insert app;   
            
            test.startTest();
            app.PersonInfoConfirm__c = '案内のうえ了承済み';
            //app.Phase__c = 'SV承認待ち';
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    @isTest static void updateTest3(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='', AccidentDate__c = '',
                                          PolicyNumber__c='', IncomingCallTime__c = '',
                                          IncomingCallDay__c = 'aaa', RegisteredPhoneNumber1__c = '',
                                          Relationship__c = '', CallerContactInformation1__c = '',
                                          CallerContactInformation2__c = '') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                CallDate__c = 'aaa',
                InsurancePeriod1From__c = 'aaa',
                InsurancePeriod2From__c = 'aaaa',
                InsurancePeriod1To__c = 'aaaa',
                InsurancePeriod2To__c = 'aaaaa',
                AccidentDateInputW__c = 'aaaaa',
                InsuredPersonBirthW__c = 'SS',
                OtherPartyBirthW__c = 'aaaaa',
                ExpectedHospitalFrom__c = 'aaaaa',
                ExpectedHospitalTo__c = 'aaaaa',
                ExpectedHospitalizationFrom__c = 'aaaaa',
                ExpectedHospitalizationTo__c = 'aaaaa',
                CastFixedPeriodFrom__c = 'aaaaa',
                CastFixedPeriodTo__c = 'aaaaa',
                ContactDateW__c = 'aaaaa',
                CallDataIncomingCallTime__c = '12:',                
                InsuredZipCode__c = 'X0044',
                SecuritiesNumberInput1__c = 'aaaaa',
                SecuritiesNumberInput2__c = 'aaaaa',
                DriverBirthInputW__c = 'aaaaa',
                EntrustContractDate__c = 'aaaaa',
                DeliveryDate__c = 'aaaaa',
                InjuredBirthday__c = 'aaaaa',
                InjuredBirthdayCL__c = 'aaaaa',
                EntrustContractTime__c = '12:',
                DeliveryTime__c = '12:12',
                SecuritiesNumbeYot__c = '123456',                
                EntrusterPhoneNumber__c = '123456',
                AccidentTimeNisei__c = 'aaaaa',
                SecuritiesBranchNumber1__c = 'ああああ',
                SecuritiesBranchNumber2__c = 'あああ',
                Phase__c = '対応中'
            );
            
            insert app;   
            
            test.startTest();
            
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    @isTest static void updateTestInsurance(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='', AccidentDate__c = '',
                                          PolicyNumber__c='', IncomingCallTime__c = '',
                                          IncomingCallDay__c = '', RegisteredPhoneNumber1__c = '',
                                          Relationship__c = '', CallerContactInformation1__c = '',
                                          CallerContactInformation2__c = '') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                InsurancePeriod1From__c = 'R/2/1',
                InsurancePeriod2From__c = 'H/2/1',
                InsurancePeriod1To__c = 'S/12/1',
                InsurancePeriod2To__c = 'T/12/2'

            );
            
            insert app;   
            
            test.startTest();
            
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
    @isTest static void updateTestInsurance2(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='', AccidentDate__c = '',
                                          PolicyNumber__c='', IncomingCallTime__c = '',
                                          IncomingCallDay__c = 'H2/12/11', RegisteredPhoneNumber1__c = '',
                                          Relationship__c = '', CallerContactInformation1__c = '',
                                          CallerContactInformation2__c = '') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                InsurancePeriod1From__c = 'R3/2/0',
                InsurancePeriod2From__c = 'H3/2/0',
                InsurancePeriod1To__c = 'S3/12/0',
                InsurancePeriod2To__c = 'T3/12/0'

            );
            
            insert app;   
            
            test.startTest();
            
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
    @isTest static void updateTestDateNull(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='', AccidentDate__c = '',
                                          PolicyNumber__c='', IncomingCallTime__c = '',
                                          IncomingCallDay__c = 'H2/12/11', RegisteredPhoneNumber1__c = '',
                                          Relationship__c = '', CallerContactInformation1__c = '',
                                          CallerContactInformation2__c = '') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                InsurancePeriod1From__c = '',
                InsurancePeriod2From__c = '',
                InsurancePeriod1To__c = '',
                InsurancePeriod2To__c = ''

            );
            
            insert app;   
            
            test.startTest();
            
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
    @isTest static void updateTest4(){
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          Name = 'トランス', 
                                          ContractorName__c='', AccidentDate__c = '',
                                          PolicyNumber__c='', IncomingCallTime__c = '',
                                          IncomingCallDay__c = 'H2/12/11', RegisteredPhoneNumber1__c = '',
                                          Relationship__c = '', CallerContactInformation1__c = '',
                                          CallerContactInformation2__c = '') ;
            insert calldata;        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c app = new AccidentReception_Management__c(   
                ContractorName__c = calldata.id,
                CallerContactInfo__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                Phase__c = 'SV確認中',
                PersonInfoConfirm__c ='案内のうえ了承済み',
                InsurancePeriod1From__c = 'R3/1/2',
                InsurancePeriod2From__c = 'S3/1/2',
                InsurancePeriod1To__c = 'H3/1/2',
                InsurancePeriod2To__c = 'T3/1/2'
            );
            
            insert app;   
            
            test.startTest();
            
            update app;
            
            test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    @isTest static void insertAnnoymousCallData(){
        
        // test start
        try{
            
            AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
                                          ContractorName__c='aa', AccidentDate__c = 'R3/1/1',
                                          PolicyNumber__c='266262-111', IncomingCallTime__c = '22:22',
                                          IncomingCallDay__c = 'R2/12/11', RegisteredPhoneNumber1__c = '151551',
                                          Relationship__c = 'aa', CallerContactInformation1__c = '111',
                                          RegisteredPhoneNumber2__c = '111',
                                          CallerContactInformation2__c = '22',
                                          BedoreSessionID__c = '123456'
                                         ) ;    
            insert calldata;
            system.assertEquals(1, [select id from AccidentReception_CallData__c].size());
            system.assertEquals('フメイ', [select id, Name from AccidentReception_CallData__c].get(0).Name);
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }

    @isTest static void changePhaseOwerTest(){
        AccidentReception_CallData__c calldata  = new AccidentReception_CallData__c(MobilePhone__c = '03-1234-5678' ,
            Name = 'トランス', 
            ContractorName__c='aa', AccidentDate__c = 'R3/1/1',
            PolicyNumber__c='266262-111', IncomingCallTime__c = '22:22',
            IncomingCallDay__c = 'R2/12/11', RegisteredPhoneNumber1__c = '151551',
            Relationship__c = 'aa', CallerContactInformation1__c = '111',
            RegisteredPhoneNumber2__c = '111',
            CallerContactInformation2__c = '22') ;
        insert calldata;

        AccidentReception_Management__c app = new AccidentReception_Management__c(   
            ContractorName__c = calldata.id,
            InsurancePeriod1From__c = 'R6/1/1',
            InsurancePeriod2From__c = 'R6/1/1',
            InsurancePeriod1To__c = 'R6/12/31',
            InsurancePeriod2To__c = 'R6/12/31',
            Phase__c = '対応中',
            AccidentReceptionVideoUid__c ='43e17579-6dd1-4166-b308-113d7dca152d');
        
        insert app;
    }
}