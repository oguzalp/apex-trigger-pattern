trigger AccountTrigger on Account (before insert,after insert,before update,after update,before delete,after delete) {
          
        new Triggers().
            bind(Triggers.Event.beforeinsert, new AccountTriggerHandler()).
            bind(Triggers.Event.beforeupdate,new AccountTriggerHandler()).   
        runAll();  
       
}