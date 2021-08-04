public class regionTriggerHandler {
    
    public static void checkStates(List<Region__c> regions) {
        String states = '';
        String regionstate = '';
        List<Id> realmIDs = new List<Id>();
        List<Realm__c> realms = new List<Realm__c>();
        for (Region__c reg : regions) {
            regionstate = reg.states__c;
            realmIDs.add(reg.Realm__c);
        }
        realms = [SELECT name, includes_states__c, id FROM realm__c WHERE id IN : realmIDs];
        for (Region__c reg : regions) {
            for (Realm__c relm : realms) {
                if (reg.realm__c == relm.id) {
                    states = relm.includes_states__c;
                    regionstate = reg.States__c;
                    if (!states.contains(regionstate)) {
                        reg.addError('This region must be in a state within the jurisdiction of this realm.');
                    }
                }
            }
        }
    }
    
}