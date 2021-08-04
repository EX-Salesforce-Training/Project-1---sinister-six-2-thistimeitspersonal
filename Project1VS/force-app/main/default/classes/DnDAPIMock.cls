@isTest
global class DnDAPIMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"count": 12, "results": [ {"index": "barbarian", "name": "Barbarian", "url": "/api/classes/barbarian" }, {"index": "bard","name": "Bard","url": "/api/classes/bard" }}]');
		response.setStatusCode(200);
        return response;
    }
}