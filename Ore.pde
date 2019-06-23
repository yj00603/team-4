class Ore extends Item{
  float oreScore=100;
  
  
    Ore(float x, float y){
    super(x, y);
    health=2;
    }
    
    // Display Cabbage
    void display(){
      image(ore, x, y);
    }
    
      // Check collision with player
    void checkCollision(Player player){
      
      if(itemIsHit(x, y, w, h, player.x, player.y, player.w, player.h)){
       health -= 1;
        if(health<=0){
        isAlive=false;
        pick.cue(0);
        pick.play();
        score+=oreScore;
        x = y = -1000;
      }
      }
      /*if(health<=0){
        isAlive=false;
        score+=oreScore;
        x = y = -1000; 
      }
      */
    }
    
}
