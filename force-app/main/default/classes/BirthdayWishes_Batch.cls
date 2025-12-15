public with sharing class BirthdayWishes_Batch implements Database.Batchable<SObject>, Database.Stateful {

    // Query to select Contacts whose birthday is today
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Adjust the query as needed for your org's data model
        return Database.getQueryLocator([
            SELECT Id, FirstName, LastName, Birthdate, Email
            FROM Contact
            WHERE CALENDAR_MONTH(Birthdate) = :Date.today().month()
              AND DAY_IN_MONTH(Birthdate) = :Date.today().day()
              AND Email != null
        ]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Contact c : (List<Contact>)scope) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { c.Email });
            mail.setSubject('Happy Birthday!');
            mail.setPlainTextBody('Dear ' + c.FirstName + ',\n\nWishing you a wonderful birthday!\n\nBest regards,\nYour Salesforce Team');
            emails.add(mail);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Optional: Add post-processing logic here (e.g., logging, notifications)
        System.debug('Birthday wishes batch completed.');
    }
}