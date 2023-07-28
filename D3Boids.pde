import java.util.Map;

World world;
Camera camera;
Object object;
ArrayList<Boid> boids = new ArrayList<Boid>();
ArrayList<Object> objects = new ArrayList<Object>();

void setup() {
  fullScreen(P3D);
  background(200);
  
  world = new World();
  camera = new Camera();
  
  initBoids(800);
  initObjects(150);
  initLight();
  
  object = new Object(new GeometryPyramid(20, 20, 300));
  object.position.set(width / 2, height / 2 + 50, height / 2 - 200);
  
  world.addObject(object);
}

void initBoids(int count) {
  for(int i = 0; i < count; i++) {
    float angle = random(0, PI * 2);
    float rad = 100;
    
    //float posX = width / 2 + rad * sin(angle);
    //float posY = height / 2 + rad * cos(angle);
    
    float posX = random(0, width);
    float posY = random(0, height);
    float posZ = random(-100, 100);
    
    float velX = sin(angle) * random(0.5, 1.5);
    float velY = cos(angle) * random(0.5, 1.5);
    float velZ = random(-5,5);
    
    Boid boid = new Boid();
    boid.position.set(posX, posY, posZ);
    boid.velocity.set(velX, velY, velZ);
    boids.add(boid);
    world.addObject(boids.get(i));
  }
}

void initObjects(int count) {
  for(int i = 0; i < count; i++) {
    float rectSize = random(80, 200);
    Object myObject = new Object(new Box(rectSize, rectSize, random(600, 1200)));
    
    myObject.position.set(random(-2000, 4000), 1200, random(-6000, 400));
    
    objects.add(myObject);
    world.addObject(myObject);
  }
  
  //object plane = new Object(new Box())
}

void initLight() {
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 1, 0.8, 0);
}

void draw() {
  background(0, 0, 255);
  
  object.position.add(0, 0, 0);
  object.rotation.add(0, degToRad(1), 0);
  
  for(int i = 0; i < boids.size(); i++) {
    Boid boid = boids.get(i);
    
    boid.flock(boids, 30);
    boid.edges();
    boid.update();
  }
 
  //println(boids.get(0).velocity);
  fill(255,255,255);
  noStroke();
  //strokeWeight(2);
  initLight();
  //camera.setPosition(new PVector(boids.get(0).position.x - 400, boids.get(0).position.y + 200, boids.get(0).position.z- 400), boids.get(0).position);
  
  pushMatrix();
  //fill (255, 255, 255, 10);
  translate(-1000, 1000, -500);
  //box(6000, 6000, 1);
  popMatrix();
  
  fill (255, 120);
  world.display();
}

float degToRad(float deg) {
  return deg * PI / 180;
}
