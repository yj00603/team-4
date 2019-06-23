class Stone1 extends Stone{
  
  
    Stone1(float x, float y){
    super(x, y);
    health=2;
    }
    
    // Display Cabbage
    void display(){
      image(stone1, x, y);
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
