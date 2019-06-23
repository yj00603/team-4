class Ruby extends Item{
  float rubyScore=200;
  
  
    Ruby(float x, float y){
    super(x, y);
    health=4;
    }
    
    // Display Cabbage
    void display(){
      image(ruby, x, y);
    }
   
      // Check collision with player
    void checkCollision(Player player){
       
      if(itemIsHit(x, y, w, h, player.x, player.y, player.w, player.h)){
       health -= 1;
        if(health<=0){
        isAlive=false;
        pick.cue(0);
        pick.play();
        score+=rubyScore;
        x = y = -1000;
      }
      }
      /*if(health<=0){
        isAlive=false;
        score+=rubyScore;
        x = y = -1000; 
      }
      */
    }
    
}
