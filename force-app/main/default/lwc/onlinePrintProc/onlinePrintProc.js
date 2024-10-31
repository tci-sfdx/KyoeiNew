import { LightningElement,wire, api,track} from 'lwc';

import onlinePrintProc from './onlinePrintProc.html';
//load staticresource
import encodingjs from "@salesforce/resourceUrl/encoding";
import { loadScript } from "lightning/platformResourceLoader";
// Apex method
import getUserOnlineInfo from '@salesforce/apex/OnlinePrintProcController.getUserOnlineInfo';
import getPrintDatas from '@salesforce/apex/OnlinePrintProcController.getPrintDatas';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import onlineURL from '@salesforce/label/c.onlineURL';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
const FIELDS = ["case.PolicyNumber__c",
                "case.StockNumberMainNumber__c",
                "case.SecuritiesBranch__c",
                "case.CommencementOfInsurance__c",
                "case.EndInsurance__c",
                "case.PrintSerialNumber__c",
                "case.ContractorName__c",
                "case.ContractorName_Kana__c",
                "case.PolicyholderZipCode__c",
                "case.ContractorAddress__c",
                "case.NewPhoneNumber__c",
                "case.Policyholder_SAddressInKana__c",
                "case.ReferenceAccountCode__c"];
const actions = [
    { label: '自動車見積書作成【純新規】', name: 'pattern1_1' },
    { label: '自動車見積書作成【新規】', name: 'pattern1_2' },
    { label: '自動車見積書作成【再作成】', name: 'pattern1_3' },
    { label: '自動車見積書作成【更改】', name: 'pattern1_4' },
    { label: '自動車申込書作成', name: 'pattern2_1' },
    { label: '自動車申込書作成【再作成】', name: 'pattern2_2' },
    { label: '自動車申込書作成【試算用】', name: 'pattern2_3' },
    { label: '自動車承認請求書作成', name: 'pattern3_1' },
    { label: '自動車承認請求書再作成', name: 'pattern3_2' },
];
const COLUMS = [
    
    { label: '処理名', fieldName: 'ProcName__c'},
    { label: '印刷連番', fieldName: 'Name'},
    { label: '証券番号', fieldName: 'PolicyNumber__c'},
    { label: '保険始期日／異動日', fieldName: 'ProcDate' },
    { label: '取込日時', fieldName: 'CreatedDate' },
    { label: 'プラン', fieldName: 'Plan'},
    { label: '払込方法', fieldName: 'PaymentMethodTranslation' }, 
    { label: '保険終期', fieldName: 'InsurancePeriod' },
    { label: '合計保険料', fieldName: 'InsuranceFee' }, 
    { label: '総額保険料', fieldName: 'TotalInsuranceFee' }, 
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },

];


export default class onlineSearchForm extends LightningElement {
    columns = COLUMS;
    onlineURLLocal = onlineURL;
    // use api
    GCODE = '';
    GDATA = '';
    GYOUMU_ID = '';
    USER_ID = '';
    USER_PW = '';
    GYOMU_CD = '';
    DAIRITEN_CD = '';
    UKETSUKE_KBN = '';
    KEIYAKUSHA_KNJ = '';
    KEIYAKUSHA_KANA = '';
    OLD_INSATSURENBAN = '';
    SHOKEN_NO = '';
    HKN_SHIKI = '';
    PLAN_CD = '';
    KEIYAKUSHA_YUBIN_NO = '';
    KEIYAKUSHA_JUSHO_KNJ = '';
    KEIYAKUSHA_TEL = '';
    KEIYAKUSHA_E_MAIL = '';
    SHUDAN_CD = '';
    KEIYAKUSHA_JUSHO_KANA = '';
    encodedTab = encodeURI('\t');
    PolicyNumber = '';
    StartInsurance = '';
    EndInsurance = '';
    PrintSerialNumber = '';
    ReferenceAccountCode = '';
    @api hasPrintDatas= false;
    @api printSerialNumbers;
    
