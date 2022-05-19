@isTest
public class LeadTriggerTest {
    @TestSetup
    static void makeData(){
        Test.setMock(HttpCalloutMock.class, new CountrylayerCalloutMock());
        Test.startTest();
        CountrylayerCallout.makeCallout();
        Test.stopTest();
    }

    @isTest
    public static void testInsert(){
        Country_Info__c cInf = [select Id from Country_Info__c where ISO_Alpha2__c = 'IE'];

        Lead ld = new Lead(FirstName='Molly',LastName='Malone',Company='Cockles&Mussels',CountryCode='IE');
        Test.startTest();
        insert ld;
        Test.stopTest();

        Lead ldResult = [select Country_Info__c from Lead where Id = :ld.Id];
        System.assertEquals(cInf.Id, ldResult.Country_Info__c);
    }

    @isTest
    public static void testUpdate(){
        Country_Info__c cInf = [select Id from Country_Info__c where ISO_Alpha2__c = 'AF'];
        Lead ld = new Lead(FirstName='Molly',LastName='Malone',Company='Cockles&Mussels',CountryCode='IE');
        insert ld;

        Lead ldToUpdate = [select Id, CountryCode from Lead where Id = :ld.Id];
        ldToUpdate.CountryCode = 'AF';
        Test.startTest();
        update ldToUpdate;
        Test.stopTest();

        Lead ldResult = [select Country_Info__c from Lead where Id = :ld.Id];
        System.assertEquals(cInf.Id, ldResult.Country_Info__c);
    }
}
