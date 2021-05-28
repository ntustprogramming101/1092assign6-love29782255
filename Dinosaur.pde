class Dinosaur extends Enemy {
  // Requirement #4: Complete Dinosaur Class

  final float TRIGGERED_SPEED_MULTIPLIER = 5;
  float speed = 1f ;
  int direction = 1;

  Dinosaur(float x, float y) {
    super(x, y);
  }


  void display() {
    if (x >= width-this.w || x <= 0) direction *= -1 ;
    pushMatrix();
    translate(x, y);
    if (direction == 1) {
      scale(1, 1);
      image(dinosaur, 0, 0);
    } else if (direction == -1) {
      scale(-1, 1);
      image(dinosaur, -this.w, 0);
    }
    popMatrix();
  }

  void update() {
    if (player.y == this.y) {
      if (direction == 1 && player.x > this.x) speed *= TRIGGERED_SPEED_MULTIPLIER;
      if (direction == -1 && player.x < this.x) speed *= TRIGGERED_SPEED_MULTIPLIER;
    } 
    if (x > width-this.w || x <= 0) speed *= -1;
    x += speed;
    println(direction);
  }

  void checkCollision(Player player) {
    if (isHit(this.x, this.y, this.w, this.h, player.x, player.y, player.w, player.h)) {
      player.hurt();
      if (direction == 1) speed = 1f;
      if (direction == -1) speed = -1f;
    }
  }


  // HINT: Player Detection in update()
  /*
	float currentSpeed = speed
   	If player is on the same row with me AND (it's on my right side when I'm going right OR on my left side when I'm going left){
   		currentSpeed *= TRIGGERED_SPEED_MULTIPLIER
   	}
   	*/
}
