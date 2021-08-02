/*
 * Author: Jacob Schwartz
 * Project1: DnD
 * Date: 8/1/2021
 * Description: Custom controller extendion for Player page.
 * Extends User standard controller to display user information.
 * 
 * Uses list of characters and a getter to bind a list of characters that
 * are associated with the current user.
 * 
 * Overrwrites save function to save user information.
 * 
 * Has actions that link to CharacterCreationKit page when a user wishes to 
 * update/create a character.
 *  
 */

public class PlayerController {
    
    public List<Character__c> chars {get;set;}
    public String charParam {get;set;}
    public List<User> uList {get;set;}
    public user currentUser {get;set;}
    public PlayerController(ApexPages.StandardController sc){
        uList = [SELECT Name, Id FROM User];
        currentUser = new User();
        //this.currentUser = (User) sc.getRecord();
        //chars = [SELECT Name FROM Character__c WHERE OwnerID =:currentUser.Id ];
        currentUser = [SELECT Id, Name, Username, Email FROM User WHERE Id=:userinfo.getuserId()];
        chars = [SELECT Name FROM Character__c WHERE OwnerID =:userinfo.getuserId() ];
        System.debug('chars: ' + chars);
        //System.debug('user: ' + currentUser.First_Name__c);
        System.debug('usdreidL : ' + currentUser.Email);
    }
    
    public List<Character__c> getChars(){
        return chars;
    }
    
    public PageReference GoToCharacterKitPage(){
        // called when Create new Character is clicked
        // passes false paramater to indicate new character
        return CharacterKitClickHelper(false);
    }
    
    public PageReference CharacterTableEditClick(){
        // called when Edit character is clicked
        // passes true to indicate edit character and to pass
        // character id to CharacterCreationKit page
        //System.debug('EditClick: ' + charParam);
        return CharacterKitClickHelper(true);
    }
    
    public PageReference CharacterKitClickHelper(boolean AddIdToParams){
        //Called from both functions above. Links to CharacterCreationKit
        //page, passing in necessary params including character id when
        //applicable
        PageReference pr = Page.CharacterCreationKit;
        pr.getParameters().put('userId', '' + currentUser.Id);
        //pr.getParameters().put('userName', '' + currentUser.LastName);
        if(AddIdToParams)
            pr.getParameters().put('ID', '' + charParam);
        pr.setRedirect(true);
        return pr;
    }
    
    public PageReference save(){
        //currentUser.First_Name__c = 'stringFirstname';
        update currentUser;
        return null;
    }

}