    @api recordId;
    case;
    @wire(getRecord, 
        { recordId: '$recordId',
            fields:FIELDS})
            wiredRecord({ error, data }) {
            if (error) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "読み込みエラー",
                        message,
                        variant: "error",
                    }),
                );
            } else if (data) {
                this.case = data;
                this.PolicyNumber = this.case.fields.SecuritiesBranch__c.value ? 
                    ((this.case.fields.StockNumberMainNumber__c.value ? this.case.fields.StockNumberMainNumber__c.value : '') +
                    (this.case.fields.SecuritiesBranch__c.value ? this.case.fields.SecuritiesBranch__c.value : '')) : this.case.fields.PolicyNumber__c.value;
                this.SHOKEN_NO = this.PolicyNumber ? this.PolicyNumber:'';
                this.KEIYAKUSHA_KNJ = this.case.fields.ContractorName__c.value ? this.case.fields.ContractorName__c.value:'';
                this.KEIYAKUSHA_KANA = this.case.fields.ContractorName_Kana__c.value ? this.case.fields.ContractorName_Kana__c.value:'';
                this.StartInsurance = this.case.fields.CommencementOfInsurance__c.value;
                this.EndInsurance = this.case.fields.EndInsurance__c.value;
                this.PrintSerialNumber = this.case.fields.PrintSerialNumber__c.value;
                this.ReferenceAccountCode = this.case.fields.ReferenceAccountCode__c.value;
                this.KEIYAKUSHA_YUBIN_NO = this.case.fields.PolicyholderZipCode__c.value ? this.case.fields.PolicyholderZipCode__c.value.replaceAll('-',''):'';
                this.KEIYAKUSHA_JUSHO_KNJ = this.case.fields.ContractorAddress__c.value ? this.case.fields.ContractorAddress__c.value:'';
                this.KEIYAKUSHA_TEL = this.case.fields.NewPhoneNumber__c.value ? this.case.fields.NewPhoneNumber__c.value:'';
                this.KEIYAKUSHA_JUSHO_KANA = this.case.fields.Policyholder_SAddressInKana__c.value ? this.case.fields.Policyholder_SAddressInKana__c.value:'';
            }
        }
        encodingjs;
        async connectedCallback() {
            await Promise.all([
                loadScript(this, encodingjs),
            ])
            .then(() => {
            })
            .catch((e) => console.error(e));
        }
    @wire(getUserOnlineInfo)
    getUserOnlineInfo({ error, data }){
        if (error) {
            // 何もしない
        } else if (data) {
            this.USER_ID = data[0]['OnlineID__c'] ? data[0]['OnlineID__c'] : '';
            this.USER_PW = data[0]['OnlinePW__c'] ? data[0]['OnlinePW__c'] : '';
        }
    }
    @wire(getPrintDatas, { caseId: '$recordId'}) 
    getPrintDatas({ error, data }){
        if (error) {
            // 何もしない
            console.log('error')
        } else if (data) {
            // 空データの時に、画面に履歴が無いことを表示するため分岐
            if(data.length > 0){
                this.hasPrintDatas = true;
                this.printSerialNumbers = data;
            }
        }
    }
    render() {
        return onlinePrintProc;
    }
    handleRowAction(e){
        console.log(e);
        const actionName = e.detail.action.name;
        const row = e.detail.row;
        if(row.ProcDate){
            let matches = row.ProcDate.slice(0,3).match('^(M|T|S|H|R)([0-9]+)$');
            if(matches) {
        
                let eraName = matches[1];
                let year = parseInt(matches[2]);
                if(eraName === 'M') {
                    year += 1867;
        
                } else if(eraName === 'T') {
                    year += 1911;
        
                } else if(eraName === 'S') {
                    year += 1925;
        
                } else if(eraName === 'H') {
                    year += 1988;
        
                } else if(eraName === 'R') {
                    year += 2018;
        
                }
                this.HKN_SHIKI = '' + year + row.ProcDate.slice(3,);
            }else{
                this.HKN_SHIKI = '';

            }
        }
        console.log(this.HKN_SHIKI);

        this.GYOUMU_ID = this.recordId.slice(0,15);
        switch (actionName) {
            case 'pattern0_1':
                this.GCODE = '3000000000';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '1';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '01';
                break;
            case 'pattern0_2':
                this.GCODE = '3000000000';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '2';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '02';
                break;
                
            case 'pattern1_1':
                this.GCODE = '3022000001';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '1';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '11';
                break;
            case 'pattern1_2':
                this.GCODE = '3022000001';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '2';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '12';
                break;
                
            case 'pattern1_3':
                this.GCODE = '3021000002';
                this.GYOMU_CD = '08';
                this.OLD_INSATSURENBAN = row.Name;
                this.GYOUMU_ID = this.recordId.slice(0,15) + '13';
                break;
            case 'pattern1_4':
                this.GCODE = '3021000002';
                this.GYOMU_CD = '08';
                this.OLD_INSATSURENBAN = row.Name;
                this.GYOUMU_ID = this.recordId.slice(0,15) + '14';
                break;

            case 'pattern2_1':
                this.GCODE = '3021000003';
                this.GYOMU_CD = '15';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '21';
                break;
            case 'pattern2_2':
                this.GCODE = '3021000003';
                this.GYOMU_CD = '15';
                this.OLD_INSATSURENBAN = row.Name;
                this.GYOUMU_ID = this.recordId.slice(0,15) + '22';
                break;
                
            case 'pattern2_3':
                this.GCODE = '3022000000';
                this.GYOMU_CD = '15';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '23';
                break;
            
            case 'pattern3_1':
                this.GCODE = '3023000001';
                this.GYOMU_CD = '18';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '31';
                break;
            case 'pattern3_2':
                this.GCODE = '3023000004';
                this.GYOMU_CD = '18';
                this.OLD_INSATSURENBAN = row.Name;
                this.GYOUMU_ID = this.recordId.slice(0,15) + '32';
                break;
        }
        this.DAIRITEN_CD = this.template.querySelector('[data-id="DAIRITEN_CD"]').value ? 
            (this.template.querySelector('[data-id="DAIRITEN_CD"]').value+'00000000000').slice(0,11) : '99999999999';
        this.PLAN_CD = row.Plan;
        let param;
        param = '?GCODE=' + this.GCODE ;
        param = param + '&GDATA='  ;
        param = param + 'GYOUMU_ID=' + this.GYOUMU_ID;
        param = param + this.encodedTab + 'USER_ID=' + this.USER_ID;
        param = param + this.encodedTab + 'USER_PW=' + this.USER_PW;
        param = param + this.encodedTab + 'GYOMU_CD=' + this.GYOMU_CD;
        param = param + this.encodedTab + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        let KEIYAKUSHA_KNJ = 
        Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_KNJ, {
            to: 'SJIS',
            from: 'UNICODE'
        }));
        let KEIYAKUSHA_KANA = 
        Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_KANA, {
            to: 'SJIS',
            from: 'UNICODE'
        }));
        let KEIYAKUSHA_JUSHO_KNJ = 
        Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_JUSHO_KNJ, {
            to: 'SJIS',
            from: 'UNICODE'
        }));
        let KEIYAKUSHA_JUSHO_KANA = 
        Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_JUSHO_KANA, {
            to: 'SJIS',
            from: 'UNICODE'
        }));
        if(actionName == 'pattern1_1' || actionName == 'pattern1_2'|| actionName == 'pattern1_3'|| actionName == 'pattern1_4'){

            param = param + this.encodedTab + 'UKETSUKE_KBN=' + this.UKETSUKE_KBN;
            param = param + this.encodedTab + 'KEIYAKUSHA_KNJ=' + KEIYAKUSHA_KNJ;
            param = param + this.encodedTab + 'KEIYAKUSHA_KANA=' + KEIYAKUSHA_KANA;
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'HKN_SHIKI=' + (this.HKN_SHIKI ? this.HKN_SHIKI : '');
        
        }

        if(actionName == 'pattern2_1' || actionName == 'pattern2_2'|| actionName == 'pattern2_3'){
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
            param = param + this.encodedTab + 'PLAN_CD=' + (this.PLAN_CD ? this.PLAN_CD : '');
            param = param + this.encodedTab + 'KEIYAKUSHA_YUBIN_NO=' + this.KEIYAKUSHA_YUBIN_NO.replaceAll('-','');

            param = param + this.encodedTab + 'KEIYAKUSHA_JUSHO_KNJ=' + KEIYAKUSHA_JUSHO_KNJ;
            param = param + this.encodedTab + 'KEIYAKUSHA_TEL=' + this.KEIYAKUSHA_TEL;
            param = param + this.encodedTab + 'KEIYAKUSHA_E_MAIL=' + this.KEIYAKUSHA_E_MAIL;
            param = param + this.encodedTab + 'SHUDAN_CD=' + this.SHUDAN_CD;
            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'HKN_SHIKI=' + this.HKN_SHIKI;
            param = param + this.encodedTab + 'KEIYAKUSHA_JUSHO_KANA=' + KEIYAKUSHA_JUSHO_KANA;
        }
        if(actionName == 'pattern3_1' || actionName == 'pattern3_2'){

            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
        }
        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();

    }
    handleOnselect(e){
        console.log(e);
        const actionName = e.detail.value;
        this.OLD_INSATSURENBAN =  this.template.querySelector('[data-id="PrintSerialNumber"]').value;
        let KEIYAKUSHA_KNJ = this.KEIYAKUSHA_KNJ ? Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_KNJ, {
            to: 'SJIS',
            from: 'UNICODE'
        })) : '';
        let KEIYAKUSHA_KANA = this.KEIYAKUSHA_KANA ? Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_KANA, {
            to: 'SJIS',
            from: 'UNICODE'
        })) : '';
        let KEIYAKUSHA_JUSHO_KNJ = this.KEIYAKUSHA_JUSHO_KNJ ? Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_JUSHO_KNJ, {
            to: 'SJIS',
            from: 'UNICODE'
        })) : '';
        let KEIYAKUSHA_JUSHO_KANA = this.KEIYAKUSHA_JUSHO_KANA ? Encoding.urlEncode(Encoding.convert(this.KEIYAKUSHA_JUSHO_KANA, {
            to: 'SJIS',
            from: 'UNICODE'
        })) : '';
        
        this.GYOUMU_ID = this.recordId.slice(0,15);
        switch (actionName) {
            case 'pattern0_1':
                this.GCODE = '3000000000';
                this.GYOMU_CD = '01';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '01';
                break;
            case 'pattern0_2':
                this.GCODE = '3000000000';
                this.GYOMU_CD = '02';
                
                this.GYOUMU_ID = this.recordId.slice(0,15) + '02';
                break;
                
            case 'pattern1_1':
                this.GCODE = '3022000001';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '1';
                
                this.GYOUMU_ID = this.recordId.slice(0,15) + '11';
                break;
            case 'pattern1_2':
                this.GCODE = '3022000001';
                this.GYOMU_CD = '08';
                this.UKETSUKE_KBN = '2';
                
                this.GYOUMU_ID = this.recordId.slice(0,15) + '12';
                break;
                
            case 'pattern1_3':
                this.GCODE = '3021000002';
                this.GYOMU_CD = '08';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '13';
                break;
                
            case 'pattern1_4':
                this.GCODE = '3021000002';
                this.GYOMU_CD = '08';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '14';
                break;

            case 'pattern2_1':
                this.GCODE = '3021000003';
                this.GYOMU_CD = '15';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '21';
                break;
            case 'pattern2_2':
                this.GCODE = '3021000003';
                this.GYOMU_CD = '15';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '22';
                break;
                
            case 'pattern2_3':
                this.GCODE = '3022000000';
                this.GYOMU_CD = '15';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '23';
                break;
            
            case 'pattern3_1':
                this.GCODE = '3023000001';
                this.GYOMU_CD = '18';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '31';
                break;
            case 'pattern3_2':
                this.GCODE = '3023000004';
                this.GYOMU_CD = '18';
                this.GYOUMU_ID = this.recordId.slice(0,15) + '32';
                break;
        }
        this.DAIRITEN_CD = this.template.querySelector('[data-id="DAIRITEN_CD"]').value ? 
            (this.template.querySelector('[data-id="DAIRITEN_CD"]').value+ '00000000000').slice(0,11) : '99999999999';
        this.PLAN_CD = '';
        let param;
        param = '?GCODE=' + this.GCODE ;
        param = param + '&GDATA='  ;
        param = param + 'GYOUMU_ID=' + this.GYOUMU_ID;
        param = param + this.encodedTab + 'USER_ID=' + this.USER_ID;
        param = param + this.encodedTab + 'USER_PW=' + this.USER_PW;
        param = param + this.encodedTab + 'GYOMU_CD=' + this.GYOMU_CD;
        param = param + this.encodedTab + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        
        if(actionName == 'pattern1_1' || actionName == 'pattern1_2'|| actionName == 'pattern1_3'|| actionName == 'pattern1_4'){

            param = param + this.encodedTab + 'UKETSUKE_KBN=' + this.UKETSUKE_KBN;
            param = param + this.encodedTab + 'KEIYAKUSHA_KNJ=' + KEIYAKUSHA_KNJ;
            param = param + this.encodedTab + 'KEIYAKUSHA_KANA=' + KEIYAKUSHA_KANA;
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'HKN_SHIKI=' + (this.StartInsurance ? this.StartInsurance.replaceAll('-','') : '');
        
        }

        if(actionName == 'pattern2_1' || actionName == 'pattern2_2'|| actionName == 'pattern2_3'){
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
            param = param + this.encodedTab + 'PLAN_CD=' + (this.PLAN_CD);
            param = param + this.encodedTab + 'KEIYAKUSHA_YUBIN_NO=' + (this.KEIYAKUSHA_YUBIN_NO.replaceAll('-',''));
            param = param + this.encodedTab + 'KEIYAKUSHA_JUSHO_KNJ=' + KEIYAKUSHA_JUSHO_KNJ;
            param = param + this.encodedTab + 'KEIYAKUSHA_TEL=' + this.KEIYAKUSHA_TEL;
            param = param + this.encodedTab + 'KEIYAKUSHA_E_MAIL=' + this.KEIYAKUSHA_E_MAIL;
            param = param + this.encodedTab + 'SHUDAN_CD=' + this.SHUDAN_CD;
            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'HKN_SHIKI=' + (this.StartInsurance ? this.StartInsurance.replaceAll('-','') : '');
            param = param + this.encodedTab + 'KEIYAKUSHA_JUSHO_KANA=' + KEIYAKUSHA_JUSHO_KANA;
        }
        if(actionName == 'pattern3_1' || actionName == 'pattern3_2'){

            param = param + this.encodedTab + 'SHOKEN_NO=' + (this.SHOKEN_NO ? this.SHOKEN_NO : '');
            param = param + this.encodedTab + 'OLD_INSATSURENBAN=' + this.OLD_INSATSURENBAN;
        }
        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();
    }
    
    dateToWareki(targetDate){
        console.log(targetDate);
        let targets = targetDate.split('-');
        if(targets.length != 3) return '';
        let baseWareki = new Intl.DateTimeFormat('ja-JP-u-ca-japanese', {era: 'narrow'}).format(new Date(targetDate));
        let y = ( '00' + baseWareki.split('/')[0].slice(1) ).slice( -2 );
        let m = ( '00' + targets[1] ).slice( -2 );
        let d = ( '00' + targets[2] ).slice( -2 );
        let x = baseWareki.slice(0,1);
        return x + y + m + d ;
    }
}