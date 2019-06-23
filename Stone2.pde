class Stone2 extends Stone{
  
  
    Stone2(float x, float y){
    super(x, y);
    health=4;
    }
    
    // Display Cabbage
    void display(){
      image(stone2, x, y);
    }
    
     void checkCollision(Player player){
       if(itemIsHit(x, y, w, h, player.x, player.y, player.w, player.h)){ 
         health -= 1;
        if(health<=0){
        isAlive=false;
        x = y = -1000;
      }
    }
    

     }
   }
