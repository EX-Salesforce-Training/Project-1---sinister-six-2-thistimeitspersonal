/////////////////////////////////////////
//
// Generic REST API class
// 
// Purpose: Connecting to REST compatible APIs with minimal requirements, and making data available for visualforce pages
// 
// Initial designer: Richard 'Jerry' Laughter
// Creation Date: 7/29/2021
// Latest Edit: 8/2/2021
//
/////////////////////////////////////////

public class APIExchange{
	public static Map<String, Object> makeCallout(String apiAddress){
		//takes in REST api address and returns a map<string, object>
		//objects must be typecast into their proper object type
		//please consult the API docs for the endpoint before use
        Http http = new Http();
		httpRequest request = new HttpRequest();
		request.setEndpoint(apiAddress);
		request.setMethod('GET');
		request.setHeader('Content-Type', 'appication/json');
		request.setHeader('Accept', 'application/json');
		HttpResponse response = http.send(request);

		if (response.getStatusCode() == 200){
			Map<String, Object> respMap = (Map<String, Object>)
				JSON.deserializeUntyped(response.getBody());
			return respMap;
		}
		return null;
	}
}