import { LightningElement,wire, api,track} from 'lwc';

import onlineSearchFormHtml from './onlineSearchFormCase.html';
// Apex method
import getUserOnlineInfo from '@salesforce/apex/OnlineSearchFormController.getUserOnlineInfo';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import onlineURL from '@salesforce/label/c.onlineURL';
const FIELDS = ["Case.PolicyNumber__c",
                "Case.StockNumberMainNumber__c",
                "Case.SecuritiesBranch__c",
                "Case.ReferenceAccountCode__c",
                "Case.CommencementOfInsurance__c",
                "Case.EndInsurance__c",
                "Case.ContractorName__c",
                "Case.ContractorName_Kana__c",
                "Case.ContractorPhoneNumber__c",
                "Case.PolicyholderZipCode__c",
                "Case.ContractorAddress__c",
                "Case.ReferenceAccount__c",
                "Case.OfficeName__c",
                "Case.HasSpecialOrder__c",
                "Case.GroupCode__c",
                "Case.GroupGroupName__c",
                "Case.HasAccident__c",
                "Case.FukokuCode__c",
                "Case.TypeOfInsurance__c",
                "Case.InsuranceFee__c",
                "Case.ContractorBirthday__c",
                "Case.ContractorAge__c",
                "Case.ContractorSex__c",
                "Case.RelatedBranchCode__c",
                "Case.AgencyName__c",
                "Case.EmployeeCode__c",
                "Case.CifCode__c",
                "Case.ContactInfo__c",
                "Case.PaymentMethod__c",
                "Case.Policyholder_SAddressInKana__c"];
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

export default class onlineSearchForm extends LightningElement {
    GCODE;
    GDATA;
    GYOUMU_ID;
    USER_ID;
    USER_PW;
    GYOMU_CD;
    DAIRITEN_CD;
    SHOKEN_NO_OYA;
    SHOKEN_NO_EDA;
    SHUMOKU;
    onlineURLLocal = onlineURL;
    ContractorName__c;
    AgencyName__c;
    PolicyholderZipCode__c;
    ContractorAge__c;
    GroupGroupName__c;
    GroupCode__c;
    EmployeeCode__c;
    FukokuCode__c;
    RelatedBranchCode__c;
    ContractorAddress__c;

