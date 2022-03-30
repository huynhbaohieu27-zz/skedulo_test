public class SearchAccountsAndContactsController {
    public String searchKeyInput {get;set;}
    public List<ResultWrapper> results {get; set;}

    public class ResultWrapper {
        public String id;
        public String name {get;set;}
        public String type {get;set;}
        public String link {get;set;}
 
        public ResultWrapper(SObject record, String type) {
            this.id = (String) record.get('Id');
            this.name = (String) record.get('Name');
            this.type = type;
            this.link = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + (String) record.get('Id');
        }
    }

    public void search() {
        this.results = new List<ResultWrapper>();

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :(searchKeyInput + '%')];
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE Name LIKE :(searchKeyInput + '%')];

        if (accounts.size() > 0) {
            for (Account account : accounts) {
                results.add(new ResultWrapper(account, SObjectType.Account.getLabel()));
            }
        }

        if (contacts.size() > 0) {
            for (Contact contact : contacts) {
                results.add(new ResultWrapper(contact, SObjectType.Contact.getLabel()));
            }
        }
    }
}