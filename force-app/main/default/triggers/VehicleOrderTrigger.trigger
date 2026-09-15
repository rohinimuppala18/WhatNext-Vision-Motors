trigger VehicleOrderTrigger on Vehicle_Order__c (before insert, before update) {
    VehicleOrderTriggerHandler.validateStock(Trigger.new);
}