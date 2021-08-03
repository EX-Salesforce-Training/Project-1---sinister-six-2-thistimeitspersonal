public class regionTriggerHandler {
    
    public static void checkStates(List<Region__c> regions) {
        String states = null;
        String regionstate = null;
        for (Region__c reg : regions) {
            regionstate = reg.states__c;
            states = reg.Realm__r.includes_states__c;
            if (!states.contains(regionstate)) {
                reg.addError('This region must be in a state within the jurisdiction of this realm.');
            }
        }
        
    }
    
}