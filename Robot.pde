class Robot extends Enemy {
  // Requirement #5: Complete Dinosaur Class
  Laser laser;
  boolean isDetected = false;
  boolean laserOn = false;
  int laserTimer =0;

  float A;
  float B;
  float C;
  float D;

  final int PLAYER_DETECT_RANGE_ROW = 2;
  final int LASER_COOLDOWN = 180;
  final int HAND_OFFSET_Y = 37;
  final int HAND_OFFSET_X_FORWARD = 64;
  final int HAND_OFFSET_X_BACKWARD = 16;
  float currentSpeed;
  float speed = 2f;
  int direction = 1;

  Robot(float x, float y) {
    super(x, y);
    laser = new Laser();
  }

  void isDetected() {
    if ( player.y > this.y - 3 * SOIL_SIZE && player.y < this.y +  3 * SOIL_SIZE) { 
      if ( (direction == 1 && player.x > this.x) || (direction == -1 && player.x < this.x) ) 
        isDetected = true;
    } else isDetected = false;
  }

  void update() {
    if (x >= width-this.w || x <= 0) direction *= -1 ;
    isDetected();
    currentSpeed = speed;

    if (isDetected == true) {
      speed = 0;
      laserOn = true;
      if (x >= width-this.w) direction = -1 ;
      if (x <= 0) direction = 1 ;
    } else {
      speed = currentSpeed;
      if (x > width-this.w || x <= 0) speed *= -1;
      x += speed;
      laserOn = false;
    }

    if (laserOn) { 
      if (laserTimer == 0) {
        A = this.x;
        B = this.y;
        C = player.x;
        D = player.y;
        laserShot(A, B, C, D);
      }
      //println("shot"+laserTimer);
      laser.update();
      laserTimer += 1;
      laserTimer %= 180;
    } else laserTimer = 0;
  }

  void laserShot(float a, float b, float c, float d) {
    if (direction == 1) { 
      laser.fire(a + HAND_OFFSET_X_FORWARD, b + HAND_OFFSET_Y, c + w/2, d + h/2);
    } else { 
      laser.fire(a + HAND_OFFSET_X_BACKWARD, b + HAND_OFFSET_Y, c + w/2, d + h/2);
    }
  }
  //laser.fire(this.x + HAND_OFFSET_X_FORWARD, this.y + HAND_OFFSET_Y, player.x + w/2, player.y + h/2);
  //laser.fire(this.x + HAND_OFFSET_X_BACKWARD, this.y + HAND_OFFSET_Y, player.x + w/2, player.y + h/2);

  void display() {

    pushMatrix();
    translate(x, y);
    if (direction == 1) {
      scale(1, 1);
      image(robot, 0, 0);
    } else if (direction == -1) {
      scale(-1, 1);
      image(robot, -this.w, 0);
    }
    popMatrix();
    if (laserOn) laser.display();
  }

  void checkCollision(Player player) {

    super.checkCollision(player);
    laser.checkCollision(player);
    //if(player.health == player.health -1) laserOn = false;
  }



  // HINT: Player Detection in update()
  /*

   	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
   					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )
   
   	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me
   
   	if(checkX AND checkY){
   		Is laser's cooldown ready?
   			True  > Fire laser from my hand!
   			False > Don't do anything
   	}else{
   		Keep moving!
   	}
   
   	*/
}
