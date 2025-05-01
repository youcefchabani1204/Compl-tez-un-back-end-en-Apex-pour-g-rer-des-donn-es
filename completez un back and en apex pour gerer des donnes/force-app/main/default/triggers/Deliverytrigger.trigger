trigger Deliverytrigger on Order(after insert) {
    DeliveryService.createDelivery( Trigger.new);

   
}