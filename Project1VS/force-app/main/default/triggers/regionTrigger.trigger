trigger regionTrigger on Region__c (before insert, before update) {
    switch on trigger.operationtype {
        when BEFORE_INSERT {
            regionTriggerHandler.checkStates(trigger.new);
        }
        when BEFORE_UPDATE {
            regionTriggerHandler.checkStates(trigger.new);
        }
    }
}