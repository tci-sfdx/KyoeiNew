import { LightningElement,wire, api,track} from 'lwc';

import onlineSearchFormHtml from './onlineSearchForm.html';
// Apex method
import getUserOnlineInfo from '@salesforce/apex/OnlineSearchFormController.getUserOnlineInfo';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import onlineURL from '@salesforce/label/c.onlineURL';
const FIELDS = ["Account.SecurityNumberParentNumber__pc",
                "Account.SecurityNumberBranchNumber__pc", 
                "Account.DestinationCode__pc",
                "Account.TypeCode__pc"];
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

export default class onlineSearchForm extends LightningElement {
    GCODE = '';
    GDATA = '';
    GYOUMU_ID = '';
    USER_ID = '';
    USER_PW = '';
    GYOMU_CD = '';
    DAIRITEN_CD = '';
    SHOKEN_NO_OYA = '';
    SHOKEN_NO_EDA = '';
    SHUMOKU = '';
    onlineURLLocal = onlineURL;
    

    @api recordId;
    contact;
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
                this.contact = data;
                this.SHOKEN_NO_OYA = this.contact.fields.SecurityNumberParentNumber__pc.value;
                this.SHOKEN_NO_EDA = this.contact.fields.SecurityNumberBranchNumber__pc.value;
                this.DAIRITEN_CD = this.contact.fields.DestinationCode__pc.value;
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
        param = param + '\t' + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        param = param + '\t' + 'SHOKEN_NO_OYA=' + this.SHOKEN_NO_OYA;
        param = param + '\t' + 'SHOKEN_NO_EDA=' + (this.SHOKEN_NO_EDA ? this.SHOKEN_NO_EDA : '     ');

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
        param = param + '\t' + 'DAIRITEN_CD=' + this.DAIRITEN_CD;
        param = param + '\t' + 'SHOKEN_NO_OYA=' + this.SHOKEN_NO_OYA;
        param = param + '\t' + 'SHOKEN_NO_EDA=' + this.SHOKEN_NO_EDA;
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
        param = param + '\t' + 'SHOKEN_NO_OYA=' + this.SHOKEN_NO_OYA;

        const url = onlineURL;
        console.log(url);
        console.log(param);
        this.template.querySelector('[data-id="link"]').insertAdjacentHTML('beforeend',`<a target="_blank" href="${encodeURI(url + param)}" data-id="theLink">link</a>`);
        this.template.querySelector('[data-id="theLink"]').click();
        this.template.querySelector('[data-id="theLink"]').remove();
        evt.stopPropagation();
    }
    
}