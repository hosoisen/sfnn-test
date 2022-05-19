public class CountrylayerCalloutMockHttpError implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(404);

        return res;
    }
}
