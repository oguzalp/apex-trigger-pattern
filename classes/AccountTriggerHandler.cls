/**
     This AccountHandler class is going to be binded to the before insert event 
     on the AccountTrigger.
*/
public class AccountTriggerHandler implements Triggers.IHandler{
    
    /*needs to be implemented.*/
    public void execute(){
        ProcessAccountDescriptions();
    }

    private static void ProcessAccountDescriptions(){

        List<Account> accounts= (List<Account>)Trigger.new;
        for(Account ac: accounts){
            ac.Description = ac.Name + ':' +ac.BillingState;
        }
    }
    
}