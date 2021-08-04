trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on trigger.operationtype {
        when BEFORE_INSERT {
			//ContactTriggerHandler.HandleConverted(trigger.new);
        } when BEFORE_UPDATE {
            
        } when BEFORE_DELETE {
            
        } when AFTER_INSERT{
            
        } when AFTER_UPDATE {
            
        } when AFTER_DELETE {
            
        } when AFTER_UNDELETE {
            
        }
    }
}