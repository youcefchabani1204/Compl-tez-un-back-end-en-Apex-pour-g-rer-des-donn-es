@isTest
private class DeliverySelectorTest {
    
    @isTest
    static void testGetOrderByOrderId() {

        Account acc = TestDataFactory.createAccount(false,'France');
        Order ord = TestDataFactory.createOrder(acc.Id, false);
        
        
        Delivery__c result = DeliverySelector.getDeliveryByOrderId(ord);
        
        
        // Vérification des résultats
        System.assertNotEquals(null, result, 'La livraison doit exister');
        System.assertEquals(ord.Id, result.Order__c, 'Les IDs des livraisons doivent correspondre');
    }
    @isTest
    static void testAccountMap() {
        // Création de comptes de test
        Account acc1 = TestDataFactory.createAccount(false, 'France');
        Account acc2 = TestDataFactory.createAccount(true, 'France');
    
        Set<Id> accountIds = new Set<Id>{acc1.Id, acc2.Id};
    
        Map<Id, Account> resultMap = DeliverySelector.accountMap(accountIds);
    
        System.assertEquals(2, resultMap.size(), 'La map doit contenir 2 comptes');
        System.assert(resultMap.containsKey(acc1.Id), 'Le compte 1 doit être dans la map');
        System.assertEquals(acc1.Name, resultMap.get(acc1.Id).Name, 'Le nom du compte 1 doit correspondre');
    }
    @isTest
static void testGetOrderToUpdateDelivery() {
    Account acc = TestDataFactory.createAccount(false, 'France');
    Order ord = TestDataFactory.createOrder(acc.Id, false);

    Order result = DeliverySelector.getOrderToUpdateDelivery(ord.Id);

    System.assertNotEquals(null, result, 'La commande doit être trouvée');
    System.assertEquals(ord.Id, result.Id, 'L\'ID de la commande doit correspondre');
}
}