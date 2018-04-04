import geomerative.*;
import processing.svg.*;

RFont f;
PFont f2;
RShape t2;
RShape shp;


// ON PASSE A TRUE POUR L'EXPORT SVG
boolean PROD = false;
String SVG_NAME = "22696907EN";
//


float factorX;
float factorY;
float cWidth;
int padB = 25;

JSONObject leAnimal;
float DENSITY;

// ON CHOISI UN DES ID EN DESSOUS
String ID = "22696907";


// CR 6234
// EN 22696907
// VU 22709717

String TOKEN = "d7951f807cda02991dc2e4a09677817093d43c5944ac008ba857700bfa2f34f6";
String URL = "http://apiv3.iucnredlist.org/api/v3/";

JSONObject json;

RPoint topLeft, bottomRight;

void setup(){
  size(1170,827);
  frameRate(60);
  background(255);
  fill(0);
  noStroke();
  
  if(PROD){
    cWidth = 1;
  }else{
    cWidth = 2;
  }
 
  if(PROD){
    noLoop();
    beginRecord(SVG, SVG_NAME + ".svg");
  }
  
  json = loadJSONObject(URL + "species/id/" + ID + "/?token=" + TOKEN);
  JSONArray leAnimalArray = json.getJSONArray("result");
  
  leAnimal = leAnimalArray.getJSONObject(0);
  
  print(leAnimal.getString("main_common_name"));
 
  RG.init(this);
  
  f = new RFont("FuturaB.ttf", 90, LEFT);
  
  shp = f.toShape(leAnimal.getString("main_common_name").toUpperCase());
  
  
  switch(leAnimal.getString("category")){
    case "CR":
      DENSITY = 7;
      factorX = 0.32;
      factorY = 0.2;
      break;
    case "EN":
      DENSITY = 5.6;
      factorX = 0.26;
      factorY = 0.09;
      break;
    case "VU":
      DENSITY = 3.4;
      factorX = 0.2;
      factorY = 0.06;
      break;

  }
  
  smooth(4);
  
  topLeft = shp.getTopLeft();
  bottomRight = shp.getBottomRight(); 
  
  float txtWidth = bottomRight.x - topLeft.x;
  
  translate(width/2 - txtWidth/2, height/2);
  
  for (float y = topLeft.y; y<bottomRight.y; y++) {
    float leY = map(y, topLeft.y, bottomRight.y, topLeft.x,bottomRight.x); 
    float xDivided = bottomRight.x / DENSITY;
    for (float x = topLeft.x; x<xDivided - leY / DENSITY; x++) {
      float rX = random(0, bottomRight.x - topLeft.x);
      boolean isInShape = shp.contains(new RPoint(rX, y));
      if(isInShape){
        float yOffset = (y-topLeft.y)*factorY;
        float randomY = random(-yOffset, yOffset);
        float xOffset = (y-topLeft.y)*factorX;
        float randomX = random(-xOffset, xOffset);
        fill(0, 0, 0);
        ellipse (rX + randomX,y + randomY,cWidth,cWidth);
      }
    }
  }
  
  if(PROD){
    endRecord();
  }
}

void draw(){

}
