### Test assignment was developed with the following assumptions:

1. State and Country/Territory Picklists are enabled to provide easier mapping with external data.
2. API key is hardcoded into the callout class as the service doesn't provide more subtle authentication.
3. API doesn't provide any info about whether the data was changed recently, so regular update is made with an upsert statement for the whole set.
4. ISO Alpha-2 is used as an ExternalId when matching data. However this code can possibly change, as can Alpha-3 code or Country Name, but there are no other appropriate parameters in the API for that matter.
5. Regional Blocks are saved as a concatenated string as there were no specific requirements for storing this type of data (possible alternatives - multi-picklist, separate object)

### Callout scheduling
```
System.schedule('CountrylayerCallout - Everyday', '0 0 1 * * ?', new ScheduleCountrylayerCallout());
```
