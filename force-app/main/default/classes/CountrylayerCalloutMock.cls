@isTest
public class CountrylayerCalloutMock implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[ { "name": "Afghanistan", "alpha2Code": "AF", "alpha3Code": "AFG", "capital": "Kabul", "region": "Asia", "subregion": "Southern Asia", "regionalBlocs": [ { "acronym": "SAARC", "name": "South Asian Association for Regional Cooperation" } ]},' +
                      '{ "name": "Ireland", "alpha2Code": "IE", "alpha3Code": "IRL", "capital": "Dublin", "region": "Europe", "subregion": "Northern Europe", "regionalBlocs": [ { "acronym": "EU", "name": "European Union" } ]}]');
        res.setStatusCode(200);

        return res;
    }
}
