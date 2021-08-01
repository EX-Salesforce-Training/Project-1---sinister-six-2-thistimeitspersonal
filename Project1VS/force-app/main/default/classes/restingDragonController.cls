/////////////////////////////////////////
//
// Dungeons and Dragons REST API controller
// 
// Purpose: Connecting the the dnd5eapi.co API, and making data available for visualforce pages
// 
// Initial designer: Richard 'Jerry' Laughter
// Creation Date: 7/29/2021
// Latest Edit: 7/29/2021
//
/////////////////////////////////////////

public class restingDragonController {
    
    public List<charClass> finClassList {get;set;}
    
    public restingDragonController(){
        finClassList = classMap(makeCallout());
    }

    public static List<charClass> classMap (Map<String, Object> respMap){
	    // casts object into list of objects
        List<Object> classList = (List<Object>)
	        respMap.get('results');
        
        // 
        
        List<charClass> finClassList = new List<charClass>();
        
        for(Object o: classList){
            charClass curClass = new charClass(o);
			finClassList.add(curClass);
        }
        return finClassList;
    }
    
    public static List<String> classList (Map<String, Object> respMap){
	    // casts object into list of objects
        List<Object> curClassList = (List<Object>)
	        respMap.get('results');
        
        // 
        
        List<String> finClassList = new List<String>();
        
        for(Object o: curClassList){
            charClass curClass = new charClass(o);
			finClassList.add(curClass.name);
        }
        return finClassList;
    }
            
    public static  Map<String, Object> makeCallout(){
        String apiAddress = 'https://www.dnd5eapi.co/api/';
            
        List<String> categories = new List<String>{'classes/', 'ability-scores/', 'skills/', 'proficiencies/', 'languages/', 'alignment/', 'backgrounds/', 'races/', 'traits/', 'equipment-categories/', 'equipment/', 'magic-items/', 'weapon-properties/', 'spells/', ''};
        
        Http http = new Http();
        httpRequest request = new HttpRequest();
        request.setEndpoint(apiAddress + categories[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200){

            // creations an string, object map from JSON string
            Map<String, Object> respMap = (Map<String, Object>)
                JSON.deserializeUntyped(response.getBody());

            return respMap;
            //return finClassList;
        }
        return null;
            
    }	

    public class charClass{
        public String name {get;set;}
        public String URL {get; set;}
        
        public charClass(Object rawData){
            Map<String, Object> finClassList = (Map<String, Object>)rawData;

            name = String.valueOf(finClassList.get('name'));
            URL = String.valueOf(finClassList.get('url'));
        }

    }
    
}