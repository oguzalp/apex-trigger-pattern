public class Triggers 
{
    /**
     *   Enum representing each of before/after CRUD events on Sobjects
     */
    public enum Event 
    {
        afterdelete, afterinsert, afterundelete,
        afterupdate, beforedelete, beforeinsert, beforeupdate   
    }

    /*
     *   Simplistic handler to implement on any of the event. It doesn't require or enforces any pattern except the
     *   method name to be "handle()".
     */
    public interface IHandler
    {
        void execute();          
    } 

    // Internal mapping of handlers
    Map<String, List<IHandler>> eventHandlerMapping = new Map<String, List<IHandler>>();

    /**
     *   Core API to bind handlers with events
     */
    public Triggers bind(Event event, IHandler eh)
    {
        List<IHandler> handlers = eventHandlerMapping.get(event.name());
        if (handlers == null) 
        {
            handlers = new List<IHandler>();
            eventHandlerMapping.put(event.name(), handlers);
        }
        handlers.add(eh);
        return this;
    }

    /**
     *   Invokes correct handlers as per the context of Trigger and available registered handlers
     */
    public void runAll()
    {
        Event ev = null;
        if(Trigger.isInsert && Trigger.isBefore)
        {
            ev = Event.beforeinsert;
        }
        else if(Trigger.isInsert && Trigger.isAfter)
        {
            ev = Event.afterinsert;
        }
        else if(Trigger.isUpdate && Trigger.isBefore)
        {
            ev = Event.beforeupdate;
        }
        else if(Trigger.isUpdate && Trigger.isAfter)
        {
            ev = Event.afterupdate;
        }
        else if(Trigger.isDelete && Trigger.isBefore)
        {
            ev = Event.beforedelete;
        }
        else if(Trigger.isDelete && Trigger.isAfter)
        {
            ev = Event.afterdelete;
        }
        else if(Trigger.isundelete)
        {
            ev = Event.afterundelete;             
        }
        
        List<IHandler> handlers = eventHandlerMapping.get(ev.name());
        
        if (handlers != null && ! handlers.isEmpty()) 
        {
            for (IHandler h : handlers) 
            {
                h.execute();
            }
        }
    }
}