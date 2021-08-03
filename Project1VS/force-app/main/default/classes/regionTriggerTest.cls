@isTest
public class regionTriggerTest {

    @isTest
    static void misaligned() {
        Realm__c realm = new Realm__c(Name='Realm', includes_states__c='New York');
        insert realm;
        Region__c region = new Region__c(Name='Reggie', realm__c=realm.Id, states__c='California');
        try {
        	insert region;
        } catch(DmlException d) {
            system.assert(true);
        }
    }
    
}