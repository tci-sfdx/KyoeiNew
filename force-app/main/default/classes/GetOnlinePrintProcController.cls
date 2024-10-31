public without Sharing class GetOnlinePrintProcController{

    public GetOnlinePrintProcController(){
    }
    public void processIncomingData() {
            // Retrieve POST data
            Map<String,String> postData = ApexPages.currentPage().getParameters();
            System.debug('POSTデータ: ' + postData);
            System.debug(ApexPages.currentPage().getParameters());
            
            //If POST data is blank, redirect immediately
            if (postData == null || postData.isEmpty()) {
                return;
            }
            String gyoumu_Id;
            String ccRnki_InstRnbn;
            String ccRnki_SyknNo;
            String ccRnki_SyknNoEdbn;
            String ccRnki_HknSiki;
            String ccRnki_P1_HknSyki;
            String ccRnki_P2_HknSyki;
            String ccRnki_P3_HknSyki;
            String p1_HrikmHuhu;
            String p2_HrikmHuhu;
            String p3_HrikmHuhu;
            String ccRnki_P1_HrikmHuhu;
            String ccRnki_P2_HrikmHuhu;
            String ccRnki_P3_HrikmHuhu;
            String ccRnki_P1_GukiHknr;
            String ccRnki_P2_GukiHknr;
            String ccRnki_P3_GukiHknr;
            String ccRnki_P1_SuGkHknr;
            String ccRnki_P2_SuGkHknr;
            String ccRnki_P3_SuGkHknr;
            String pdfFilePath;
            String pdfFiledata;
            for(String key : postData.keySet()){
                if(key.toLowerCase() == 'gyoumu_Id'.toLowerCase()){
                    gyoumu_Id = postData.get(key);
                }else if(key.toLowerCase() == 'ccRnki_InstRnbn'.toLowerCase()){
                    ccRnki_InstRnbn = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_SyknNo'.toLowerCase()){
                    ccRnki_SyknNo = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_SyknNoEdbn'.toLowerCase()){
                    ccRnki_SyknNoEdbn = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_HknSiki'.toLowerCase()){
                    ccRnki_HknSiki = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P1_HknSyki'.toLowerCase()){
                    ccRnki_P1_HknSyki = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P2_HknSyki'.toLowerCase()){
                    ccRnki_P2_HknSyki = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P3_HknSyki'.toLowerCase()){
                    ccRnki_P3_HknSyki = postData.get(key);

                }else if(key.toLowerCase() == 'p1_HrikmHuhu'.toLowerCase()){
                    p1_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'p2_HrikmHuhu'.toLowerCase()){
                    p2_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'p3_HrikmHuhu'.toLowerCase()){
                    p3_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P1_HrikmHuhu'.toLowerCase()){
                    ccRnki_P1_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P2_HrikmHuhu'.toLowerCase()){
                    ccRnki_P2_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P3_HrikmHuhu'.toLowerCase()){
                    ccRnki_P3_HrikmHuhu = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P1_GukiHknr'.toLowerCase()){
                    ccRnki_P1_GukiHknr = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P2_GukiHknr'.toLowerCase()){
                    ccRnki_P2_GukiHknr = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P3_GukiHknr'.toLowerCase()){
                    ccRnki_P3_GukiHknr = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P1_SuGkHknr'.toLowerCase()){
                    ccRnki_P1_SuGkHknr = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P2_SuGkHknr'.toLowerCase()){
                    ccRnki_P2_SuGkHknr = postData.get(key);

                }else if(key.toLowerCase() == 'ccRnki_P3_SuGkHknr'.toLowerCase()){
                    ccRnki_P3_SuGkHknr = postData.get(key);

                }else if(key.toLowerCase() == 'pdfFilePath'.toLowerCase()){
                    pdfFilePath = postData.get(key);

                }else if(key.toLowerCase() == 'pdfFiledata'.toLowerCase()){
                    pdfFiledata = postData.get(key);

                }
            }
            if(String.isBlank(gyoumu_id)){
                //エラー
                return;
            }

            if(gyoumu_Id.left(3) <> '500'){
                return;
            }
            Case targetCase = [Select Id, ContractInformationId__c From Case Where Id = :gyoumu_Id limit 1];
            if(targetCase == null){
                return;
            }
            Attachment att= new Attachment();
            att.parentId = targetCase.Id;
            att.Body = EncodingUtil.Base64Decode(pdfFiledata);
            att.Name = pdfFilePath.right(pdfFilePath.length() - pdfFilePath.lastIndexOf('\\') +1);
            insert att;
            PrintSerialNumber__c print = new PrintSerialNumber__c();
            print.CaseId__c = targetCase.Id;//ケースId
            print.Contract_InformationId__c = targetCase.ContractInformationId__c;//契約情報
            print.Name = ccRnki_InstRnbn;//印刷連番
            print.PolicyNumber__c = ccRnki_SyknNo;//証券番号
            print.PolicyBranchNumber__c = ccRnki_SyknNoEdbn;//証券番号枝番
            print.CommencementInsuranceWareki__c = ccRnki_HknSiki;//保険始期
            print.InsurancePeriodA__c = ccRnki_P1_HknSyki;//(Aプラン)保険終期
            print.InsurancePeriodB__c = ccRnki_P2_HknSyki;//(Bプラン)保険終期
            print.InsurancePeriodC__c = ccRnki_P3_HknSyki;//(Cプラン)保険終期
            print.PaymentMethodA__c = p1_HrikmHuhu;//(Aプラン)払込方法
            print.PaymentMethodB__c = p2_HrikmHuhu;//(Bプラン)払込方法
            print.PaymentMethodC__c = p3_HrikmHuhu;//(Cプラン)払込方法
            print.PaymentMethodTranslationA__c = ccRnki_P1_HrikmHuhu;//(Aプラン)払込方法翻訳
            print.PaymentMethodTranslationB__c = ccRnki_P2_HrikmHuhu;//(Bプラン)払込方法翻訳
            print.PaymentMethodTranslationC__c = ccRnki_P3_HrikmHuhu;//(Cプラン)払込方法翻訳
            print.SumInsuranceFeeA__c = String.isBlank(ccRnki_P1_GukiHknr) ? 0 : Decimal.valueOf(ccRnki_P1_GukiHknr);//(Aプラン)合計保険料
            print.SumInsuranceFeeB__c = String.isBlank(ccRnki_P2_GukiHknr) ? 0 : Decimal.valueOf(ccRnki_P2_GukiHknr);//(Bプラン)合計保険料
            print.SumInsuranceFeeC__c = String.isBlank(ccRnki_P3_GukiHknr) ? 0 : Decimal.valueOf(ccRnki_P3_GukiHknr);//(Cプラン)合計保険料
            print.TotalInsuranceFeeA__c = String.isBlank(ccRnki_P1_SuGkHknr) ? 0 : Decimal.valueOf(ccRnki_P1_SuGkHknr);//(Aプラン)総額保険料
            print.TotalInsuranceFeeB__c = String.isBlank(ccRnki_P2_SuGkHknr) ? 0 : Decimal.valueOf(ccRnki_P2_SuGkHknr);//(Bプラン)総額保険料
            print.TotalInsuranceFeeC__c = String.isBlank(ccRnki_P3_SuGkHknr) ? 0 : Decimal.valueOf(ccRnki_P3_SuGkHknr);//(Cプラン)総額保険料
            print.PdfFilePath__c = pdfFilePath;//PDFファイルパス名
            print.ProcName__c = att.Name;//処理名
                
    
    }
}