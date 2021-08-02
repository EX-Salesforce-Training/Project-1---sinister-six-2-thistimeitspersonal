@isTest
public class TestPlayerControllerClass {
    
    @isTest static void TestPlayerMethod(){
        User uu = CreateTestUser();
        //run with current user
        System.runAs(uu){
            System.debug(uu);
            //create test player page and contrller
        	PageReference testPage = Page.Player; 
        	Test.setCurrentPage(testPage);
        	testPage.getParameters().put('ID', '' + String.valueOf(uu.Id));
        
        	ApexPages.StandardController sc = new  ApexPages.StandardController(uu);     
        	PlayerController ext = new PlayerController(sc);
        	//test that current user is active
        	System.debug('extuser: ' + ext.currentUser);
        	System.debug('extgetchars: ' + ext.getChars());
            
            System.debug('uu.Usernane:' + uu.Id);
            System.debug('currentuser: ' + ext.currentUser.Id);
        	System.assertEquals(uu.Id, ext.currentUser.Id);
            
            //-----test create new character is working
            PageReference f = ext.GoToCharacterKitPage();
            PageReference exCharPage = Page.CharacterCreationKit;
            exCharPage.getParameters().put('userId', '' + String.valueOf(uu.Id));
            //exCharPage.getParameters().put('userName', '' + (String.valueOf(uu.FirstName) + '+' + String.valueOf(uu.LastName)));
            System.assertEquals(exCharPage.getParameters().get('userId'), f.getParameters().get('userId'));
            
            //-------test edit character is working
            Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            insert testChar;
            
            ext.charParam = String.valueOf(testChar.Id);
            PageReference checkEditButtonClick = ext.CharacterTableEditClick();
            PageReference editCharExpected = Page.CharacterCreationKit;
            editCharExpected.getParameters().put('userId', '' + String.valueOf(uu.Id));
            editCharExpected.getParameters().put('ID', + testChar.Id);
            System.assertEquals(editCharExpected.getParameters().get('ID'), checkEditButtonClick.getParameters().get('ID'));
            
            //-----test save user info is working
            System.debug('test save useruu: ' + uu);
            System.debug('test save currentUser: ' + ext.currentUser);
            //ext.currentUser.Username__c = 'testuser1';
            ext.save();
            //update uu;
            User ux = [SELECT Id, Username FROM User WHERE Id=:userinfo.getuserId()];
            System.debug('test aftersave userux: ' + ux);
            System.debug('test aftersave currentUser: ' + ext.currentUser);
            System.assertEquals(uu.Id, ux.Id);
        }
    }
    
    private static User CreateTestUser(){
        UserRole obj=new UserRole(Name= 'ABC'); 
		insert obj; 

		Profile pf= [Select Id from profile where Name='System Administrator']; 

		String orgId=UserInfo.getOrganizationId(); 
		String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');

		Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
		String uniqueName=orgId+dateString+RandomId; 

		User uu=new User(firstname = 'ABC', 
		lastName = 'XYZ',
		email = uniqueName + '@test' + orgId + '.org', 
		Username = uniqueName + '@test' + orgId + '.org',
        //Username__c ='testunique_username1',
		EmailEncodingKey = 'ISO-8859-1', 
		Alias = uniqueName.substring(18, 23), 
		TimeZoneSidKey = 'America/Los_Angeles', 
		LocaleSidKey = 'en_US', 
		LanguageLocaleKey = 'en_US', 
		ProfileId = pf.Id, 
		UserRoleId = obj.Id);
        insert uu;
        return uu;
    }

}