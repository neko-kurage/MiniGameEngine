World world;
Entity object;

UIEntity UI;
UIEntity UI2;
UIEntity UI3;
SkinCircleButton skin;
SkinCircleButton skin2;
SkinCircleButton skin3;
CircleCollider uiCollision;

void setup() {
  size(600, 600, P3D);
  
  world = new World();

  skin = new SkinCircleButton(60, color(40), 4, 255);
  skin.setHoverStyle(20, color(255, 140, 100), 0, 255);
  skin.setTween(200);

  skin2 = new SkinCircleButton(60, color(220), 4, color(50));
  skin2.setHoverStyle(110, color(255, 255, 200), 16, color(255, 140, 100));
  skin2.setTween(500, new EasingInOutCubic());
  
  skin3 = new SkinCircleButton(60, color(40), 4, 255);
  skin3.setHoverStyle(160, color(160, 230, 200), 8, 255);
  skin3.setTween(1000);

  UI = new UIEntity(new CircleCollider(new PVector(0, 0), 60));
  UI.position = new PVector(width * 0.2, height / 2);
  UI.setSkin(skin);
  
  UI2 = new UIEntity(new CircleCollider(new PVector(0, 0), 60)); 
  UI2.position = new PVector(width / 2, height / 2);
  UI2.setSkin(skin2);
  UI2.addClickEvent("print", new TestPrint());

  UI3 = new UIEntity(new CircleCollider(new PVector(0, 0), 60));
  UI3.position = new PVector(width * 0.8, height / 2);
  UI3.setSkin(skin3);
  
  world.addEntity(UI);
  world.addEntity(UI2);
  world.addEntity(UI3);
    
  Geometry geometry = new GeometryPyramid(20, 20, 200);
  geometry.fillColor = color(255, 255, 255, 20);
  geometry.strokeColor = color(255);
  object = new Entity(geometry);
  object.position.set(width / 2, height / 2, width / 2);
  world.addEntity(object);
}

void draw() {
  background(0);
  
  //println(UI.getHoverState());
  
  print(WatchMouse.mouseStates);
  println(WatchKey.keyStates);
  
  object.rotation.y += 0.1;
  object.rotation.x += 0.01;
  
  world.update();
  world.display();
  
  //println(mouseEvent);
  
  WatchKey.update();
  WatchMouse.update();
}

void keyPressed() {
  WatchKey.updateKeyPressed(key);
}

void keyReleased() {
  WatchKey.updateKeyReleased(key);
}

void mousePressed() {
  WatchMouse.updateMousePressed(mouseButton);
}

void mouseReleased() {
  WatchMouse.updateMouseReleased(mouseButton);
}

class TestPrint implements EventAction {
  void execute() {
    println("Hello!!");
  }
}
