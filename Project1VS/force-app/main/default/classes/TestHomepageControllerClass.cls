@isTest

public class TestHomepageControllerClass {
    @isTest static void HomeTest(){
        User uu = TestUtil.CreateTestUser();
        System.runAs(uu){
            PageReference testKitPage = Page.Homepage;
        	Test.setCurrentPage(testKitPage);
            
        	ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	HomepageController ext = new HomepageController(sc);
            
            System.assertEquals('No Current Campaign!', ext.Description);
        }
    }
    
    @isTest static void ActiveCampaignTest(){
        
        User uu = TestUtil.CreateTestUser();
        System.runAs(uu){
            Campaign camp1 = new Campaign(Name = 'Test Campaign 1', IsActive = True,
                                         Description = 'des');
            insert camp1;
            
            PageReference testKitPage = Page.Homepage;
        	Test.setCurrentPage(testKitPage);
            
        	ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	HomepageController ext = new HomepageController(sc);
            
            System.assertEquals('des', ext.Description);
        }
    }
    
    @isTest static void ActiveCampaignNullDesTest(){
        
        User uu = TestUtil.CreateTestUser();
        System.runAs(uu){
            Campaign camp1 = new Campaign(Name = 'Test Campaign 1', IsActive = True);
            insert camp1;
            
            PageReference testKitPage = Page.Homepage;
        	Test.setCurrentPage(testKitPage);
            
        	ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	HomepageController ext = new HomepageController(sc);
            
            System.assertEquals('Campaign Description Unavailable!', ext.Description);
        }
    }
    
}