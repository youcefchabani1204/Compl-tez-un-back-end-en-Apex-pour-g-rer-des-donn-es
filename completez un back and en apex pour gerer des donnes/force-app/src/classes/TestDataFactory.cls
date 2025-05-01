@isTest
public class TestDataFactory {

    public static Account createAccount(Boolean isPro, String country) {
        Account acc = new Account();
        acc.Name = isPro ? 'Pro Client' : 'Particulier Client';
        acc.BillingCountry = country;
        insert acc;
        return acc;
    }

    
        public static Order createOrder(Id accountId, Boolean isValid) {
           // Vérifier s'il existe déjà un Pricebook standard
Pricebook2 customPb = new Pricebook2(Name = 'Test Pricebook', IsActive = true);
insert customPb;
        
            Order ord = new Order(
                AccountId = accountId,
                Status = 'Draft',
                EffectiveDate = Date.today(),
                Pricebook2Id = customPb.Id
            );
            insert ord;
        
            return ord;
        }
    

    public static OrderItem createOrderItem(Id orderId,Id pricebookId, Decimal quantity) {
        Product2 prod = new Product2(Name='Test Product', IsActive=true);
        insert prod;
        PricebookEntry standardPbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = prod.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert standardPbe;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = prod.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert pbe;

        OrderItem oi = new OrderItem();
        oi.OrderId = orderId;
        oi.Quantity = quantity;
        oi.PricebookEntryId = pbe.Id;
        oi.UnitPrice = 100;
        insert oi;
        return oi;
    }


        
        
       
    
    public static Transporter__c createTransporter(String typeClient){
            Transporter__c transporter = new Transporter__c(
            Name = 'Transporter Test',
            TypeClient__c = typeClient
        );
        return transporter;
    }

    public static Transporter_Price__c createTransporterPrice(String country, String typeClient, Decimal delay, Decimal price) {
    

        Transporter_Price__c transporterPrice = new Transporter_Price__c();
        Transporter__c transporter = createTransporter(typeClient);
        insert transporter;
        transporterPrice.Transporter__c = transporter.Id;
        transporterPrice.Delay__c = delay;
        transporterPrice.Price__c = price;
        transporterPrice.Country__c = country;
        insert transporterPrice;
        return transporterPrice;
    }
}