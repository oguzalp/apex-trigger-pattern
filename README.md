# apex-trigger-pattern
Apex trigger design template

## Usage
  <pre>new Triggers().
          bind(Triggers.Event.beforeinsert, new AccountTriggerHandler()).
          bind(Triggers.Event.beforeupdate,new AccountTriggerHandler()).
          runAll();
  </pre>        
          
