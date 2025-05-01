@isTest
private class AccountSelectorTest {
    
    @isTest
    static void testGetAccountById() {
        Account acc = TestDataFactory.createAccount(true, 'France');
        
        Account result = AccountSelector.getAccountById(acc.Id);
        
        System.assertNotEquals(null, result, 'Le compte doit exister');
        System.assertEquals(acc.Name, result.Name, 'Le nom du compte doit correspondre');
    }
}