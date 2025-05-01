public with sharing class TransporterSelector {
     public static    List<Transporter_Price__c> selectTransportersForQuickDelivery(String clientCountry,String clientType){
          return  [
                SELECT Transporter__c,Transporter__r.Name, delay__c, Price__c, country__c
                FROM Transporter_Price__c
                WHERE country__c = :clientCountry
                AND Transporter__r.TypeClient__c LIKE :('%' + clientType + '%')
                ORDER BY Delay__c ASC
                LIMIT 1
                
            ];
        } 
      public static   List<Transporter_Price__c> selectTransportersForCheapDelivery(String clientCountry,String clientType){
            return  [
                  SELECT Transporter__c,Transporter__r.Name, delay__c, Price__c, country__c
                  FROM Transporter_Price__c
                  WHERE country__c = :clientCountry
                  AND Transporter__r.TypeClient__c LIKE :('%' + clientType + '%')
                  ORDER BY Price__c ASC
                  LIMIT 1
                  
              ];
          } 
          public static   List<Transporter_Price__c> selectAllTransporters(String clientCountry,String clientType){
            return  [
                  SELECT Transporter__c,Transporter__r.Name, delay__c, Price__c, country__c
                  FROM Transporter_Price__c
                  WHERE country__c = :clientCountry
                  AND Transporter__r.TypeClient__c LIKE :('%' + clientType + '%')
                  
                  
                  
              ];
          } 
         
       
}

  
   

