class Soil {
  int col, row;
  int health;
  

  void display(){

    
      
      if(health==0){

      int soilColor = (int) (col/ 20);
      image(soilImages[soilColor][0], col * SOIL_SIZE, row * SOIL_SIZE,SOIL_SIZE,SOIL_SIZE);
      
      }else if (health==1){
      
      int soilColor = (int) (col/ 20);
      image(soilImages[soilColor][1],  col * SOIL_SIZE, row * SOIL_SIZE,SOIL_SIZE,SOIL_SIZE);
      

  }
  }

    Soil(int col, int row, int health ){
        this.health = health;
        this.col = col;
        this.row = row;
      }
}
