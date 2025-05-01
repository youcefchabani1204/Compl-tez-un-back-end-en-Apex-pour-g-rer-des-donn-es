@isTest
private class OrderServiceTest {
    
    @isTest
    static void testValidateOrder() {
        // Création de la commande de test
        Account acc = TestDataFactory.createAccount(true, 'France');
        Order ord = TestDataFactory.createOrder(acc.Id, true);
        
        // Création d'OrderItems pour remplir la commande
        TestDataFactory.createOrderItem(ord.Id,ord.Pricebook2Id, 5); // Produit Pro
        
        // Test de validation de la commande
        Test.startTest();
        Boolean isValid = OrderService.validateOrder(ord);
        Test.stopTest();
        
        // Vérification que la commande est validée pour un professionnel
        System.assertEquals(true, isValid, 'La commande d\'un professionnel avec 5 produits doit être valide');
    }
}