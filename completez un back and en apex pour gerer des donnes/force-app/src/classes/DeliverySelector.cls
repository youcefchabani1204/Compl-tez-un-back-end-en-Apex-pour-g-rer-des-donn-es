public with sharing class DeliverySelector {
    public static Map<Id, Account> accountMap(Set<Id> accountIds) {
        return new Map<Id, Account>(
            [SELECT Id, Name FROM Account WHERE Id IN :accountIds]
        );
    }
   
    public static Order getOrderToUpdateDelivery(Id orderId){
        return [SELECT Id,	Delivery_Order__c FROM ORDER WHERE Id = :orderId LIMIT 1];
    }
   
    public static Delivery__c  getDeliveryByOrderId(Order ord){

       return [SELECT Id, Name,TransporterDelivery__c, Transporter_Price__c ,Order__c
                FROM Delivery__c 
                WHERE Order__c = :ord.Id 
                LIMIT 1];
    }
}