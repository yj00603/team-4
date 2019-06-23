
PImage[][] soilImages;
PImage[][] stoneImages;
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage life,minerGo,minerClimb,diamond,ore,ruby,stone1,stone2,trap,path0,path1,rope,light;
PFont font;
float scoreTextMinSize = 72;
float scoreTextMaxSize = 96;
float scoreTextSize = scoreTextMinSize;

boolean downPressed=false;
boolean upPressed=false;
boolean rightPressed=false;



final int SOIL_COL_COUNT = 100;
final int SOIL_ROW_COUNT = 5;
final int SOIL_SIZE = 120;

final int START_BUTTON_WIDTH = 120;
final int START_BUTTON_HEIGHT = 120;
final int START_BUTTON_X = 540;
final int START_BUTTON_Y = 460;

boolean goState = false;
boolean upState = false;
boolean downState = false;
boolean soilIsAlive=true;
Player player;
Soil[][] soil;
Item[] items;
Stone[] stones;
Trap[] traps;
//Pos[] storepos;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

int cameraOffsetX = 0;
boolean debugMode = false;
int score =0;
int totalScore;


import ddf.minim.*;
Minim minim;
AudioPlayer gameOver;
AudioPlayer song;
AudioPlayer pooka;
AudioPlayer hurt;
AudioPlayer pick;
boolean isPlaying;

void setup()
{
    size(1200, 600, P2D);

    font = createFont("ObelixPro.ttf", 64, true);
    textFont(font);


    title = loadImage("img/title.png");
    gameover = loadImage("img/gameover.jpg");
    startNormal = loadImage("img/startNormal.png");
    startHovered = loadImage("img/startHovered.png");
    restartNormal = loadImage("img/restartNormal.png");
    restartHovered = loadImage("img/restartHovered.png");
    minerGo = loadImage("img/minerGo.png");
    minerClimb=loadImage("img/minerClimb.png");
    diamond=loadImage("img/diamond.png");
    ore=loadImage("img/ore.png");
    ruby=loadImage("img/ruby.png");
    stone1=loadImage("img/stone1.png");
    stone2=loadImage("img/stone2.png");
    trap=loadImage("img/trap.png");
    rope=loadImage("img/rope.png");
    life=loadImage("img/life.png");
    light=loadImage("img/light.png");
    
    
    minim = new Minim(this);

 

    // this loads mp3 from the data folder

    gameOver = minim.loadFile("gameOver.wav");
    pooka = minim.loadFile("Pooka.mp3");
    song = minim.loadFile("go.mp3");
    hurt = minim.loadFile("hurt.wav");
    pick = minim.loadFile("pick.wav");
    
    //song.loop();



    isPlaying = false;
    
    

    soilImages = new PImage[5][4];
    for(int i=0; i<soilImages.length; i++)
    {
        for(int j = 0; j < soilImages[i].length; j++)
        {
            soilImages[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".jpg");
        }
    }

    // Initialize Game
    initGame();

}



