public class ptyPgExtender {
    
    //Most of the controller's functionality is in here, rather than in the actual controller.
    //Because it's in an extension, it runs in user context, rather than system context.
    //This will be important when we query parties.
    public String selectedParty{get;set;}
    public String partyName{get;set;}
    
    
    
    public ptyPgExtender(partyPageController ppc) {
        selectedParty = null;
        partyName = null;
        getPartyList();
        getChars();
        getPlayas();
        getCpaign();
    }
    
    public List<Party__c> getPartyList() {
        //This looks like it will display every single party. But since we're in system context, it'll take into account
        //the user's security settings. So any user who visits here won't be able to see any parties that they don't
        //have access to.
        return [SELECT name FROM party__c];
    }
    
    // This method fires when you click on an item in the "Party" table. It should show:
    // 1. The charactesrs in the party
    // 2. The players pertaining to each character
    // 3. The campaign the party is in
    // 4. The Dungeon Master for this campaign
    // Is it time to use a wrapped class?
    public void selectParty() {
        partyName = String.valueOf([SELECT name FROM party__c WHERE id =: selectedParty LIMIT 1]);
    }
    
    public List<Character__c> getChars() {
        List<Character__c> charList = new List<Character__c>();
        
        if (selectedParty != null) {
        	charList = [SELECT name FROM character__c where user__c =: selectedParty];
        } else {
            charList = null;
        }
        
        return charList;
    }
    
    public List<Character__c> getPlayas() {
        return [SELECT user__c, name, party__c FROM character__c WHERE party__c =: selectedParty ];
       
    }
    
    public List<DndCampaign__c> getCpaign() {
        return [SELECT name, dungeon_master__c FROM DndCampaign__c where party__c =: selectedParty];
    }
    
    
}