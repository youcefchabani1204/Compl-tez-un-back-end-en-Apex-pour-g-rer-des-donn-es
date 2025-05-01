public with sharing class OrderService {
    

    // Méthode pour valider les commandes
   @AuraEnabled
     public static boolean validateOrder(Order orderToValidate) {
        List<OrderItem> orderItems=OrderSelector.selectQuantityFromOrderItems(orderToValidate);
        Decimal totalQuantity = 0;
        for (OrderItem item : orderItems) {
             totalQuantity += item.Quantity;
        }
        Account relatedAccount = AccountSelector.getAccountById(orderToValidate.AccountId);
        
        Boolean isPro = !ifParticulier(relatedAccount);


        if (isPro && totalQuantity >= 5) {
            return true; // Professionnel avec 5 produits ou plus
        } else if (!isPro && totalQuantity >= 3) {
            return true; // Particulier avec 3 produits ou plus
        } else {
           
            return false; // Sinon, pas valide
        }
    }


       public static void handleValidation(List<Order> orders) {
        List<String> countryClient=new List<String>{'Belgium','France','Switzerland','Luxembourg'};

        for (Order o : orders) {
            if (o.AccountId == null) continue;

            Account client = AccountSelector.getAccountById(o.AccountId);
            if(!countryClient.contains(client.BillingCountry)){
                 o.addError('Commande impossible : aucun transporter ne livre dans votre pays  ');

            }

           else  if (validateOrder(o)) {
                o.OrderValidated__c = true;

            }  
            else {
                o.OrderValidated__c = false;
               
              //  o.addError('Commande invalide : un particulier doit commander au moins 3 produits, un professionnel au moins 5.');
            }
        }
    }


        // TODO: Implémenter la logique de validation de la commande
    
    public static Boolean ifParticulier(Account account) {
        return account.AnnualRevenue < 100000;
    }
     
    
   
       
         
}






