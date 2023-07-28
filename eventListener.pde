import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

class EventListener {
  HashMap<String, Event> events = new HashMap<String, Event>();
  
  void checkFireCondition() {
    for(Event event : events.values()) {
      if(event.isFireCondition()) {
        event.fire();
      }
    }
  }
  
  void addEvent(String eventName, Event event) {  
    this.events.put(eventName, event);
  }
  
  void removeEvent(String eventName) {  
    this.events.remove(eventName);
  }
}

class Event {
  //String = trigger mame
  //EventTrigge = implements EventTriggers
  HashMap<String, EventTrigger> triggers = new HashMap<String, EventTrigger>();
  
  //String = action mame
  //EventTrigge = implements EventAction
  HashMap<String, EventAction> actions = new HashMap<String, EventAction>();
  
  Event() {
  }
  
  void addTrigger(String triggerName, EventTrigger trigger) {  
    this.triggers.put(triggerName, trigger);
  }
  
  void removeTrigger(String triggerName) {  
    this.triggers.remove(triggerName);
  }
  
  void addAction(String actionName, EventAction action) {
    actions.put(actionName, action);
  }
  
  void removeAction(String actionName) {
    actions.remove(actionName);
  }
  
  void fire() {
    for(EventAction action : actions.values()) {
      action.execute();
    }
  }
  
  void selectFire(String actionName) {
    actions.get(actionName).execute();
  }
  
  boolean isFireCondition() {
    for(EventTrigger trigger : this.triggers.values()) {
      if(trigger.isFireCondition()) return true;
    }
    
    return false;
  };
}

interface EventTrigger {
  boolean isFireCondition();
 
}

interface EventAction {
  void execute();
}
