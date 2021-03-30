PImage bg, soil, groundhogDown,groundhogIdle,groundhogLeft,groundhogRight, soldier, cabbage, life,title, startNormal,startHovered,restartNormal,restartHovered, gameover;
int block = 80;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

int life2X= 80;
int life2Y= 10;

int life3X= 150;
int life3Y= 10;

int gameState=GAME_START ;

int soldierX = -block;
int soldierY = block*floor(random(2,6));
int soldierXSpeed = 3;

int cabbageX = block*floor(random(0,7));
int cabbageY = block*floor(random(2,5));

int groundhogInitialX = block*4;
int groundhogInitialY = block*1;

int groundhogX = block*4;
int groundhogY = block*1;

int groundhogSpeed = 80;

//for collision detect 
int soldierXRight= soldierX+80;
int soldierXLeft= soldierX;
int groundhogXRight= groundhogX+80;
int groundhogXLeft= groundhogX;

int soldierYButton= soldierY+80;
int soldierYTop= soldierY;
int groundhogYButton= groundhogY+80;
int groundhogYTop= groundhogY;
//

boolean downPressed, rightPressed,leftPressed;
final int HP1=1;
final int HP2=2;
final int HP3=3;

int hp = 2;

void setup() {
	size(640, 480, P2D);
	
  //GameStart Imgs
  title = loadImage ("img/title.jpg");
  startNormal =loadImage ("img/startNormal.png");
  startHovered =loadImage ("img/startHovered.png");
  
  //GameRun Imgs
  soil = loadImage ("img/soil.png");
  soldier = loadImage ("img/soldier.png");
  life = loadImage ("img/life.png");
  groundhogIdle=loadImage ("img/groundhogIdle.png");
  bg = loadImage ("img/bg.jpg");
  cabbage = loadImage("img/cabbage.png");
  
  //GameLose Imgs
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
}

void draw() {
	
  switch(gameState){
    case GAME_START:
      image(title,0,0);
      image(startNormal,248,360);
      if (mouseY >= 360 && mouseY<= 420){
        if(mouseX >= 248 && mouseX <= 392){
          image(startHovered,248,360);
          if(mousePressed){
            gameState = GAME_RUN;
          }
        }
      }
      break;
    
    case GAME_RUN:
    
      image(bg,0,0);
      image(soil,0,block*2);
      image(life,10,10);
      image(life,10+70*(hp-1),10);
      image(life,10+70*(hp-2),10);
      image(life,10+70*(hp-3),10);
      image(life,10+70*(hp-4),10);
      
      //draw the Sun and Grass
      fill(253,184,19);
      stroke(255,255,0);
      strokeWeight(5);
      ellipse (590,50,120,120); 
        
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      
      //show cabbage
      image(cabbage,cabbageX,cabbageY);
      
      //show soldier and make it move
      image(soldier,soldierX,soldierY);
      soldierX += soldierXSpeed;  
      if (soldierX >= 640){
          soldierX = -block;
        }
      //show groundhog
      image(groundhogIdle,groundhogX,groundhogY);
      
      //collision detect
        
      /*testing if (groundhogXLeft < soldierXRight  &&
      groundhogXRight > soldierXLeft &&
      groundhogYTop < soldierYButton &&
      groundhogYButton > soldierYTop){
      */
      
      if (groundhogY == soldierY &&
      groundhogX <= soldierX+80 &&
      groundhogX <= soldierX) {
        groundhogX = groundhogInitialX;
        groundhogY = groundhogInitialY;
        hp -= 1;
       
      }
      //eat cabbage to add lives
      if (groundhogX==cabbageX && groundhogY==cabbageY){
        cabbageX = block*floor(random(0,7));
        cabbageY = block*floor(random(2,5));
        image(cabbage,cabbageX,cabbageY);
        hp += 1; 
      }
      
      if (hp<=0){
        gameState = GAME_LOSE;
      }
      
      break;

    case GAME_LOSE:
    
      image(gameover,0,0);
      image(restartNormal,248,360);
      if (mouseY >= 360 && mouseY<= 420){
        if(mouseX >= 248 && mouseX <= 392){
          image(restartHovered,248,360);
          if(mousePressed){
            gameState = GAME_RUN;
            
          }
        }
      }
      hp=2;
      soldierX = -block;
      break;
    }
} 

void keyPressed(){
  switch(keyCode){
    case DOWN:
      downPressed = true;
      if (downPressed){
        groundhogY += groundhogSpeed;
        if (groundhogY>=height-80) groundhogY = height-80;
      }
      break;
    case LEFT:
      leftPressed = true;
      if (leftPressed){
        groundhogX -= groundhogSpeed;    
        if (groundhogX <=0) groundhogX = 0;
      }
      break;
    case RIGHT:
      rightPressed = true;
      if (rightPressed){
        groundhogX += groundhogSpeed;
        if (groundhogX >=width-80) groundhogX = width-80;
      }
      break;
   }
}  
void keyReleased(){
  switch(keyCode){
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
  }
}
