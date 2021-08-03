public class HomepageController {
    
    public String description {get;set;}
    
    public HomepageController(ApexPages.StandardController sc){
        //[select id, description from campaign order by createdDate DESC limit 1];
        List<Campaign> c = [select id, Description from campaign order by createdDate DESC limit 1];
        if(c.size() > 0){
        	description = c[0].Description;
        	//System.debug('description: ' + description);
        	//System.debug('C.des: ' + c.Description);
        	if(description == null)
            	description = 'Campaign Description Unavailable!';
        }else{
            description = 'No Current Campaign!';
        }
    }

}