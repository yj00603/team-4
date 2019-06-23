class Player {
  
  float x, y;
  float w = SOIL_SIZE, h = SOIL_SIZE;
  int col, row;
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 3 * SOIL_SIZE;

  int playerHealth = 3;
  int moveDirection = 0;
  int moveTimer = 0;
  int moveDuration = 15;




  void update(){
    PImage minerDisplay = minerGo;
    


if(moveTimer == 0){
  
  if(goState){

          minerDisplay = minerGo;
                if(x+w+w < width-cameraOffsetX){
                  if(col < SOIL_COL_COUNT - 1){
                  
                  if(row >= 0 && soil[col][row].health == 0){
              soil[col][row].health =1;
            }else{
                  
              moveDirection = RIGHT;
              moveTimer = moveDuration;
          // Check bottom boundary
          }
                }
                }
        

}else if(upState){
          minerDisplay = minerClimb;

          // Check left boundary
   
              
               if(row >0){
            soil[col][row ].health =1;
              moveDirection = UP;
              moveTimer = moveDuration;
            
         }

        }else if(downState){

          minerDisplay = minerClimb;

          // Check right boundary
       if(row < SOIL_ROW_COUNT -1){
            
              

            soil[col][row+1 ].health =1;
              moveDirection = DOWN;
              moveTimer = moveDuration;
            
            
         }
        }


    }else{
      
          // Draw image before moving to prevent offset
      switch(moveDirection){
        case UP:     minerDisplay = minerClimb;  break;
        case DOWN:   minerDisplay = minerClimb;  break;
        case RIGHT:  minerDisplay = minerGo;     break;
      }
    }


     if (minerDisplay==minerClimb)
     {for(int i=-4;i<10; i++){
        image(rope, x, y+SOIL_SIZE*i);
        }
     }
    image(minerDisplay, x, y);

    // If player is now moving?

    if(moveTimer > 0){

      moveTimer --;
      switch(moveDirection){

        case UP:
        minerDisplay = minerClimb;

        if(moveTimer == 0){
          row--;
          y = SOIL_SIZE * row;
        }else{
          y = (float(moveTimer) / moveDuration + row - 1) * SOIL_SIZE;
        }
        break;

        case DOWN:
        minerDisplay = minerGo;
        if(moveTimer == 0){
          row++;
          y = SOIL_SIZE * row;
        }else{
          y = (1f - float(moveTimer) / moveDuration + row) * SOIL_SIZE;
        }
        break;

        case RIGHT:
        minerDisplay = minerClimb;
        if(moveTimer == 0){
          col++;
          x = SOIL_SIZE * col;
        }else{
          x = (1f - float(moveTimer) / moveDuration + col) * SOIL_SIZE;
        }
        break;

      }

    }
  }


   void hurt(){
    playerHealth --;

    if(playerHealth == 0){

      gameState = GAME_OVER;

    }else{

      y += SOIL_SIZE;

    }
  }
  
  void dead(){

    if(x < 0-w-cameraOffsetX){
     gameOver.play();
     gameState = GAME_OVER;

    }
     if(x > 1200-w-cameraOffsetX){
     
     gameState = GAME_OVER;

    }
  }  
  
  Player(){
    playerHealth = 3;
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    col = (int) x / SOIL_SIZE;
    row = (int) y / SOIL_SIZE;
  }


}
