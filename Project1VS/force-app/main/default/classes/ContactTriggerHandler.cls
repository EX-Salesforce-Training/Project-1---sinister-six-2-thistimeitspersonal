public class ContactTriggerHandler {
    Public static void HandleConverted(List<Contact> newContacts){

        List<id> regionIds = new List<id>();
        
        for (Contact c: newContacts){
            if (c.region__c != null){
                regionIds.add(c.Region__c);
            }
        }
        
        

    }
}