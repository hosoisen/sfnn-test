trigger LeadTrigger on Lead (before insert, before update) {
    Set<String> countriesSet = new Set<String>();
    List<Lead> leadsToUpdate = new List<Lead>();

    if(Trigger.isBefore && Trigger.isUpdate){
        for (Integer i=0; i < Trigger.new.size(); i++) {
            if(Trigger.old[i].CountryCode != Trigger.new[i].CountryCode){
                countriesSet.add(Trigger.new[i].CountryCode);
                leadsToUpdate.add(Trigger.new[i]);
            }
        }
    }

    if(Trigger.isBefore && Trigger.isInsert){
        for(Lead newLead : Trigger.new) {
            if(newLead.CountryCode != null) {
                countriesSet.add(newLead.CountryCode);
                leadsToUpdate.add(newLead);
            }
        }
    }

    Map<String, Id> countryCodesMap = new Map<String, Id>();
    for(Country_Info__c cInf : [select Id, ISO_Alpha2__c from Country_Info__c where ISO_Alpha2__c in :countriesSet]) {
        countryCodesMap.put(cInf.ISO_Alpha2__c, cInf.Id);
    }

    for(Lead l : leadsToUpdate) {
        l.Country_Info__c = countryCodesMap.get(l.CountryCode);
    }
}