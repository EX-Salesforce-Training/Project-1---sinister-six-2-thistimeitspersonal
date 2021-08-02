public class APIExchange{
	public static Map<String, Object> makeCallout(String apiAddress){
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