@isTest
private class ContentDocumentLinkTriggerTest {
    public static AccidentReception_Management__c managementObj;
    public static InputCheck__c inputchkObj;

    @isTest static void ContentDocumentTestforFiles(){ 
        // test start
		try{        
        	AccidentReception_CallData__c calldata = new AccidentReception_CallData__c(Name = 'トランス') ;
            insert calldata;
                            
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c managementObj = new AccidentReception_Management__c(
            	ContractorName__c = calldata.id,
                ContractorNameInput1__c = '契約者①',
                PrintForm__c = '伝言',
                ProductDetails__c = 'テレマ',
                OutputFileList__c = 'ファイルネーム1,ファイルネーム2'
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
            	Title = 'Penguins',
            	PathOnClient = 'Penguins.pdf',
            	VersionData = Blob.valueOf('Test Content'),
            	IsMajorVersion = true
            );
            insert contentVersion;
            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            	cdl.LinkedEntityId = managementObj.id;
            	cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
	@isTest static void ContentDocumentforFile(){
       
		try{
            
			AccidentReception_CallData__c calldata = new AccidentReception_CallData__c(
            	MobilePhone__c = '03-1234-5678',
                Name = 'トランス');
            insert calldata;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
            	Name = '契約者名①',
                InputItemAPIName__c = 'ContractorNameInput1__c',
                Size__c=13) ;
            insert inputChkobj;
                        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c managementObj = new AccidentReception_Management__c(
                ContractorName__c = calldata.id,
                ContractorNameInput1__c = '契約者①',
                PrintForm__c = '伝言',
                ProductDetails__c = 'テレマ',
                OutputFileList__c = 'ファイルネーム1'
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
            	Title = 'Penguins',
            	PathOnClient = 'Penguins.pdf',
            	VersionData = Blob.valueOf('Test Content'),
            	IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
     @isTest static void ContentDocumentTestforBlank(){
       
        try{
            
            AccidentReception_CallData__c calldata = new AccidentReception_CallData__c(Name = 'トランス') ;
            insert calldata;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
                						Name = '契約者名①' ,
                                        InputItemAPIName__c = 'ContractorNameInput1__c',
                                        Size__c=13) ;
            insert inputChkobj;
                        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c managementObj = new AccidentReception_Management__c(
                ContractorName__c = calldata.id,
                ContractorNameInput1__c = '契約者①',
                PrintForm__c = '伝言',
                ProductDetails__c = 'テレマ',
                OutputFileList__c = ''
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.pdf',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    @isTest static void ContentDocumentTestreturn(){
       
        try{
            
            AccidentReception_CallData__c calldata = new AccidentReception_CallData__c(Name = 'トランス') ;
            insert calldata;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
                						Name = '契約者名①' ,
                                        InputItemAPIName__c = 'ContractorNameInput1__c',
                                        Size__c=13) ;
            insert inputChkobj;
                        
            List<AccidentReception_Management__c> managements = new List<AccidentReception_Management__c>();
            AccidentReception_Management__c managementObj = new AccidentReception_Management__c(
                ContractorName__c = calldata.id,
                ContractorNameInput1__c = '契約者①',
                PrintForm__c = '伝言',
                ProductDetails__c = 'テレマ',
                OutputFileList__c = ''
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.pdf',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> cd = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = cd[0].Id;
            insert cdl;
            delete cdl;


            
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
}