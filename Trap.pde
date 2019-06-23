class Trap {
  float x, y;
  float w = SOIL_SIZE;
  float h = SOIL_SIZE;

  void checkCollision(Player player){

    if(player.col==round(x/SOIL_SIZE)&&player.row==round(y/SOIL_SIZE)){
      
      player.y+=120;
      player.row+=1;
      hurt.cue(0);
      hurt.play();


      player.playerHealth-=1;
      

    }
     
  }

  void display(){
    image(trap, x, y);
  }
    
  void update(){}

  Trap(float x, float y){
    this.x = x;
    this.y = y;
  }
}
