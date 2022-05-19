@isTest
public class CountrylayerCalloutTest {
    @isTest
    public static void testSchedule() {
        String sch = '0 0 23 * * ?';
        Test.setMock(HttpCalloutMock.class, new CountrylayerCalloutMock());
        Test.startTest();
        String jobId = System.schedule('ScheduleCountrylayerCalloutTest', sch, new ScheduleCountrylayerCallout());
        Test.stopTest();

        System.assertEquals(true, jobId != null);
    }

    @isTest
    static void testMakeCalloutSuccess() {
        Test.setMock(HttpCalloutMock.class, new CountrylayerCalloutMock());
        Test.startTest();
        CountrylayerCallout.makeCallout();
        Test.stopTest();

        Country_Info__c res = [select Name, ISO_Alpha2__c, RegionalBlocks__c from Country_Info__c where ISO_Alpha2__c = 'AF'];
        System.assertEquals(res.Name, 'Afghanistan');
        System.assertEquals(res.RegionalBlocks__c, 'SAARC');
    }

    @isTest
    static void testMakeCalloutError() {
        Test.setMock(HttpCalloutMock.class, new CountrylayerCalloutMockError());

        try{
            Test.startTest();
            CountrylayerCallout.makeCallout();
            Test.stopTest();
        }
        catch(CountrylayerCallout.CalloutException ex) {
            System.assert(ex.getMessage().contains('Callout failed with an error'));
        }
    }

    @isTest
    static void testMakeCalloutHttpError() {
        Test.setMock(HttpCalloutMock.class, new CountrylayerCalloutMockHttpError());

        try{
            Test.startTest();
            CountrylayerCallout.makeCallout();
            Test.stopTest();
        }
        catch(CountrylayerCallout.CalloutException ex) {
            System.assert(ex.getMessage().contains('Http request error status'));
        }
    }
}
