class Boid extends Object {
  PVector velocity;
  PVector acceleration;
  float maxForce;
  float maxSpeed;
  
  Boid() {
    //super(new GeometryPyramid(500, 500, 60));
    super(new GeometryPyramid(5, 5, 10));
    
    this.velocity = new PVector(0, 0, 0);
    this.acceleration = new PVector(0, 0, 0);
    this.maxForce = 0.1;
    this.maxSpeed = 3;
  }
  
  //一定の範囲内のboidsの平均速度を求める
  PVector align(ArrayList<Boid> boids, float pRadius) {
    //平均を求める際に対象となるboidまでの距離の上限
    float perceptionRadius = pRadius;
    //進む方向
    PVector steering = new PVector();
    //見つかったboidのかず
    int boidsCount = 0;
    
    for(int i = 0; i < boids.size(); i++) {
      Boid otherBoid = boids.get(i);
      
      float d = dist(
        this.position.x,
        this.position.y,
        this.position.z,
        otherBoid.position.x,
        otherBoid.position.y,
        otherBoid.position.z
      );
      
      if(otherBoid != this && d < perceptionRadius) {
        steering.add(otherBoid.velocity);
        boidsCount ++;
      }
    }
    
    if(boidsCount > 0) {
      steering.div(boidsCount);
      //ベクトルの大きさを強制的にあげることによって速度が遅くなりすぎないようにする
      steering.setMag(this.maxSpeed);
      //ここで算出したsteeringを分をvelocityに足せば平均の移動距離になる(足並みが揃う)
      steering.sub(this.velocity);
      //1フレームで平均の移動距離になられても困るので変える量を制限する
      steering.limit(this.maxForce);
    }
    return steering;
  }
  
  //結合(alignの位置座標版)
  PVector cohesion(ArrayList<Boid> boids, float pRadius) {
    //平均を求める際に対象となるboidまでの距離の上限
    float perceptionRadius = 100;
    //進む方向
    PVector steering = new PVector();
    //見つかったboidのかず
    int boidsCount = 0;
    
     for(int i = 0; i < boids.size(); i++) {
      Boid otherBoid = boids.get(i);
      
        float d = dist(
          this.position.x,
          this.position.y,
          this.position.z,
          otherBoid.position.x,
          otherBoid.position.y,
          otherBoid.position.z
        );
        
        if(otherBoid != this && d < perceptionRadius) {
          steering.add(otherBoid.position);
          boidsCount += 1;
        }
     }

     if (boidsCount > 0) {
        steering.div(boidsCount);
        // 現在の位置との差を求める
        steering.sub(this.position);
        // 目標速度
        steering.setMag(this.maxSpeed);
        // 現在の速度を引く
        steering.sub(this.velocity);
        // 力を制限する
        steering.limit(this.maxForce);
     }
    return steering;
  }
  
  //引き離し
  PVector separation(ArrayList<Boid> boids, float pRadius) {
    //平均を求める際に対象となるboidまでの距離の上限
    float perceptionRadius = pRadius;
    //進む方向
    PVector steering = new PVector();
    //見つかったboidのかず
    int boidsCount = 0;
    
    for(int i = 0; i < boids.size(); i++) {
      Boid otherBoid = boids.get(i);
      
      float d = dist(
        this.position.x,
        this.position.y,
        this.position.z,
        otherBoid.position.x,
        otherBoid.position.y,
        otherBoid.position.z
      );
      
      if(otherBoid != this && d < perceptionRadius) {
        //ここで算出した値を足せば他のboidに近づくように、引けば他のboidから離れるようになる
        PVector diff = new PVector(this.position.x, this.position.y, this.position.z).sub(otherBoid.position);
        diff.div(d); //距離が近ければ近いほどより離れる速度をあげるよう重みづけ
        steering.add(diff);
        boidsCount ++;
      }
    }
    
    if(boidsCount > 0) {
      steering.div(boidsCount);
      //ベクトルの大きさを強制的にあげることによって速度が遅くなりすぎないようにする
      steering.setMag(this.maxSpeed);
      //引くことで他のboidから離れるように
      steering.sub(this.velocity);
      //1フレームで目標のvelocityになられても困るので変える量を制限する
      steering.limit(this.maxForce);
    }
    return steering;
  }
  
