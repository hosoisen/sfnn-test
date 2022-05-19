@isTest
public class CountrylayerCalloutMockError implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{ "success": false, "error": { "code": 104, "type": "monthly_limit_reached", "info": "Your monthly API request volume has been reached. Please upgrade your plan." } }');
        res.setStatusCode(200);

        return res;
    }
}
