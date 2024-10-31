public with sharing class OnlinePrintProcController{

    @AuraEnabled(cacheable=true)
    public static List<User> getUserOnlineInfo(){

        String userId = userinfo.getUserId();

        List<User> users= [
                SELECT
                    Id,
                    OnlineID__c , OnlinePW__c
                FROM
                    User
                WHERE
                    Id = :userId
                LIMIT 1
        ];

        return users;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getPrintDatas( String caseId){

        List<PrintSerialNumber__c> printSerialNumbers = [
            SELECT
                Id, Name, ProcName__c,
                CreatedDate, CreatedById, 
                PolicyNumber__c, PolicyBranchNumber__c, 
                CommencementInsuranceWareki__c, 
                InsurancePeriodA__c, InsurancePeriodB__c, InsurancePeriodC__c, 
                PaymentMethodA__c, PaymentMethodB__c, PaymentMethodC__c, 
                PaymentMethodTranslationA__c, PaymentMethodTranslationB__c, PaymentMethodTranslationC__c, 
                SumInsuranceFeeA__c, SumInsuranceFeeB__c, SumInsuranceFeeC__c, 
                TotalInsuranceFeeA__c, TotalInsuranceFeeB__c, TotalInsuranceFeeC__c, 
                PdfFilePath__c, Contract_InformationId__c, CaseId__c ,TransferDate__c
            FROM PrintSerialNumber__c
            WHERE
                CaseId__c = :caseId
        ];

        List<Map<String, String>> cList = new List<Map<String, String>>();

        // 受付日時がGMT表記になってしまうため、変換処理
        for (PrintSerialNumber__c rec : printSerialNumbers) {
            Map<String, String> cMap = new Map<String, String>();
            cMap.put('ProcName__c', rec.ProcName__c);
            cMap.put('Id', String.valueOf(rec.Id));
            cMap.put('Name', rec.Name);
            cMap.put('PolicyNumber__c', rec.PolicyNumber__c);
            String ProcDate = rec.Name.left(1) == 'B' || rec.Name.left(1) == 'K' ? rec.TransferDate__c : rec.CommencementInsuranceWareki__c;
            cMap.put('ProcDate', ProcDate);
            cMap.put('CreatedDate', String.valueOf(rec.CreatedDate));
            if(String.isBlank(rec.InsurancePeriodA__c) && String.isBlank(rec.InsurancePeriodB__c) && String.isBlank(rec.InsurancePeriodC__c)){
                cList.add(cMap);
            }else{
                if(!String.isBlank(rec.InsurancePeriodA__c)){
                    Map<String, String> cMapA = cMap.clone();
                    cMapA.put('Plan', 'A');
                    cMapA.put('InsurancePeriod', rec.InsurancePeriodA__c);
                    cMapA.put('InsuranceFee', String.valueOf(rec.SumInsuranceFeeA__c)); 
                    cMapA.put('TotalInsuranceFee', String.valueOf(rec.TotalInsuranceFeeA__c)); 
                    cMapA.put('PaymentMethodTranslation', rec.PaymentMethodTranslationA__c); 
                    cList.add(cMapA);
                }
                
                if(!String.isBlank(rec.InsurancePeriodB__c)){
                    Map<String, String> cMapB = cMap.clone();
                    cMapB.put('Plan', 'B');
                    cMapB.put('InsurancePeriod', rec.InsurancePeriodB__c);
                    cMapB.put('InsuranceFee', String.valueOf(rec.SumInsuranceFeeB__c)); 
                    cMapB.put('TotalInsuranceFee', String.valueOf(rec.TotalInsuranceFeeB__c)); 
                    cMapB.put('PaymentMethodTranslation', rec.PaymentMethodTranslationB__c); 
                    cList.add(cMapB);
                }
                
                if(!String.isBlank(rec.InsurancePeriodC__c)){
                    Map<String, String> cMapC = cMap.clone();
                    cMapC.put('Plan', 'C');
                    cMapC.put('InsurancePeriod', rec.InsurancePeriodC__c);
                    cMapC.put('InsuranceFee', String.valueOf(rec.SumInsuranceFeeC__c)); 
                    cMapC.put('TotalInsuranceFee', String.valueOf(rec.TotalInsuranceFeeC__c));
                    cMapC.put('PaymentMethodTranslation', rec.PaymentMethodTranslationC__c); 
                    cList.add(cMapC);
                }
            }
        }

        return cList;
    }

}