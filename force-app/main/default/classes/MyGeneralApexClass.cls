public with sharing class MyGeneralApexClass {
    
    // Class variables
    public String sampleProperty {get; set;}
    
    // Default constructor
    public MyGeneralApexClass() {
        sampleProperty = 'Default Value';
    }
    
    // Example method: returns a greeting message
    public String getGreeting(String name) {
        return 'Hello, ' + name + '!';
    }
    
    // Example method: perform a simple sum
    public Integer addNumbers(Integer a, Integer b) {
        return a + b;
    }
    
    // Static method example
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}