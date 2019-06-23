class Stone {
  boolean isAlive;
  float x, y;
  float w = SOIL_SIZE;
  float h = SOIL_SIZE;
  float health;

  void display(){}
  void checkCollision(Player player){}
  void health(){
   health--;
  }

  Stone(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
    this.health=health;
  }
}