  //結合(alignの位置座標版)
  PVector flockToMouse(float pRadius) {
    //平均を求める際に対象となるboidまでの距離の上限
    float perceptionRadius = pRadius;
    //進む方向
    PVector steering = new PVector();

     float d = dist(
      this.position.x,
      this.position.y,
      mouseX,
      mouseY
    );
    
    if(d < perceptionRadius) {
      steering = new PVector(mouseX, mouseY);
    }

    // 現在の位置との差を求める
    steering.sub(this.position);
    // 目標速度
    steering.setMag(this.maxSpeed);
    // 現在の速度を引く
    steering.sub(this.velocity);
    // 力を制限する
    steering.limit(this.maxForce);

    return steering;
  }
  
  void flock(ArrayList<Boid> boids, float pRadius) {
    //整列するようにalignで算出した分をaccに足す
    PVector alignment = this.align(boids, pRadius);
    alignment.mult(0.4); //controlp5で重みづけ
    this.acceleration.add(alignment);
    
    //周りのboidsが集まるようにcoheisionで算出した分をaccに足す
    PVector cohesion = this.cohesion(boids, pRadius);
    cohesion.mult(0.25); //controlp5で重みづけ
    this.acceleration.add(cohesion);
    
    //他のboidから離れるようにseparationで算出した分をaccに足す
    PVector separation = this.separation(boids, pRadius);
    separation.mult(0.80); //controlp5で重みづけ
    this.acceleration.add(separation);
    
    PVector flockToMouse = this.flockToMouse(width/3);
    flockToMouse.mult(0.5);
    if (mousePressed == true) this.acceleration.add(flockToMouse);
  }
  
  //画面の端まで行ったら反対側に移動する
  void edges() {
    if(this.position.x > width) {
      this.position.x = 0;
    } else if(this.position.x < 0) {
      this.position.x = width;
    }
    
    if(this.position.y > height) {
      this.position.y = 0;
    } else if(this.position.y < 0) {
      this.position.y = height;
    }
  }
  
  void setMaxForce(float setMaxForce) {
    this.maxForce = setMaxForce;
  }
  
  void setMaxSpeed(float setMaxSpeed) {
    this.maxSpeed = setMaxSpeed;
  }
  
  void update() {
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.maxSpeed);
    
    /*
    //The order is x y z
    PVector normalizedVector = new PVector(this.velocity.x, this.velocity.y, this.velocity.z);
    normalizedVector.normalize();
    
    float[] unitVector = {normalizedVector.x, normalizedVector.y, normalizedVector.z};

    float[] rad = {
      atan2(unitVector[2], -unitVector[1]),
      atan2(unitVector[0], unitVector[2]),
      atan2(unitVector[0], -unitVector[1])
    };
    
    float[][] eulerMatrix =
    {
      {
        cos(rad[0]) * cos(rad[1]) * cos(rad[2]) - sin(rad[0]) * sin(rad[1]),
        sin(rad[0]) * cos(rad[1]) * cos(rad[2]) + cos(rad[0]) * sin(rad[2]),
        sin(-rad[1]) * cos(rad[2])
      },
      {
        cos(-rad[0]) * sin(rad[2]) - sin(rad[0]) * cos(rad[1]) * cos(rad[2]),
        sin(-rad[0]) * cos(rad[2]) + cos(rad[0]) * cos(rad[1]) * sin(rad[2]),
        sin(rad[1]) * sin(rad[2])
      },
      {
        cos(rad[0]) * sin(rad[1]),
        sin(rad[0]) * sin(rad[1]),
        cos(rad[1])
      }
    };
    
    float euler[] = {0, 0, 0};
    for(int selectAxis = 0; selectAxis < 3; selectAxis++) {
      for(int i = 0; i < 3; i++) {
        euler[selectAxis] += unitVector[selectAxis] * eulerMatrix[selectAxis][i];
      }
    }
    */
    
    PVector normalizedVector = new PVector(this.velocity.x, this.velocity.y, this.velocity.z);
    normalizedVector.normalize();
    
    float[] unitVector = {normalizedVector.x, normalizedVector.y, normalizedVector.z};
    
    float radX = atan2(unitVector[2], -unitVector[1]);
    float radY = atan2(unitVector[0], unitVector[2]);
    float radZ = atan2(unitVector[0], -unitVector[1]);

    PVector xyFlatVelocity = Matrix.rotateY(this.velocity, -radY);
    //println(xyFlatVelocity + ":" + this.velocity);
    
    float pit = atan2(-xyFlatVelocity.z, -xyFlatVelocity.y);
    //println(this.position, pit);

    this.rotation.x = pit;
    this.rotation.y = radY;
    //this.rotation.z = HALF_PI;


    // 1フレームごとに移動量を算出しなおすので0に戻す
    this.acceleration.mult(0);
  }
}
