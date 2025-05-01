@isTest
private class DeliveryServiceTest {
    
    @isTest
    static void testCreateDelivery() {
        // Création de la commande
        Account acc = TestDataFactory.createAccount(true, 'France');
        Order ord = TestDataFactory.createOrder(acc.Id, true);
        
     
        
        // Vérification que la livraison a bien été créée
        List<Delivery__c> deliveries = [SELECT Id, Order__c FROM Delivery__c WHERE Order__c = :ord.Id];
        System.assertEquals(1, deliveries.size(), 'Une livraison doit être créée pour cette commande');
    }
    @isTest
    static void testSelectTransporterToUpdateDelivery() {
        // Création des données nécessaires pour le test
        Account acc = TestDataFactory.createAccount(true, 'France');
        Order ord = TestDataFactory.createOrder(acc.Id, true);
        

        
        // Création d'un transporteur et d'un prix de transporteur
        Transporter_Price__c transporterPrice = TestDataFactory.createTransporterPrice('France', 'Professionnel', 1, 30);
        Transporter__c transporter = TestDataFactory.createTransporter('Transporteur rapide');
        
        // Test de la mise à jour de la livraison
        Test.startTest();
        DeliveryService.selectTransporterToUpdateDelivery(ord.Id, transporter.Id, transporterPrice.Id);
        Test.stopTest();
        
        // Récupération de la livraison après mise à jour
        Delivery__c updatedDelivery = [SELECT TransporterDelivery__c, Transporter_Price__c, Status__c FROM Delivery__c WHERE Order__c = :ord.Id];
        
        // Vérification des résultats
        System.assertEquals(transporter.Id, updatedDelivery.TransporterDelivery__c, 'Le transporteur de la livraison doit être mis à jour');
        System.assertEquals(transporterPrice.Id, updatedDelivery.Transporter_Price__c, 'Le prix du transporteur de la livraison doit être mis à jour');
        System.assertEquals('effectuées', updatedDelivery.Status__c, 'Le statut de la livraison doit être mis à jour à "effectuées"');
   }
}