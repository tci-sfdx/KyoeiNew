import { LightningElement, api } from 'lwc';

export default class DatatableLinkRow extends LightningElement {
    @api rowId
    @api linkName;
    @api linkId;

    handleClick(){
        const URL = document.location.origin

        // コールログ画面
        window.open(URL + '/lightning/r/PrintSerialNumber__c/'+this.linkId +'/view', "_blank");
    }
}