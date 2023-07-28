class Entity implements Displayable {
  ArrayList<String> tags = new ArrayList<String>();
  
  protected World parentWorld = null;
  
  PVector position;
  PVector rotation;
  Geometry geometry;
  EventListener eventListener;
  Event hoverEvent;
  
  Entity() {
    this.position = new PVector(0, 0, 0);
    this.rotation = new PVector(0, 0, 0);
    
    this.eventListener = new EventListener();
    this.hoverEvent = new di
  }
  
  Entity(Geometry myGeometry) {
    this.position = new PVector(0, 0, 0);
    this.rotation = new PVector(0, 0, 0);
    
    this.geometry = myGeometry;
    this.eventListener = new EventListener();
  }
  
  void setGeometry(Geometry myGeometry) {
    this.geometry = myGeometry;
  }
  
  void removeGeometry() {
    this.geometry = null;
  }
  
  void addTag(String tag) {
    tags.add(tag);
    
    if(parentWorld == null) return;
    parentWorld.addedTag(tag, this);
  }
  
  void removeTag(String tag) {
    tags.remove(tag);
    
    if(parentWorld == null) return;
    parentWorld.addedTag(tag, this);
  }
  
  void removeTag(int tagIndex) {
    tags.remove(tagIndex);
  }
  
  void update() {
    this.eventListener.checkFireCondition();
  }
  
  void display() {
    if(geometry == null) return;
    pushMatrix();
      translate(this.position.x, this.position.y, this.position.z);
      rotateX(this.rotation.x);
      rotateY(this.rotation.y);
      rotateZ(this.rotation.z);
      geometry.display();
    popMatrix();
  };
  
  void setParentNodeWorld(World world) {
    this.parentWorld = world;
  }

  @Override
  boolean equals(Object obj) {
      Entity other = (Entity) obj;
      return this.tags == other.tags;
  }
}

class MouseEntity extends Entity {
  Collider2D collision;
  
  MouseEntity() {
    super();
    collision = new PointCollider(new PVector(mouseX, mouseY));
    collision.setParentNode(this);
  }
  
  @Override
  void update() {
    this.position = (new PVector(mouseX, mouseY));
    this.collision.update();
  }
}

class UIEntity extends Entity {
  Collider2D collision;
  UISkin skin;
  
  private String hoverState = "hoverOff";
  final HashSet<String> stateTypes = new HashSet<String>() {{
    add("hovered");
    add("hoverExit");
    add("hovering");
    add("hoverOff");
  }};
  
  String getHoverState() {
    return hoverState;
  }
  
  UIEntity() {
    super();
  }
  
  UIEntity(Collider2D setCollision) {
    super();

    this.collision = setCollision; 
    this.collision.setParentNode(this);
  }
  
  void setCollision(Collider2D setCollision) {
    this.collision = setCollision;
    this.collision.setParentNode(this);
  }
  
  void setSkin(UISkin skin) {
    this.skin = skin;
    this.skin.setParentNode(this);
  }
  
  boolean isHover() {
    if(this.parentWorld == null) return false;
    if(this.collision == null) return false;

    return this.parentWorld.colisionDetector.detectCollision(this.parentWorld.mouseData.collision, this.collision);
  }
  
  @Override
  void update() {
    super.update();
    if(this.collision != null) this.collision.update();
    
    if(hoverState.equals("hovered")) hoverState = "hovering";
    if(hoverState.equals("hoverOff") && isHover()) hoverState = "hovered";
    if(hoverState.equals("hoverExit")) hoverState = "hoverOff";
    if(hoverState.equals("hovering") && !isHover()) hoverState = "hoverExit";
    
    if(this.skin != null) this.skin.update();
  }
  
  @Override
  void display() {
    if(skin == null) return;
    skin.display();
  }
}
