@isTest 
private class DndCampaingTestClass {

 	@isTest static void myTest() {
        DnDCampaign__c reco = new DnDCampaign__c();
               reco.Campaign_Name__c='MyCampaign';
     		   reco.Status__c = 'In Progress';
     	insert reco;
        ApexPages.StandardController sc = new ApexPages.standardController(reco);
     	DndCampaignController controller = new DndCampaignController(sc);
    }
    
	@isTest static void PartyPageTest(){
        DndCampaignController s = new DndCampaignController();
        PageReference pg = s.GoToParty();
        system.assertEquals('/apex/partyPage', pg.getUrl());
        system.assertEquals(true, pg.getRedirect());
        system.assertEquals(new Map < String, String >(), pg.getParameters());
        system.assertEquals(new Map < String, String >(), pg.getHeaders());
    }
   

}