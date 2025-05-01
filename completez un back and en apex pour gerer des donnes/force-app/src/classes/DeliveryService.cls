public with sharing class DeliveryService {
    public static void createDelivery(List<Order> orders) {
        Set<Id> accountIds = new Set<Id>();

        // Boucle sur la liste passée en paramètre
        for (Order ord : orders) {
            if (ord.AccountId != null) {
                accountIds.add(ord.AccountId);
            }
        }

        // Tu as oublié de récupérer les comptes (important pour avoir les noms)
        Map<Id, Account> accountMap =  DeliverySelector.accountMap(accountIds);

        List<Delivery__c> deliveries = new List<Delivery__c>();

        for (Order ord : orders) {
            String accountName = accountMap.containsKey(ord.AccountId)
                ? accountMap.get(ord.AccountId).Name
                : 'Client inconnu';

            deliveries.add(new Delivery__c(
                Name = 'Livraison pour ' + accountName,
                Order__c = ord.Id,
                Status__c='en cours'


            ));
        }

        insert deliveries;
    }
    @AuraEnabled
  public static void  selectTransporterToUpdateDelivery(Id orderId, Id transporterId, Id transporterPriceId){
    
    Order ord = DeliverySelector.getOrderToUpdateDelivery(orderId);
    Delivery__c delivery =   DeliverySelector.getDeliveryByOrderId(ord);
    delivery.TransporterDelivery__c = transporterId;
        delivery.Transporter_Price__c = transporterPriceId;
        delivery.Status__c='effectuées';
        update delivery;
    
    

  
   }
}