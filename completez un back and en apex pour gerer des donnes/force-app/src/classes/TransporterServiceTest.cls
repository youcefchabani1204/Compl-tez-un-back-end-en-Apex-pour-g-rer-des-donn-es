@isTest
private class TransporterServiceTest {
    
    @isTest
    static void testQuickDelivery() {
        Account acc = TestDataFactory.createAccount(true, 'France');
        Transporter_Price__c expected = TestDataFactory.createTransporterPrice('France', 'Professionnel', 1, 30);
        
        Test.startTest();
        Transporter_Price__c result = TransporterService.quickDelivery(acc.Id);
        Test.stopTest();
        
        System.assertNotEquals(null, result, 'Un transporteur rapide doit être retourné');
        System.assertEquals(expected.Id, result.Id, 'Le transporteur rapide doit correspondre aux données');
    }

    @isTest
    static void testCheapDelivery() {
        Account acc = TestDataFactory.createAccount(true, 'France');
        
        // Plus cher
        TestDataFactory.createTransporterPrice('France', 'Professionnel', 3, 60);
        // Moins cher
        Transporter_Price__c cheapest = TestDataFactory.createTransporterPrice('France', 'Professionnel', 4, 20);

        Test.startTest();
        Transporter_Price__c result = TransporterService.cheapDelivery(acc.Id);
        Test.stopTest();
        
        System.assertNotEquals(null, result, 'Un transporteur économique doit être retourné');
        System.assertEquals(cheapest.Id, result.Id, 'Le transporteur le moins cher doit être sélectionné');
    }

    @isTest
    static void testChangeTransporter() {
        Account acc = TestDataFactory.createAccount(true, 'France');
        
        Transporter_Price__c t1 = TestDataFactory.createTransporterPrice('France', 'Professionnel', 3, 50);
        Transporter_Price__c t2 = TestDataFactory.createTransporterPrice('France', 'Professionnel', 2, 40);
        
        Test.startTest();
        List<Transporter_Price__c> results = TransporterService.changeTransporter(acc.Id);
        Test.stopTest();
        
        System.assertEquals(2, results.size(), 'Tous les transporteurs doivent être retournés');
        Set<Id> expectedIds = new Set<Id>{ t1.Id, t2.Id };
        for (Transporter_Price__c t : results) {
            System.assert(expectedIds.contains(t.Id), 'Le transporteur retourné doit exister dans les données de test');
        }
    }
}