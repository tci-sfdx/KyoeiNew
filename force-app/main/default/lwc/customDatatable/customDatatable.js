import LightningDatatable from 'lightning/datatable';
import link from './link.html';

export default class CustomDatatable extends LightningDatatable {
   static customTypes = {
        customLink: {
            template: link,
            typeAttributes: ['linkName','linkId'],
        },
   };
}