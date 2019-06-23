class Diamond extends Item{
  float diamondScore=500;
  
  
    Diamond(float x, float y){
    super(x, y);
    health=6;
    }
    
    // Display Diamond
    
    void display(){
      image(diamond, x, y);
    }
    
      // Check collision with player
    void checkCollision(Player player){
     if(itemIsHit(x, y, w, h, player.x, player.y, player.w, player.h)){ 
       health -= 1;

        if(health<=0){
        isAlive=false;
        score+=diamondScore;
        pick.cue(0);
        pick.play();
        x = y = -1000;
      }
    }
    if( stopIsHit(x, y, w, h, player.x, player.y, player.w, player.h)){
     player.moveDirection = 0;
    }
}
}
