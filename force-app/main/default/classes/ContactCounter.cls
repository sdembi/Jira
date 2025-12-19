public with sharing class ContactCounter {
    
    // Returns the total number of Contact records in the org
    public static Integer countAllContacts() {
        return [SELECT COUNT() FROM Contact];
    }
    
    // Returns contacts for a specified Account
    public static List<Contact> getContactsByAccount(Id accountId) {
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}