    @api recordId;
    case;
    @wire(getRecord, 
        { recordId: '$recordId',
            fields:FIELDS})
            wiredRecord({ error, data }) {
            if (error) {
                console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "読み込みエラー",
                        message: '読み込みエラー',
                        variant: "error",
                    }),
                );
            } else if (data) {
                this.case = data;
                this.SHOKEN_NO_OYA = (this.case.fields.PolicyNumber__c.value ? 
                    this.case.fields.PolicyNumber__c.value : this.case.fields.StockNumberMainNumber__c.value);
                this.SHOKEN_NO_EDA = (this.case.fields.SecuritiesBranch__c.value ? this.case.fields.SecuritiesBranch__c.value : '');
                this.SHUMOKU = '';
                this.DAIRITEN_CD = this.case.fields.ReferenceAccountCode__c.value;
                this.ContractorName__c = this.case.fields.ContractorName__c.value;
                this.AgencyName__c = this.case.fields.AgencyName__c.value;
                this.PolicyholderZipCode__c = this.case.fields.PolicyholderZipCode__c.value;
                this.ContractorAge__c = this.case.fields.ContractorAge__c.value;
                this.GroupGroupName__c = this.case.fields.GroupGroupName__c.value;
                this.GroupCode__c = this.case.fields.GroupCode__c.value;
                this.EmployeeCode__c = this.case.fields.EmployeeCode__c.value;
                this.FukokuCode__c = this.case.fields.FukokuCode__c.value;
                this.RelatedBranchCode__c = this.case.fields.RelatedBranchCode__c.value;
                this.ContractorAddress__c = this.case.fields.ContractorAddress__c.value;
            }
        }

    @wire(getUserOnlineInfo)
    getUserOnlineInfo({ error, data }){
        if (error) {
            // 何もしない
        } else if (data) {
            this.USER_ID = data[0]['OnlineID__c']
            this.USER_PW = data[0]['OnlinePW__c']
        }
    }
    render() {
        return onlineSearchFormHtml;
    }
    doConnectPattern1(evt){
        evt.preventDefault();
        
        this.GCODE = '3011000001';
        this.GYOUMU_ID = this.recordId;
        this.GYOMU_CD = '04';
        this.DAIRITEN_CD = this.template.querySelector('[data-id="DAIRITEN_CD"]').value;
        this.SHOKEN_NO_OYA = this.template.querySelector('[data-id="SHOKEN_NO_OYA"]').value;
        this.SHOKEN_NO_EDA = this.template.querySelector('[data-id="SHOKEN_NO_EDA"]').value;
        let param;

        let isError = false;
        let DAIRITEN_CD_Regex = /^[0-9]{8,11}$/;
        if(!(this.DAIRITEN_CD == null || this.DAIRITEN_CD == '') && !this.DAIRITEN_CD.match(DAIRITEN_CD_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '代理店コードの入力エラー',
                    message: '代理店コードは半角数字8桁から11桁までです',
                    variant: 'info',
                }),
            );
        }
        let SHOKEN_NO_OYA_Regex = /^[a-zA-Z0-9]{10,12}$/;
        if(!this.SHOKEN_NO_OYA.match(SHOKEN_NO_OYA_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '証券番号親番の入力エラー',
                    message: '証券番号親番は半角数字10桁から12桁のいずれかです',
                    variant: 'info',
                }),
            );
        }
        let SHOKEN_NO_EDA_Regex = /^[0-9]{1,5}$/;
        if(!(this.SHOKEN_NO_EDA == null || this.SHOKEN_NO_EDA == '') && !this.SHOKEN_NO_EDA.match(SHOKEN_NO_EDA_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '証券番号枝番の入力エラー',
                    message: '証券番号枝番は半角数字5桁です',
                    variant: 'info',
                }),
            );
        }

        if(isError) return ;
        // 
        param = '?GCODE=' + this.GCODE ;
        param = param + '&GDATA='  ;
        param = param + 'GYOUMU_ID=' + this.GYOUMU_ID;
        param = param + '\t' + 'USER_ID=' + this.USER_ID;
        param = param + '\t' + 'USER_PW=' + this.USER_PW;
        param = param + '\t' + 'GYOMU_CD=' + this.GYOMU_CD;
        param = param + '\t' + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        param = param + '\t' + 'SHOKEN_NO_OYA=' + this.SHOKEN_NO_OYA;
        param = param + '\t' + 'SHOKEN_NO_EDA=' + this.SHOKEN_NO_EDA;

        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${encodeURI(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();
        evt.stopPropagation();
    }

    doConnectPattern2(evt){
        evt.preventDefault();
        
        this.GCODE = '3011000001';
        this.GYOUMU_ID = this.recordId;
        this.GYOMU_CD = '20';
        this.DAIRITEN_CD = this.template.querySelector('[data-id="DAIRITEN_CD"]').value;
        this.SHOKEN_NO_OYA = this.template.querySelector('[data-id="SHOKEN_NO_OYA"]').value;
        this.SHOKEN_NO_EDA = this.template.querySelector('[data-id="SHOKEN_NO_EDA"]').value;
        if(this.SHOKEN_NO_EDA == '') this.SHOKEN_NO_EDA = '00001';
        this.SHUMOKU = this.template.querySelector('[data-id="SHUMOKU"]').value;
        let param;
        let isError = false;
        let DAIRITEN_CD_Regex = /^[0-9]{8,11}$/;
        if(!(this.DAIRITEN_CD == null || this.DAIRITEN_CD == '') && !this.DAIRITEN_CD.match(DAIRITEN_CD_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '代理店コードの入力エラー',
                    message: '代理店コードは半角数字8桁から11桁までです',
                    variant: 'info',
                }),
            );
        }
        let SHOKEN_NO_OYA_Regex = /^[0-9]{10,12}$/;
        if(!this.SHOKEN_NO_OYA.match(SHOKEN_NO_OYA_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '証券番号親番の入力エラー',
                    message: '証券番号親番は半角数字10桁から12桁のいずれかです',
                    variant: 'info',
                }),
            );
        }
        let SHOKEN_NO_EDA_Regex = /^[0-9]{1,5}$/;
        if(!(this.SHOKEN_NO_EDA == null || this.SHOKEN_NO_EDA == '') && !this.SHOKEN_NO_EDA.match(SHOKEN_NO_EDA_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '証券番号枝番の入力エラー',
                    message: '証券番号枝番は半角数字5桁です',
                    variant: 'info',
                }),
            );
        }

        if(isError) return ;

        // 
        param = '?GCODE=' + this.GCODE ;
        param = param + '&GDATA='  ;
        param = param + 'GYOUMU_ID=' + this.GYOUMU_ID;
        param = param + '\t' + 'USER_ID=' + this.USER_ID;
        param = param + '\t' + 'USER_PW=' + this.USER_PW;
        param = param + '\t' + 'GYOMU_CD=' + this.GYOMU_CD;
        param = param + '\t' + 'DAIRITEN_CD=' + (this.DAIRITEN_CD ? this.DAIRITEN_CD : '');
        param = param + '\t' + 'SHOKEN_NO_OYA=' + (this.SHOKEN_NO_OYA ? this.SHOKEN_NO_OYA : '');
        param = param + '\t' + 'SHOKEN_NO_EDA=' + (this.SHOKEN_NO_EDA ? this.SHOKEN_NO_EDA : '');
        param = param + '\t' + 'SHUMOKU=' + this.SHUMOKU;

        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${encodeURI(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();
        evt.stopPropagation();
    }
    
    doConnectPattern3(evt){
        evt.preventDefault();
        
        this.GCODE = '3011000001';
        this.GYOUMU_ID = this.recordId;
        this.GYOMU_CD = '21';
        this.DAIRITEN_CD = this.template.querySelector('[data-id="DAIRITEN_CD"]').value;
        this.SHOKEN_NO_OYA = this.template.querySelector('[data-id="SHOKEN_NO_OYA"]').value;
        let param;

        let isError = false;
        let DAIRITEN_CD_Regex = /^[0-9]{8,11}$/;
        if(!(this.DAIRITEN_CD == null || this.DAIRITEN_CD == '') && !this.DAIRITEN_CD.match(DAIRITEN_CD_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '代理店コードの入力エラー',
                    message: '代理店コードは半角数字8桁から11桁までです',
                    variant: 'info',
                }),
            );
        }
        
        let SHOKEN_NO_OYA_Regex = /^[a-zA-Z0-9]{9,10}$/;
        if(!this.SHOKEN_NO_OYA.match(SHOKEN_NO_OYA_Regex)){
            isError = true;
            dispatchEvent(
                new ShowToastEvent({
                    title: '証券番号親番の入力エラー',
                    message: '証券番号親番は半角数字9桁、10桁のいずれかです',
                    variant: 'info',
                }),
            );
        }
        
        if(isError) return ;
        // 
        param = '?GCODE=' + this.GCODE ;
        param = param + '&GDATA='  ;
        param = param + 'GYOUMU_ID=' + this.GYOUMU_ID;
        param = param + '\t' + 'USER_ID=' + this.USER_ID;
        param = param + '\t' + 'USER_PW=' + this.USER_PW;
        param = param + '\t' + 'GYOMU_CD=' + this.GYOMU_CD;
        param = param + '\t' + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        param = param + '\t' + 'SHOKEN_NO_OYA=' + (this.SHOKEN_NO_OYA ? this.SHOKEN_NO_OYA : '');

        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${encodeURI(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();
        evt.stopPropagation();
    }
    
}