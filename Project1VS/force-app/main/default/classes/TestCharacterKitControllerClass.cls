//////////////////////////////////////////////////
/*
 * Author: Jacob Schwartz
 * Date: 8/1/2021
 * Description: Class contains tests for CharacterKitControllerClass
 * Contains four test functions.
 * 
 * TestCreateKitPage() and TestEditKitPage() test opening the page from either
 * the create or edit buttons from the player page. Tests what is displayed
 * on the page. 
 * 
 * TestOtherFunction() tests various helper functions in class.
 * 
 * TestError() tests that required fields error pops up if user tries to save without
 * filling in required fields.
 */
//////////////////////////////////////////////////

@isTest
public class TestCharacterKitControllerClass {
    
    @isTest static void TestCreateKitPage(){
        User uu = TestUtil.CreateTestUser();
        
        System.runAs(uu){
            
            PageReference testKitPage = Page.CharacterCreationKit;
            Test.setCurrentPage(testKitPage);
            
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
        User uu = TestUtil.CreateTestUser();
        System.runAs(uu){
            PageReference testKitPage = Page.CharacterCreationKit;
            Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            insert testChar;
            
            testKitPage.getParameters().put('ID', '' + String.valueOf(testChar.Id));
            Test.setCurrentPage(testKitPage);
            
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	CharacterKitController ext = new CharacterKitController(sc);
            
            ext.wisdomDefault = '10';
            ext.save();
            
            List<Character__c> c = [SELECT Name, Wisdom__c FROM Character__c];
            System.assertEquals(10, c[0].Wisdom__c);
        }
    }
    
    @isTest static void TestOtherFunctions(){
        User uu = TestUtil.CreateTestUser();
        System.runAs(uu){
            PageReference testKitPage = Page.CharacterCreationKit;
            Character__c testChar = new Character__c(Name = 'Char1', Race__c='Elf', Class__c='Bard');
            insert testChar;
            
            testKitPage.getParameters().put('ID', '' + String.valueOf(testChar.Id));
            Test.setCurrentPage(testKitPage);
            
            ApexPages.StandardController sc = new  ApexPages.StandardController(uu);
        	CharacterKitController ext = new CharacterKitController(sc);
            
            List<SelectOption> race = ext.GetRaceOptions();
            System.assertEquals(10, race.size());
            
            List<SelectOption> classList = ext.GetClassOptions();
            System.assertEquals(13, classList.size());
            
            List<SelectOption> s1 = ext.GetStrengthOptions();
            System.assertEquals(21, s1.size());
            
            List<SelectOption> s2 = ext.GetDexterityOptions();
            System.assertEquals(21, s2.size());
            
            List<SelectOption> s3 = ext.GetConstitutionOptions();
            System.assertEquals(21, s3.size());
            
            List<SelectOption> s4 = ext.GetWisdomOptions();
            System.assertEquals(21, s4.size());
            
            List<SelectOption> s5 = ext.GetIntelligenceOptions();
            System.assertEquals(21, s5.size());
            
            List<SelectOption> s6 = ext.GetCharismaOptions();
            System.assertEquals(21, s6.size());
        }
    }
    
    @isTest static void TestError(){
        User uu = TestUtil.CreateTestUser();
        
        System.runAs(uu){
            
            PageReference testKitPage = Page.CharacterCreationKit;
            Test.setCurrentPage(testKitPage);
            
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

}