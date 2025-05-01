public with sharing class TransporterService {
    
    @AuraEnabled(cacheable=true)
    public static Transporter_Price__c quickDelivery(Id clientId) {
        Account client=AccountSelector.getAccountById( clientId);
        String clientCountry = client.BillingCountry;
        String clientType = OrderService.ifParticulier(client) ? 'Particulier' : 'Professionnel';
        List<Transporter_Price__c> transporters = TransporterSelector.selectTransportersForQuickDelivery(clientCountry,clientType);
        
        return transporters.isEmpty() ? null : transporters[0];

}
 // Livraison la moins chère (par prix)
 @AuraEnabled(cacheable=true)
 public static Transporter_Price__c cheapDelivery(Id clientId) {
    Account client=AccountSelector.getAccountById( clientId);

    String clientCountry = client.BillingCountry;
    String clientType = OrderService.ifParticulier(client) ? 'Particulier' : 'Professionnel';
    List<Transporter_Price__c> transporters = TransporterSelector.selectTransportersForCheapDelivery(clientCountry,clientType);
    
    return transporters.isEmpty() ? null : transporters[0];
 }
 @AuraEnabled
 public static List<Transporter_Price__c> changeTransporter(Id clientId){
    Account client=AccountSelector.getAccountById( clientId);

    String clientCountry = client.BillingCountry;
    String clientType = OrderService.ifParticulier(client) ? 'Particulier' : 'Professionnel';
    List<Transporter_Price__c> transporters =TransporterSelector.selectAllTransporters(clientCountry,clientType);
    return transporters.isEmpty() ? null : transporters;
    }
 }
