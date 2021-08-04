/////////////////////////////////////////
//
// Dungeons and Dragons REST API controller
// 
// Purpose: Connecting the the dnd5eapi.co API, and making data available for visualforce pages
// 
// Initial designer: Richard 'Jerry' Laughter
// Creation Date: 7/29/2021
// Latest Edit: 8/3/2021
//
/////////////////////////////////////////

public class restingDragonController {
    
    public List<charAttribute> finClassList {get;set;}
    public List<String> categories = new List<String>{'classes/', 'ability-scores/', 'skills/', 'proficiencies/', 'languages/', 'alignment/', 'backgrounds/', 'races/', 'traits/', 'equipment-categories/', 'equipment/', 'magic-items/', 'weapon-properties/', 'spells/', ''};

    public restingDragonController(){
        finClassList = getCharAttribute(categories[0]);
    }
    
    public static List<String> indexList (String index){
		//creates a list of strings from the index of the character attribute list

    	List<charAttribute> curAttrList = getCharAttribute(index);
        
        List<String> finAttrList = new List<String>();

        for (charAttribute ca: curAttrList){
            finAttrList.add(ca.index);
        }

        return finAttrList;


    }

    //character attributes are obtained using the APIExchange callout function
    //the resulting JSON is formatted into a map<string,object>
    //this is then passed into a wrapper class such that the attributes can be extracted as desired
    public static List<charAttribute> getCharAttribute(String index){

        Map<String, Object> respMap = APIExchange.makeCallout('https://www.dnd5eapi.co/api/' + index);

        List<Object> curIndexList = (List<Object>)
            respMap.get('results');

        List<charAttribute> finAttributeList = new List<charAttribute>();

        for(Object o: curIndexList){
            charAttribute curAttribute = new charAttribute(o);
            finAttributeList.add(curAttribute);
        }

        return finAttributeList;

    }

    //the character attribute wrapper class takes in an object
    //typecasts it to a set of strings which are stored in properties
    //compatible with visualforce bindings
    public class charAttribute{
        public String name {get;set;}
        public String URL {get; set;}
        public String index {get; set;}
        
        public charAttribute(Object rawData){
            Map<String, Object> finObjList = (Map<String, Object>)rawData;

            index = String.valueOf(finObjList.get('index'));
            name = String.valueOf(finObjList.get('name'));
            URL = String.valueOf(finObjList.get('url'));
        }

    }
    
}