@isTest
private class OrderSelectorTest {
    
    @isTest
    static void testSelectQuantityFromOrderItems() {
        // Création de la commande et des items
        Account acc = TestDataFactory.createAccount(true, 'France');
        Order ord = TestDataFactory.createOrder(acc.Id, true);
        OrderItem oi = TestDataFactory.createOrderItem(ord.Id,ord.Pricebook2Id, 5);
        
        // Appel de la méthode
        List<OrderItem> result = OrderSelector.selectQuantityFromOrderItems(ord);
        
        // Vérification des résultats
        System.assertEquals(1, result.size(), 'Il devrait y avoir un item dans la commande');
        System.assertEquals(5, result[0].Quantity, 'La quantité de l\'article doit être correcte');
    }
}