@RestResource(urlMapping='/GetPrintDataInfo')
global without Sharing class GetOnlinePrintProcRest{
    @HttpPost
    global static void processIncomingData() {
        // Retrieve POST data
        RestRequest req = RestContext.request;
        String reqString = req.requestBody.toString();
        //
        RestResponse res = RestContext.response;
        res.statusCode = 400;
        res.addHeader('Content-Type', 'application/json');

        //If POST data is blank, redirect immediately
        if (reqString == null || String.isBlank(reqString)) {
            return;
        }
        System.debug('POSTデータ: ' + reqString);
        Request params = (Request) System.JSON.deserialize(reqString, Request.class);
        if(String.isBlank(params.gyoumu_id)){
            //エラー
            return;
        }
        String gyoumu_Id = params.gyoumu_Id.left(15);
        String proc_code = params.gyoumu_Id.right(2);
        if(gyoumu_Id.left(3) <> '500'){
            return;
        }
        Case targetCase = [Select Id, ContractInformationId__c,
            ExpectedShippingDate_Latest__c,
            ReturnFollow_UpDate_Latest__c,
            NoFollow_UpRequired__c,
            ShipmentRequired__c,
            LastmodifiedById,
            LastmodifiedBy.Name
            From Case Where Id = :gyoumu_Id limit 1];
        if(targetCase == null){
            return;
        }
        Attachment att= new Attachment();
        att.parentId = targetCase.Id;
        att.Body = EncodingUtil.Base64Decode(params.pdfFiledata);
        att.Name = params.ccRnki_InstRnbn + params.pdfFilePath.right(params.pdfFilePath.length() - params.pdfFilePath.lastIndexOf('/') -1);
        insert att;
        PrintSerialNumber__c print = new PrintSerialNumber__c();
        print.CaseId__c = targetCase.Id;//ケースId
        print.Contract_InformationId__c = targetCase.ContractInformationId__c;//契約情報
        print.Name = params.ccRnki_InstRnbn;//印刷連番
        if(params.ccRnki_SyknNo.contains('-')){
            list<String> syknNos = params.ccRnki_SyknNo.split('-');
            print.PolicyNumber__c = syknNos[0];//証券番号
            print.PolicyBranchNumber__c = syknNos[1];//証券番号枝番
        }else{
            print.PolicyNumber__c = params.ccRnki_SyknNo;//証券番号
            print.PolicyBranchNumber__c = params.ccRnki_SyknNoEdbn;//証券番号枝番
        }
        if(String.isBlank(params.ccRnki_IduD)){
            print.CommencementInsuranceWareki__c = params.ccRnki_HknSiki;//保険始期
        }else{
            print.CommencementInsuranceWareki__c = params.ccRnki_IduD;//保険始期
            print.TransferDate__c = params.ccRnki_IduD;//異動日
        }
        print.InsurancePeriodA__c = params.ccRnki_P1_HknSyki;//(Aプラン)保険終期
        print.InsurancePeriodB__c = params.ccRnki_P2_HknSyki;//(Bプラン)保険終期
        print.InsurancePeriodC__c = params.ccRnki_P3_HknSyki;//(Cプラン)保険終期
        print.PaymentMethodA__c = params.p1_HrikmHuhu;//(Aプラン)払込方法
        print.PaymentMethodB__c = params.p2_HrikmHuhu;//(Bプラン)払込方法
        print.PaymentMethodC__c = params.p3_HrikmHuhu;//(Cプラン)払込方法
        print.PaymentMethodTranslationA__c = params.ccRnki_P1_HrikmHuhu;//(Aプラン)払込方法翻訳
        print.PaymentMethodTranslationB__c = params.ccRnki_P2_HrikmHuhu;//(Bプラン)払込方法翻訳
        print.PaymentMethodTranslationC__c = params.ccRnki_P3_HrikmHuhu;//(Cプラン)払込方法翻訳
        
        if(String.isBlank(params.ccRnki_GukiHknr)){
            print.SumInsuranceFeeA__c = String.isBlank(params.ccRnki_P1_GukiHknr) ? 0 : Decimal.valueOf(params.ccRnki_P1_GukiHknr.replace(',', ''));//(Aプラン)合計保険料
            print.SumInsuranceFeeB__c = String.isBlank(params.ccRnki_P2_GukiHknr) ? 0 : Decimal.valueOf(params.ccRnki_P2_GukiHknr.replace(',', ''));//(Bプラン)合計保険料
            print.SumInsuranceFeeC__c = String.isBlank(params.ccRnki_P3_GukiHknr) ? 0 : Decimal.valueOf(params.ccRnki_P3_GukiHknr.replace(',', ''));//(Cプラン)合計保険料
            print.TotalInsuranceFeeA__c = String.isBlank(params.ccRnki_P1_SuGkHknr) ? 0 : Decimal.valueOf(params.ccRnki_P1_SuGkHknr.replace(',', ''));//(Aプラン)総額保険料
            print.TotalInsuranceFeeB__c = String.isBlank(params.ccRnki_P2_SuGkHknr) ? 0 : Decimal.valueOf(params.ccRnki_P2_SuGkHknr.replace(',', ''));//(Bプラン)総額保険料
            print.TotalInsuranceFeeC__c = String.isBlank(params.ccRnki_P3_SuGkHknr) ? 0 : Decimal.valueOf(params.ccRnki_P3_SuGkHknr.replace(',', ''));//(Cプラン)総額保険料
        }else{
            print.SumInsuranceFeeA__c = String.isBlank(params.ccRnki_GukiHknr) ? 0 : Decimal.valueOf(params.ccRnki_GukiHknr.replace(',', ''));//(Aプラン)合計保険料
        }
        print.PdfFilePath__c = params.pdfFilePath;//PDFファイルパス名
        print.CaseLastModifiedByName__c =targetCase.LastmodifiedBy.Name;//印刷連番
        switch on proc_code {
            when '01' {
                print.ProcName__c = 'トップメニュー（自動車・火災）';//処理名
            }
            when '02' {
                print.ProcName__c = 'トップメニュー(傷害）';//処理名
            }
            when '11' {
                print.ProcName__c = '自動車見積書作成【純新規】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '12' {
                print.ProcName__c = '自動車見積書作成【新規】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '13' {
                print.ProcName__c = '自動車見積書作成【再作成】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '14' {
                print.ProcName__c = '自動車見積書作成【更改】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '21' {
                print.ProcName__c = '自動車申込書作成';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '22' {
                print.ProcName__c = '自動車申込書作成【再作成】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '23' {
                print.ProcName__c = '自動車申込書作成【試算用】';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '31' {
                print.ProcName__c = '自動車承認請求書作成';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when '32' {
                print.ProcName__c = '自動車承認請求書再作成';//処理名
                targetCase.ExpectedShippingDate_Latest__c = Date.today().addDays(1);
                targetCase.ReturnFollow_UpDate_Latest__c = Date.today().addDays(8);
                targetCase.NoFollow_UpRequired__c = false;
                targetCase.ShipmentRequired__c = true;
            }
            when else {		  // default block, optional
                print.ProcName__c = 'その他';//処理名
            }
        }
        insert print;
        targetCase.PrintSerialNumber__c = params.ccRnki_InstRnbn;//印刷連番
        update targetCase;
        res.statusCode = 200;
        return;
    }
    public class Request{
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
        String ccRnki_IduD;
        String ccRnki_GukiHknr;
        String pdfFilePath;
        String pdfFiledata;
    }
}