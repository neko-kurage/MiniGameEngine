import java.util.HashMap;

class World {
  ArrayList<Entity> entities = new ArrayList<Entity>();
  
  HashMap<String, ArrayList<Entity>> entitiesTags = new HashMap<String, ArrayList<Entity>>();
  
  EventListener eventListener;
  CollisionDetector colisionDetector;
  MouseEntity mouseData;
  
  World() {
    eventListener = new EventListener();
    colisionDetector = new CollisionDetector();
    
    mouseData = new MouseEntity();
    addEntity(mouseData);
  }
  
  void addEntity(Entity entity) {
    this.entities.add(entity);
    
    entity.setParentNodeWorld(this);
      
    ArrayList<Entity> thisTagEntitiys = new ArrayList<Entity>();
    for(String tag : entity.tags) {
      entitiesTags.putIfAbsent(tag, new ArrayList<Entity>());
      
      thisTagEntitiys = entitiesTags.get(tag);
      thisTagEntitiys.add(entity);
      entitiesTags.put(tag, thisTagEntitiys);
    }
  }
  
  void removeEntity(Entity entity) {
    this.entities.remove(entity);
  }
  
  void addedTag(String tagName, Entity entity) {
      entitiesTags.putIfAbsent(tagName, new ArrayList<Entity>());
      
      ArrayList<Entity> thisTagEntitiys = new ArrayList<Entity>();
      thisTagEntitiys = entitiesTags.get(tagName);
      thisTagEntitiys.add(entity);
      entitiesTags.put(tagName, thisTagEntitiys);
  }
  
  void removedTag(String tagName, Entity entity) {
    ArrayList<Entity> thisTagEntitiys = new ArrayList<Entity>();
    thisTagEntitiys = entitiesTags.get(tagName);
    thisTagEntitiys.remove(entity);
    entitiesTags.put(tagName, thisTagEntitiys);
  }
  
  void update() {
    this.eventListener.checkFireCondition();
    for (Entity entity : entities) {
      entity.update();
    }
  }
  
  void display() {   
    for(Entity entity : this.entities) {
      entity.display();
    }
  }
}

interface Displayable {
  void display();
}
