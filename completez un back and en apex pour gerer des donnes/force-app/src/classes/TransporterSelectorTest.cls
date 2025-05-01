@isTest
private class TransporterSelectorTest {
    
    @isTest
    static void testSelectTransportersForQuickDelivery() {
        Account acc = TestDataFactory.createAccount(true, 'France');
        Transporter_Price__c transporterPrice = TestDataFactory.createTransporterPrice('France', 'Professionnel', 2, 50);

        List<Transporter_Price__c> result = TransporterSelector.selectTransportersForQuickDelivery('France', 'Professionnel');

        System.assertNotEquals(0, result.size(), 'Il doit y avoir des transporteurs pour livraison rapide');
        System.assertEquals(transporterPrice.Id, result[0].Id, 'Transporteur attendu pour livraison rapide');
    }

    @isTest
    static void testSelectTransportersForCheapDelivery() {
        Account acc = TestDataFactory.createAccount(true, 'France');

        // Deux transporteurs pour comparer le prix
        TestDataFactory.createTransporterPrice('France', 'Professionnel', 2, 50);
        Transporter_Price__c cheapest = TestDataFactory.createTransporterPrice('France', 'Professionnel', 3, 30);

        List<Transporter_Price__c> result = TransporterSelector.selectTransportersForCheapDelivery('France', 'Professionnel');

        System.assertEquals(1, result.size(), 'Un seul transporteur doit être retourné pour le moins cher');
        System.assertEquals(cheapest.Id, result[0].Id, 'Le transporteur le moins cher doit être sélectionné');
    }

    @isTest
    static void testSelectAllTransporters() {
        Account acc = TestDataFactory.createAccount(true, 'France');

        Transporter_Price__c tp1 = TestDataFactory.createTransporterPrice('France', 'Professionnel', 2, 50);
        Transporter_Price__c tp2 = TestDataFactory.createTransporterPrice('France', 'Professionnel', 3, 30);

        List<Transporter_Price__c> result = TransporterSelector.selectAllTransporters('France', 'Professionnel');

        System.assertEquals(2, result.size(), 'Tous les transporteurs doivent être récupérés');
        Set<Id> ids = new Set<Id>{ tp1.Id, tp2.Id };
        System.assert(ids.contains(result[0].Id) && ids.contains(result[1].Id), 'Les transporteurs récupérés doivent correspondre aux données de test');
    }
}