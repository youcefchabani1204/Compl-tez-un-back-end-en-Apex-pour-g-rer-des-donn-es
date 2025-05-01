import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import quickDelivery from '@salesforce/apex/TransporterService.quickDelivery';
import cheapDelivery from '@salesforce/apex/TransporterService.cheapDelivery';
import ACCOUNT_ID_FIELD from '@salesforce/schema/Order.AccountId';
import changeTransporter from '@salesforce/apex/TransporterService.changeTransporter';
import selectTransporterToUpdateDelivery from '@salesforce/apex/DeliveryService.selectTransporterToUpdateDelivery';
import ORDER_VALIDATED from '@salesforce/schema/Order.OrderValidated__c';

export default class DeliveryViewer extends LightningElement {
    @api recordId; 
    @track transporter;
    @track alternativetransporters=[];
    @track alltransporters=[];
    @track error; 
    @track orderValidated = false;
    @track change = false;
    @track list=false;
    @track validationMessage = '';
    @track boutonValidate=false;
    accountId;
  
    @wire(getRecord, { recordId: '$recordId', fields: [ORDER_VALIDATED,ACCOUNT_ID_FIELD] })
    wiredOrder({ error, data }) {
      
        if (data) {
            this.accountId = data.fields.AccountId.value; 
          
          
            if (data.fields.OrderValidated__c.value) {
                
                this.orderValidated = data.fields.OrderValidated__c.value;
                
                this.validationMessage = '✅ Commande validée ! Vous pouvez choisir un mode de livraison.';
            } else {
               
                this.validationMessage = '❌ Commande invalide : un particulier doit commander au moins 3 produits, un professionnel au moins 5.';
            }
          
           
        } else if (error) {
            this.error = error;
            this.validationMessage = '⚠️ Une erreur est survenue pendant la validation.';
        }
    }



    handleQuick() {
        this.change = true;
      
        quickDelivery({ clientId: this.accountId})
            .then(result => {
                this.transporter = result;
                this.error = undefined;
                this.selectedTransporterId = this.transporter.Transporter__r.Id;
                this.selectedTransporterPriceId = this.transporter.Id;
                this.boutonValidate = true;
               
            })
            .catch(error => {
                this.transporter = undefined;
                this.error = error;
            });
    }

    handleCheap() {
        this.change = true;
        cheapDelivery({ clientId: this.accountId })
            .then(result => {
                this.transporter = result;
                this.error = undefined;
                this.selectedTransporterId = this.transporter.Transporter__r.Id;
                this.selectedTransporterPriceId = this.transporter.Id;
                this.boutonValidate = true;

                
            })
            .catch(error => {
                this.error = error;
                this.transporter = undefined;
            });
    }
    handleChange(){
       this.list=true;
        changeTransporter({ clientId: this.accountId })
            .then(result => {
                this.alltransporters=result;
                this.alternativetransporters = result.map(t => ({ label: t.Transporter__r.Name,
                    value: t.Id }));


                this.error = undefined;
            })
            .catch(error => {
                this.alternativetransporters = undefined;
                this.error = error;
            });
        }

    handleSelect(event) {
   const selectedId = event.detail.value;
    
     const selectedtransporter = this.alternativetransporters.find(
            t => t.value === selectedId
        );
       
        this.transporter = this.alltransporters.find(
            t => t.Transporter__r.Name ===selectedtransporter.label
        );
        this.selectedTransporterId = this.transporter.Transporter__r.Id;
        this.selectedTransporterPriceId = this.transporter.Id;
    }
      
     
            
    handleValidate() {
        selectTransporterToUpdateDelivery({
            orderId: this.recordId,
            transporterId: this.selectedTransporterId,
            transporterPriceId: this.selectedTransporterPriceId
           
        })
        .then(() => {
           
            console.log('Livraison mise à jour avec succès.',this.selectedTransporterPriceId);
        })
        .catch(error => {
            console.error('Erreur de mise à jour:', error);

        });
    }    

}






