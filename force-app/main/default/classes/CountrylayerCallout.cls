public class CountrylayerCallout {
    @future(callout=true)
    public static void makeCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.countrylayer.com/v2/all?access_key=3221b6b132b4fd3f36d239d6d35c6abe');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            if(JSON.deserializeUntyped(response.getBody()) instanceof List<Object>) {
                List<CountryInfo> results = (List<CountryInfo>) JSON.deserialize(response.getBody(), List<CountryInfo>.class);
                List<Country_Info__c> ciList = new List<Country_Info__c>();

                for(CountryInfo country : results) {
                    Country_Info__c cInf = new Country_Info__c();
                    cInf.Name = country.name;
                    cInf.ISO_Alpha2__c = country.alpha2Code;
                    cInf.ISO_Alpha3__c = country.alpha3Code;
                    cInf.Capital__c = country.capital;
                    cInf.Region__c = country.region;
                    cInf.Subregion__c = country.subregion;

                    List<String> regBlocksList = new List<String>();
                    if(country.regionalBlocs != null) {
                        for(Map<String,String> regBlock : country.regionalBlocs) {
                            regBlocksList.add(regBlock.get('acronym'));
                        }
                    }
                    cInf.RegionalBlocks__c = regBlocksList.isEmpty() ? null : String.join(regBlocksList, ', ');

                    ciList.add(cInf);
                }
                upsert ciList ISO_Alpha2__c;
            }

            if(JSON.deserializeUntyped(response.getBody()) instanceof Map<String, Object>) {
                Map<String,Object> errorResult = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                throw new CalloutException('Callout failed with an error: ' + errorResult.get('error'));
            }
        }
        else{
            throw new CalloutException('Http request error status: ' + response.getStatusCode());
        }
    }

    public class CountryInfo{
        String name;
        String alpha2Code;
        String alpha3Code;
        String capital;
        String region;
        String subregion;
        List<Map<String,String>> regionalBlocs;
    }

    public class CalloutException extends Exception {}
}
