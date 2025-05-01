public with sharing class OrderSelector {
    public static List<OrderItem> selectQuantityFromOrderItems(Order orderToValidate) {
      return  [SELECT Quantity FROM OrderItem WHERE OrderId = :orderToValidate.Id];

    }
    
}