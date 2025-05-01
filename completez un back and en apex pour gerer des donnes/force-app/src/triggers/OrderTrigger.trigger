trigger OrderTrigger on Order (before insert,before update) {
    OrderService.handleValidation(Trigger.new);

}