@isTest
public class partyPageTest {
	
    @isTest
    static void testParties() {
            
        User uu = TestUtil.CreateTestUser();
        
        System.runAs(uu) {
        
            PageReference testPage = Page.partyPage;
            partyPageController ppc = new partyPageController();
            ptyPgExtender ppe = new ptyPgExtender(ppc);
            
            Test.setCurrentPage(testPage);
            
            //Create a new party and insert it into the database
            Party__c newParty = new Party__c(name='The Testers');
            insert newParty;
        
            //Select the party and make it the selectedParty
            ppe.selectedParty = newParty.Id;
            
            //Create a new character and insert that into the database
            Character__c Grog = new Character__c(name='Grog', race__c='Orc', class__c='Barbarian', party__c=newParty.id, user__c=uu.id);
            insert Grog;
            
            //Query for the character in the party
            ppe.getChars();
        	system.assert(ppe.getChars()[0]==Grog);
        
            
        }
    }
    
}