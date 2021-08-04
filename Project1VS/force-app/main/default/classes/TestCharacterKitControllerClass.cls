@isTest
public class TestCharacterKitControllerClass {
    
    @isTest static void TestCreateKitPage(){
        User uu = CreateTestUser();
        
        System.runAs(uu){

			//creates a new page reference to the character creation kit
			//
            PageReference testKitPage = Page.CharacterCreationKit;
            Test.setCurrentPage(testKitPage);
            
   			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
                       
        	CharacterKitController ext = new CharacterKitController(sc);
            
            //-----Test Create Character Page no parameters.
            //Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            ext.character.Name = 'char1';
            ext.character.Race__c = 'Elf';
            ext.character.Class__c = 'Bard';
            ext.save();
            List<Character__c> charList = [SELECT Name FROM Character__c];
            System.debug('allcharList: ' + charList);
            System.assertEquals('char1', charList[0].Name);
        }
        
    }
    
    @isTest static void TestEditKitPage(){
        User uu = CreateTestUser();
        System.runAs(uu){
            PageReference testKitPage = Page.CharacterCreationKit;
            Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            insert testChar;
            
            testKitPage.getParameters().put('ID', '' + String.valueOf(testChar.Id));
            Test.setCurrentPage(testKitPage);
   			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
            
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	CharacterKitController ext = new CharacterKitController(sc);
            
            ext.wisdomDefault = '10';
            ext.save();
            
            List<Character__c> c = [SELECT Name, Wisdom__c FROM Character__c];
            System.assertEquals(10, c[0].Wisdom__c);
        }
    }
    
    @isTest static void TestOtherFunctions(){
        User uu = CreateTestUser();
        System.runAs(uu){
            PageReference testKitPage = Page.CharacterCreationKit;
            Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            insert testChar;
            
            testKitPage.getParameters().put('ID', '' + String.valueOf(testChar.Id));
            Test.setCurrentPage(testKitPage);
   			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
            
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	CharacterKitController ext = new CharacterKitController(sc);

            List<SelectOption> race = ext.GetRaceOptions();            
            List<SelectOption> classList = ext.GetClassOptions();
            List<SelectOption> s1 = ext.GetAttributeOptions();
        }
    }
    
    @isTest static void TestError(){
        User uu = CreateTestUser();
        
        System.runAs(uu){
            
            PageReference testKitPage = Page.CharacterCreationKit;
            Test.setCurrentPage(testKitPage);
   			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
            
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	CharacterKitController ext = new CharacterKitController(sc);
            
            //-----Test Create Character Page no parameters.
            //Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            ext.character.Name = 'char1';
            ext.character.Race__c = 'Elf';
            //ext.character.Class__c = 'Bard';
            PageReference pr = ext.save();
            
            System.assertEquals(null, pr);
        }
        
    }

   	@isTest
	static void TestGoodDragonPage(){
		//tests the 'resting dragon' example page positively using a mock callout
        User uu = TestUtil.CreateTestUser();
		System.runAs(uu){
            PageReference drag = Page.restingDragon;
            Test.setCurrentPage(drag);
			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
			restingDragonController dragCon = new restingDragonController();
		}
	}
    
	@isTest
	static void TestFailDragonPage(){
		//tests the 'resting dragon' example page negativly using a mock callout
        User uu = TestUtil.CreateTestUser();
		System.runAs(uu){
            PageReference drag = Page.restingDragon;
            Test.setCurrentPage(drag);
			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMockFail());
			restingDragonController dragCon = new restingDragonController();
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