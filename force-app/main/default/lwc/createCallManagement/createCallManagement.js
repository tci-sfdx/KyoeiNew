import { LightningElement, wire, api,track} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import Management_OBJECT from '@salesforce/schema/AccidentReception_Management__c';
//共通項目
import sendSV from '@salesforce/schema/AccidentReception_Management__c.SendSV__c';
import productDetails from '@salesforce/schema/AccidentReception_Management__c.ProductDetails__c';
import callDataID from '@salesforce/schema/AccidentReception_Management__c.ContractorName__c';
import RecordTypeId from '@salesforce/schema/AccidentReception_Management__c.RecordTypeId';
import callDataLine from '@salesforce/schema/AccidentReception_Management__c.CallDataLine__c';
import agencyChk from '@salesforce/schema/AccidentReception_Management__c.AgencyChk__c';
import callDate from '@salesforce/schema/AccidentReception_Management__c.CallDate__c';
import callDataIncomingCallTime from '@salesforce/schema/AccidentReception_Management__c.CallDataIncomingCallTime__c';
import endTime from '@salesforce/schema/AccidentReception_Management__c.EndTime__c';
import callerNameInput from '@salesforce/schema/AccidentReception_Management__c.CallerNameInput__c';
import callerContactInfo from '@salesforce/schema/AccidentReception_Management__c.CallerContactInfo__c';
import callerContractorRelationInput from '@salesforce/schema/AccidentReception_Management__c.CallerContractorRelationInput__c';
//火災新種・第三分野項目
import securitiesNumberKasaiThird from '@salesforce/schema/AccidentReception_Management__c.SecuritiesNumberInput1__c';
import securitiesBranchNumberKasaiThird from '@salesforce/schema/AccidentReception_Management__c.SecuritiesBranchNumber1__c';
import contractorNameKasaiThird from '@salesforce/schema/AccidentReception_Management__c.ContractorNameInput1__c';
import InsuranceItemKasai from '@salesforce/schema/AccidentReception_Management__c.InsuranceItem1__c';
import agencyKasai from '@salesforce/schema/AccidentReception_Management__c.Agency1__c';
//ヨットモ項目
import SecuritiesNumberYot from '@salesforce/schema/AccidentReception_Management__c.SecuritiesNumbeYot__c';
import ContractorNameYot from '@salesforce/schema/AccidentReception_Management__c.ContractorNameYot__c';
import agencyYot from '@salesforce/schema/AccidentReception_Management__c.agencyYot__c';
//日整連項目
import SubscriberNumber from '@salesforce/schema/AccidentReception_Management__c.SubscriberNumber__c';
import ContractorNameJASPA from '@salesforce/schema/AccidentReception_Management__c.ContractorNameJASPA__c';
//伝言管理項目
import policyNumberMsg from '@salesforce/schema/AccidentReception_Management__c.PolicyNumberMsg__c';
import securitiesBranchNumberMsg from '@salesforce/schema/AccidentReception_Management__c.SecuritiesBranchNumberMsg__c';
import contractorNameMsg from '@salesforce/schema/AccidentReception_Management__c.ContractorNameMsg__c';
import agencyMsg from '@salesforce/schema/AccidentReception_Management__c.AgencyMsg__c';
import InsuranceItemMsg from '@salesforce/schema/AccidentReception_Management__c.InsuranceItemMsg__c';
import printForm from '@salesforce/schema/AccidentReception_Management__c.PrintForm__c';
import disasterChk from '@salesforce/schema/AccidentReception_Management__c.DisasterChk__c';
import broadcast from '@salesforce/schema/AccidentReception_Management__c.Broadcast__c';
import operatorContractorRelationMsg from '@salesforce/schema/AccidentReception_Management__c.OperatorContractorRelationMsg__c';
//カスタム表示ラベル　レコードタイプID
import msgRecordTypeId from '@salesforce/label/c.CallManagementRecordType';
import ThirdFieldRecordTypeId from '@salesforce/label/c.ThirdFieldRecordType';
import TypeFireRecordTypeId from '@salesforce/label/c.TypeFireRecordType';
import YachtBoatRecordTypeId from '@salesforce/label/c.YachtBoatRecordType';
import JASPARecordTypeId from '@salesforce/label/c.JASPARecordType';
//カスタム表示ラベル　レコードタイプID
import printTypeMessage from '@salesforce/label/c.PrintTypeMessage';
import circle from '@salesforce/label/c.Circle';
import cross from '@salesforce/label/c.Cross';