void initGame()
{
    player = new Player();
    soil = new Soil[SOIL_COL_COUNT][SOIL_ROW_COUNT];

    items = new Item[150];

    
    Pos[] storepos = new Pos[150];
    for(int i=0;i<storepos.length;i++)
    {
        storepos[i]=new Pos();
    }
   for(int m = 0; m<25; m++){
    for(int i = 0; i < 6; i++)
    {

        float newX = SOIL_SIZE * ( floor(random(4)+1)+4*m);
        float newY = SOIL_SIZE * ( floor(random(5)));

        //儲存位置
        storepos[6*m+i].xpos=newX;
        storepos[6*m+i].ypos=newY;
        boolean flag=true; //宣告flag 初始值

        for(int k=0; k<i; k++)//檢查有沒有重複位置 ，有就flag設false。
        {
            if(storepos[6*m+k].xpos==storepos[6*m+i].xpos&&storepos[6*m+k].ypos==storepos[6*m+i].ypos)
            {
                flag=false;
                break;
            }
        }

        if(!flag) //如果有一樣位置的就重新來一遍。
        {
            i--;
            continue;
        }

        switch(i)
        {
        case 0:
        case 1:
        case 2:
            items[6*m+i] = new Ore(newX, newY);
            break;
        case 3:
        case 4:
            items[6*m+i] = new Ruby(newX, newY);
            break;
        case 5:
            items[6*m+i] = new Diamond(newX, newY);
            break;

        }
     }
    }

    stones = new Stone[160];

    
    Pos[] storepos1 = new Pos[160];
    for(int i=0;i<storepos1.length;i++)
    {
        storepos1[i]=new Pos();
    }
   for(int m = 0; m<25; m++){
    for(int i = 0; i < 6; i++)
    {

        float newX = SOIL_SIZE * ( floor(random(4)+1)+4*m);
        float newY = SOIL_SIZE * ( floor(random(5)));

        //儲存位置
        storepos1[6*m+i].xpos=newX;
        storepos1[6*m+i].ypos=newY;
        boolean flag=true; //宣告flag 初始值

        for(int k=0; k<i; k++)//檢查有沒有重複位置 ，有就flag設false。
        {
            if(storepos1[6*m+k].xpos==storepos1[6*m+i].xpos&&storepos1[6*m+k].ypos==storepos1[6*m+i].ypos)
            {
                flag=false;
                break;
            }
        }

        if(!flag) //如果有一樣位置的就重新來一遍。
        {
            i--;
            continue;
        }
       switch(i)
        {
        case 0:
            stones[6*m+i] = new Stone1(newX, newY);
            break;
        case 1:
            stones[6*m+i] = new Stone2(newX, newY);
            break;
        }
      }
    }
    
             
    traps = new Trap[50];

    
    Pos[] storepos2 = new Pos[50];
    for(int i=0;i<storepos2.length;i++)
    {
        storepos2[i]=new Pos();
    }
   for(int m = 0; m<25; m++){
    for(int i = 0; i < 2; i++)
    {

        float newX = SOIL_SIZE * ( floor(random(4)+1)+4*m);
        float newY = SOIL_SIZE * ( floor(random(4)));

        //儲存位置
        storepos2[2*m+i].xpos=newX;
        storepos2[2*m+i].ypos=newY;
        boolean flag=true; //宣告flag 初始值

        for(int k=0; k<i; k++)//檢查有沒有重複位置 ，有就flag設false。
        {
            if(storepos2[2*m+k].xpos==storepos2[2*m+i].xpos&&storepos2[2*m+k].ypos==storepos2[2*m+i].ypos)
            {
                flag=false;
                break;
            }
        }

        if(!flag) //如果有一樣位置的就重新來一遍。
        {
            i--;
            continue;
        }
       switch(i)
        {
        case 0:  case 1:
            traps[2*m+i] = new Trap(newX, newY);
            break;

        }
      }
    }
 
    for(int i = 0; i < soil.length; i++)
    {
        for (int j = 0; j < soil[i].length; j++)
        {
            // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
            soil[i][j] = new Soil(i, j, 0 );



            if (goState == true)
            {
                soil[i][j].health=1;
            }
            if (player.y==player.y+120)
            {
                soil[i][j].health=2;
            }
            if (player.y==player.y-120)
            {
                soil[i][j].health=3;
            }

        }
    }


}


