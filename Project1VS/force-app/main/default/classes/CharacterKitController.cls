public class CharacterKitController {
    
    public Character__c character {get;set;}
    public CharacterKitController(ApexPages.StandardController sc){
        
    }
    
    public List<SelectOption> GetRaceOptions(){

		List<String> classList = restingDragonController.classList(restingDragonController.makeCallout());

	    List<SelectOption> raceOptions = new List<SelectOption>();

        for(String charClass: classList){
            raceOptions.add(new SelectOption(charClass, charClass));
        }
        return raceOptions;
    }
    
    public List<SelectOption> GetClassOptions(){
        List<SelectOption> classOptions = new List<SelectOption>();
        classOptions.add(new SelectOption('','-None-'));
        classOptions.add(new SelectOption('Barbarian', 'BARBARIAN'));
        classOptions.add(new SelectOption('Bard', 'BARD'));
        classOptions.add(new SelectOption('Cleric', 'CLERIC'));
        classOptions.add(new SelectOption('Druid', 'DRUID'));
        classOptions.add(new SelectOption('Fighter', 'FIGHTER'));
        classOptions.add(new SelectOption('Monk', 'MONK'));
        classOptions.add(new SelectOption('Paladin', 'PALADIN'));
        classOptions.add(new SelectOption('Ranger', 'RANGER'));
        classOptions.add(new SelectOption('Rogue', 'ROGUE'));
        classOptions.add(new SelectOption('Sorcerer', 'SORCERER'));
        classOptions.add(new SelectOption('Warlock', 'WARLOCK'));
        classOptions.add(new SelectOption('Wizard', 'WIZARD'));
        return classOptions;
    }
    
    public List<SelectOption> GetStrengthOptions(){
        List<SelectOption> strengthOptions = new List<SelectOption>();
        setNumberList(strengthOptions);
        return strengthOptions;
        
    }
    
    public List<SelectOption> GetConstitutionOptions(){
        List<SelectOption> constitutionOptions = new List<SelectOption>();
        setNumberList(constitutionOptions);
        return constitutionOptions;
    }
    
    public List<SelectOption> GetDexterityOptions(){
        List<SelectOption> dexterityOptions = new List<SelectOption>();
        setNumberList(dexterityOptions);
        return dexterityOptions;
    }
    
    public List<SelectOption> GetWisdomOptions(){
        List<SelectOption> wisdomOptions = new List<SelectOption>();
        setNumberList(wisdomOptions);
        return wisdomOptions;
    }
    
    public List<SelectOption> GetIntelligenceOptions(){
        List<SelectOption> intelligenceOptions = new List<SelectOption>();
        setNumberList(intelligenceOptions);
        return intelligenceOptions;
    }
    
    public List<SelectOption> GetCharismaOptions(){
        List<SelectOption> charismaOptions = new List<SelectOption>();
        setNumberList(charismaOptions);
        return charismaOptions;
    }
    
    private void setNumberList(List<SelectOption> tempList){
        tempList.add(new SelectOption('','-None-'));
        for(Integer i = 1; i <= 20; i++){
            tempList.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
    }

}