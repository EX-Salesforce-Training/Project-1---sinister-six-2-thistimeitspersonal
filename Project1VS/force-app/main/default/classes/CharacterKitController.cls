/////////////////////////////////////////
//
// Character creation kit
// 
// Purpose: allowing the players to create characters for their DnD campaign
// 
// Initial designer: Richard 'Jerry' Laughter
// Creation Date: 7/29/2021
// Latest Edit: 8/3/2021
// 
// Constructor set wheter it is a new character or editing an existing one,
// taking parameters from Player page.
// 
// Many character attributes are Decimal value in org, and vf page has them displaying
// as strings with selectoption. Defaults have been set in the constructor for the 
// edit character that displays a characters saved attributes. On save, defaults are
// converted from strings to integers to be uploaded to org. 
// 
//
/////////////////////////////////////////


public class CharacterKitController {
    
    public Character__c character {get;set;}    
    public String nameDefault {get;set;}
    public String strengthDefault {get;set;}
    public String constitutionDefault {get;set;}
    public String dexterityDefault {get;set;}
    public String wisdomDefault {get;set;}
    public String intelligenceDefault {get;set;}
    public String charismaDefault {get;set;}
    private boolean isNewCharacter = true;
    
    public CharacterKitController(ApexPages.StandardController sc){
		//obtains the ID of the currently selected character if applicable
		//returns character attributes
        String idStr = ApexPages.currentPage().getParameters().get('ID');
        System.debug('Idstr: ' + idStr);
        System.debug('contolreexted: ' + sc.getId());
        if(idStr != null){
            Id idStrId = Id.valueOf(idStr);
            character = [SELECT Name, Race__c, Class__c, Strength__c, Constitution__c,
                         Dexterity__c, Wisdom__c, Intelligence__c, Charisma__c, General_Notes__c
                         FROM Character__c WHERE Id =:idStrId];
            nameDefault = character.Name;
            strengthDefault = String.valueOf(character.Strength__c);
            constitutionDefault = String.valueOf(character.Constitution__c);
            dexterityDefault = String.valueOf(character.Dexterity__c);
            wisdomDefault = String.valueOf(character.Wisdom__c);
            intelligenceDefault = String.valueOf(character.Intelligence__c);
            charismaDefault = String.valueOf(character.Charisma__c);
            isNewCharacter = false;
        }
        else
            //if no id is selected returns new character
            character = new Character__c();
    }
    
    public PageReference save(){
        try{
            //checks to make sure that all inputs are valid before attempting to submit them to the database
        	character.Strength__c = CheckValidInput(strengthDefault);
        	character.Constitution__c = CheckValidInput(constitutionDefault);
        	character.Dexterity__c = CheckValidInput(dexterityDefault);
        	character.Wisdom__c = CheckValidInput(wisdomDefault);
        	character.Intelligence__c = CheckValidInput(intelligenceDefault);
			character.Charisma__c = CheckValidInput(charismaDefault);
 
            //inserts character if new, updates it if old
            if(isNewCharacter)
            	insert character;
        	else
        		update character;
			//redirects to the player page
            PageReference pr = Page.Player;
        	pr.setRedirect(true);
        	return pr;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Fill Out REQUIRED Fields!'));
        }
        
        return null;
    }
    //checks if input is number
    public Decimal CheckValidInput(String i){
        try{
            return Decimal.valueOf(i);
        }catch(Exception e){
            return 0;
        }
    }

    //obtains list of DnD 5e races from the resting dragon controller using the rest API
    ////returns it as a list of select options for a dropdown list
    public List<SelectOption> GetRaceOptions(){
        List<String> raceList = restingDragonController.indexList('races/');

        List<SelectOption> raceOptions = new List<SelectOption>();

        for (String race: raceList){
            raceOptions.add(new SelectOption(race, race));
        }

        return raceOptions;
    }
    
    //obtains list of DnD 5e classes from the resting dragon controller using the rest API
    ////returns it as a list of select options for a dropdown list
    public List<SelectOption> GetClassOptions(){
        List<String> classList = restingDragonController.indexList('classes/');

        List<SelectOption> classOptions = new List<SelectOption>();

        for (String curClass: classList){
            classOptions.add(new SelectOption(curClass, curClass));
        }

        return classOptions;
    }
    
    //returns a list of integers from the setNumberList method for dropdown lists
    public List<SelectOption> GetAttributeOptions(){
        List<SelectOption> strengthOptions = new List<SelectOption>();
        setNumberList(strengthOptions);
        return strengthOptions;
        
    }
    
    private void setNumberList(List<SelectOption> tempList){
        tempList.add(new SelectOption('','-None-'));
        for(Integer i = 1; i <= 20; i++){
            tempList.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
    }

}