void draw(){
  
  switch (gameState) {

    case GAME_START: // Start Screen
    pooka.play();
    image(title, 0, 0);
    image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    if(isMouseHit(START_BUTTON_X, START_BUTTON_Y, START_BUTTON_WIDTH, START_BUTTON_HEIGHT)) {

      image(startHovered, 0, 0);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }
    }

    break;

    case GAME_RUN:
    
        if(cameraOffsetX > -120*100+width)
    {
        if(player.x >= SOIL_SIZE*5 && player.x <= SOIL_SIZE*19)
        {
            debugMode = true;
            cameraOffsetX -=2;
        }
        else if(player.x >= SOIL_SIZE*20 && player.x <= SOIL_SIZE*39)
        {
            debugMode = true;
            cameraOffsetX -=3;
        }
        else if(player.x >= SOIL_SIZE*40 && player.x <= SOIL_SIZE*59)
        {
            debugMode = true;
            cameraOffsetX -=4;
        }
        else if(player.x >= SOIL_SIZE*60 && player.x <= SOIL_SIZE*79)
        {
            debugMode = true;
            cameraOffsetX -=5;
        }
        else if(player.x >= SOIL_SIZE*80 && player.x <= SOIL_SIZE*99)
        {
            debugMode = true;
            cameraOffsetX -=6;
        }
    }
    if (debugMode)
    {
        pushMatrix();
        translate(cameraOffsetX, 0);
    }


        for(int i = 0; i < SOIL_COL_COUNT; i++)
        {
            for(int j = 0; j < SOIL_ROW_COUNT; j++)
            {
                soil[i][j].display();
            }
        }

       

        for(Item e : items)
        {
            if(e == null) continue;
              e.update();
              e.display();
            if(player.x == e.x-120 && player.y == e.y){
              goState = false;
            }
            if(player.x == e.x && player.y == e.y+120){
              upState = false;
            }
            if(player.x == e.x && player.y == e.y-120){
              downState = false;
            }
                }

        for(Stone e : stones)
        {
            if(e == null) continue;
            e.display();
            if(player.x == e.x-120 && player.y == e.y){
              goState = false;
            }
            if(player.x == e.x && player.y == e.y+120){
              upState = false;
            }
            if(player.x == e.x && player.y == e.y-120){
              downState = false;
            }
        }
        for(Trap e : traps)
        {
            if(e == null) continue;
            e.display();
            e.checkCollision(player);
                   
        }
       

       player.update();

       image(light,player.x-1200+120,player.y-600);
        for(int i = 0; i < player.playerHealth; i++){
          image(life, width-cameraOffsetX-130- i * 130, 10);
       }
       player.dead();
       if(player.playerHealth <= 0) gameState = GAME_OVER;
          if (debugMode)
    {
        popMatrix();
    } 
        drawScore();
    break;
       
    case GAME_OVER:
    image(gameover, 0, 0);
    song.pause();
    gameOver.play();
    gameScore();

    if(isMouseHit(START_BUTTON_X, START_BUTTON_Y, START_BUTTON_WIDTH, START_BUTTON_HEIGHT)) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
        pooka.cue(0);
        pooka.play();
        song.cue(0);
        score = 0;
        initGame();
        cameraOffsetX = 0;
      }

    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
 

    }










}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh)
{
    return  ax + aw < bx &&    // a right edge past b left
            ax > bx + bw &&    // a left edge past b right
            ay + ah < by &&    // a top edge past b bottom
            ay > by + bh;
}

boolean itemIsHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh)
{
    return  ax ==  bx+bw &&
            ay == by;
}
boolean stopIsHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh)
{
    return  ax ==  bx+bw && ay == by ||
            ax ==  bx &&  ay == by - bw ||   // a top edge past b bottom
            ax ==  bx &&  ay == by + bw;
}

boolean isMouseHit(float bx, float by, float bw, float bh){
  return  mouseX > bx && 
        mouseX < bx + bw && 
        mouseY > by && 
        mouseY < by + bh;
}


void addScore(float score)
{
    totalScore += score;
}
void drawScore()
{
    scoreTextSize = lerp(scoreTextSize, scoreTextMinSize, 0.12);
    textAlign(15, CENTER);
    textSize(scoreTextSize);
    fill(#ffffff, 100);
    text(score, 15, 50);
}

void gameScore()
{
    scoreTextSize = lerp(50, scoreTextMinSize, 0.12);
    textSize(scoreTextSize);
    fill(#000000, 150);
    textAlign(CENTER, CENTER);
    text("Your Score", width/2,180 );
    text(score, width/2,330 );
}

void keyPressed()
{
    if(key==CODED )
    { 
      if(gameState==1){
        pooka.pause();
        song.play();
      
        switch(keyCode)
        {
        case RIGHT:
            goState = true;

            break;
        case UP:
            upState = true;

            break;
        case DOWN:
            downState = true;

            break;
        }
    }
 }
  
    else if(key== ' ')
    {
        for(Item e : items)
        {
            if(e == null) continue;
            e.checkCollision(player);
        }
        for(Stone e : stones)
        {
            if(e == null) continue;
            e.checkCollision(player);
        }

    }

}

void keyReleased()
{
    if(key==CODED)
    {
        switch(keyCode)
        {
        case RIGHT:
            goState = false; 
            break;
        case UP:
            upState = false;
            break;
        case DOWN:
            downState = false;
            break;
        }
    }
}
