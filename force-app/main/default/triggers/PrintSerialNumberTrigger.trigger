trigger PrintSerialNumberTrigger on PrintSerialNumber__c (after insert, after update, before delete )  {
	
    Set<Id> caseIds = new Set<Id>();
    if(Trigger.isAfter){
        for ( PrintSerialNumber__c newCase : Trigger.new ) {
            caseIds.add(newCase.CaseId__c);
        }
    }else{
        for ( PrintSerialNumber__c oldCase : Trigger.old ) {
            caseIds.add(oldCase.CaseId__c);
        }
    }
    List<Case> targetCases = 
        [Select 
            id, 
            CaseNumber, 
            PrintSerialNumberForReport__c,
            PrintSerialNumberForReportColumn__c, 
            TransferDateForReport__c, 
            NewPolicyNumber__c, 
            NewPolicyNumberJorG__c, 
            NewPremium__c, 
            NewPaymentMethod__c,
            CommencementInsuranceWareki__c, 
            (Select Id, ProcName__c, Name, CaseLastModifiedByName__c , 
                PolicyNumber__c, 
                PolicyBranchNumber__c, 
                CommencementInsuranceWareki__c, 
                InsurancePeriodA__c, InsurancePeriodB__c, InsurancePeriodC__c, 
                PaymentMethodA__c, PaymentMethodB__c, PaymentMethodC__c, 
                PaymentMethodTranslationA__c, PaymentMethodTranslationB__c, PaymentMethodTranslationC__c, 
                SumInsuranceFeeA__c, SumInsuranceFeeB__c, SumInsuranceFeeC__c, 
                TotalInsuranceFeeA__c, TotalInsuranceFeeB__c, TotalInsuranceFeeC__c, 
                TransferDate__c, 
                DoReporting__c, 
                ReportPlan__c,
                CreatedDate 
                From PrintSerialNumber__r order by Createddate desc) 
        from Case 
        Where Id in : caseIds order by caseNumber];
    String messages = '';
    String keyCaseNumber = targetCases.get(0).CaseNumber;
    for(Case c : targetCases){
        boolean isFindStartWithBorK= false;
        boolean isFindStartWithJorG= false;
        for(PrintSerialNumber__c print : c.PrintSerialNumber__r){
            System.debug(print.ProcName__c);
            if(Trigger.isBefore && Trigger.oldMap.containsKey(print.id)){
            }else{
                messages += 
                '<< ' + print.CaseLastModifiedByName__c + ' ' +  print.CreatedDate.format('yyyy/MM/dd HH:mm:ss','JST') + ' >>\n' + print.ProcName__c + ' ' + print.Name + '\n';
            }
            if(!isFindStartWithBorK && print.DoReporting__c && (print.Name.startsWith('B') || print.Name.startsWith('K')) ){
                if(Trigger.isBefore && Trigger.oldMap.containsKey(print.id)){
                    continue;
                }
                String policyNumber = (String.isBlank(print.PolicyNumber__c) ? '' : print.PolicyNumber__c) + 
                    (String.isBlank(print.PolicyBranchNumber__c) ? '' : print.PolicyBranchNumber__c);
                c.NewPolicyNumber__c = policyNumber;
                c.TransferDateForReport__c = print.TransferDate__c;
                c.PrintSerialNumberForReportColumn__c = print.Name;
                //
                isFindStartWithBorK = true;
            }
            if(!isFindStartWithJorG && print.DoReporting__c && (print.Name.startsWith('J') || print.Name.startsWith('G')) ){
                if(Trigger.isBefore && Trigger.oldMap.containsKey(print.id)){
                    continue;
                }
                String policyNumber = (String.isBlank(print.PolicyNumber__c) ? '' : print.PolicyNumber__c) + 
                    (String.isBlank(print.PolicyBranchNumber__c) ? '' : print.PolicyBranchNumber__c);
                c.NewPolicyNumberJorG__c = policyNumber;
                c.CommencementInsuranceWareki__c = print.CommencementInsuranceWareki__c;
                //
                if(print.ReportPlan__c.startsWith('Ａ')){
                    c.NewPremium__c = print.SumInsuranceFeeA__c;
                    c.NewPaymentMethod__c = print.PaymentMethodTranslationA__c;
                }else if(print.ReportPlan__c.startsWith('Ｂ')){
                    c.NewPremium__c = print.SumInsuranceFeeB__c;
                    c.NewPaymentMethod__c = print.PaymentMethodTranslationB__c;

                }else if(print.ReportPlan__c.startsWith('Ｃ')){
                    c.NewPremium__c = print.SumInsuranceFeeC__c;
                    c.NewPaymentMethod__c = print.PaymentMethodTranslationC__c;
                }else{
                    c.NewPremium__c = 0;
                    c.NewPaymentMethod__c = null;
                }
                //
                isFindStartWithJorG = true;
            }
        }
        System.debug('mes is:' + messages);
        if(!isFindStartWithBorK){
            c.NewPolicyNumber__c = null;
            c.TransferDateForReport__c = null;
            c.PrintSerialNumberForReportColumn__c = null;
        }
        if(!isFindStartWithJorG){
            c.NewPolicyNumberJorG__c = null;
            c.NewPremium__c = null;
            c.NewPaymentMethod__c = null;
            c.CommencementInsuranceWareki__c = null;
        }
        c.PrintSerialNumberForReport__c = messages;
        messages = '';
	}
    update targetCases;
}