export default class createCallManagement extends NavigationMixin(LightningElement){
    recordTypeId;
    @api recordId;
    @track AccidentReception_Management__c;
    @track recordTypeId;
    @wire(getRecord, { recordId: '$recordId', 
                       fields: [callDataID,RecordTypeId,sendSV,productDetails,callDataLine,agencyChk,callDate,callDataIncomingCallTime,endTime,callerNameInput,callerContactInfo,callerContractorRelationInput,
                       securitiesNumberKasaiThird,securitiesBranchNumberKasaiThird,contractorNameKasaiThird,agencyKasai,InsuranceItemKasai,
                       SecuritiesNumberYot,ContractorNameYot,agencyYot,
                       SubscriberNumber,ContractorNameJASPA]})
    managementRecord({data, error}){
        if(data){
            this.recordTypeId = data.fields.RecordTypeId.value;
            this.callDataID = data.fields.ContractorName__c.value;
            this.sendSV = data.fields.SendSV__c.value;
            this.productDetails = data.fields.ProductDetails__c.value;
            this.callDataLine = data.fields.CallDataLine__c.value;
            this.agencyChk = data.fields.AgencyChk__c.value;
            this.callDate = data.fields.CallDate__c.value;
            this.callDataIncomingCallTime = data.fields.CallDataIncomingCallTime__c.value;
            this.endTime = data.fields.EndTime__c.value;
            this.callerNameInput = data.fields.CallerNameInput__c.value;
            this.callerContactInfo = data.fields.CallerContactInfo__c.value;
            this.callerContractorRelationInput = data.fields.CallerContractorRelationInput__c.value;
            //火災新種データセット
            if(this.recordTypeId == TypeFireRecordTypeId){
                console.log("火災新種");
                this.policyNumber = data.fields.SecuritiesNumberInput1__c.value;
                this.securitiesBranchNumber = data.fields.SecuritiesBranchNumber1__c.value;
                this.contractorName = data.fields.ContractorNameInput1__c.value;
                this.agency = data.fields.Agency1__c.value;
                this.insuranceItem = data.fields.InsuranceItem1__c.value;
            //第三分野データセット
            }else if(this.recordTypeId == ThirdFieldRecordTypeId){
                this.policyNumber = data.fields.SecuritiesNumberInput1__c.value;
                this.securitiesBranchNumber = data.fields.SecuritiesBranchNumber1__c.value;
                this.contractorName = data.fields.ContractorNameInput1__c.value;
                this.insuranceItem = data.fields.InsuranceItem1__c.value;
            //ヨットモデータセット
            }else if(this.recordTypeId == YachtBoatRecordTypeId){
                this.policyNumber = data.fields.SecuritiesNumbeYot__c.value;
                this.contractorName = data.fields.ContractorNameYot__c.value;
                this.agency = data.fields.agencyYot__c.value;
            //日整連データセット
            }else if(this.recordTypeId == JASPARecordTypeId){
                this.policyNumber = data.fields.SubscriberNumber__c.value;
                this.contractorName = data.fields.ContractorNameJASPA__c.value;
            }
        } else if(error){
            console.log("error === "+error);
        }
    }

    @api async invoke() {
        const fields = {};
        fields[policyNumberMsg.fieldApiName] = this.policyNumber;
        fields[securitiesBranchNumberMsg.fieldApiName] = this.securitiesBranchNumber;
        fields[contractorNameMsg.fieldApiName] = this.contractorName;
        fields[agencyMsg.fieldApiName] = this.agency;
        fields[InsuranceItemMsg.fieldApiName] = this.insuranceItem;
        fields[callDataID.fieldApiName] = this.callDataID;
        fields[sendSV.fieldApiName] = this.sendSV;
        fields[productDetails.fieldApiName] = this.productDetails;
        fields[printForm.fieldApiName] = printTypeMessage;
        fields[disasterChk.fieldApiName] = cross;
        fields[broadcast.fieldApiName] = circle;
        fields[callDataLine.fieldApiName] = this.callDataLine;
        fields[agencyChk.fieldApiName] = this.agencyChk;
        fields[callDate.fieldApiName] = this.callDate;
        fields[callDataIncomingCallTime.fieldApiName] = this.callDataIncomingCallTime;
        fields[endTime.fieldApiName] = this.endTime;
        fields[callerNameInput.fieldApiName] = this.callerNameInput;
        fields[callerContactInfo.fieldApiName] = this.callerContactInfo;
        fields[operatorContractorRelationMsg.fieldApiName] = this.callerContractorRelationInput;
        fields[RecordTypeId.fieldApiName] = msgRecordTypeId;
        const msgRecord = {apiName: Management_OBJECT.objectApiName,fields};
        createRecord(msgRecord)
        .then((management)=> {
            dispatchEvent(
                new ShowToastEvent({
                    title: '成功',
                    message: '伝言管理が作成されました。',
                    variant: 'success',
                }),
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: management.id,
                        objectApiName: 'AccidentReception_Management__c',
                        actionName: 'view'
                    }
                }),
            );
        })
        .catch(error => {
            dispatchEvent(
                new ShowToastEvent({
                    title: '作成失敗',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }
}