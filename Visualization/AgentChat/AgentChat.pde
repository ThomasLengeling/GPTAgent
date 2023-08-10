
/**
 * Thomas Sanchez Lengeling
 Front-end visualization tool
 */

import netP5.*;
import oscP5.*;
import controlP5.*;
import java.util.Vector;
import hypermedia.net.*;
import java.util.Arrays;
import ai.pathfinder.*;

//viki
OscP5 oscP5;
NetAddress myRemoteLocation;
String remoteIP = "127.0.0.1";

// GlobalClock
GlobalClock globalClock;

//Agents
NetworkAgent networkAgents;

int remotePort = 6969;
UDP udp_analysis;

// import UDP library

PImage mapImg;
PImage interactiveImg;
PImage sateliteImage;
boolean drawBackgroundImg = true;

//road network
RoadNetwork roadNetwork;
float roadTransX = -65.0;
float roadTransY = -170.0;
float roadScx    = 1.018;//1.138; /
float roadScy    = 1.018;//1.138;
float roadRot    = 0.0;

//agents
ArrayList agents;


float incRec  = 1.68;
float increment = 0.02;

//rendering
PGraphics offScreen;
PGraphics spotOffScreen;

//mode change
int drawMode = 4;
int preDraMode = 0;

float scaleFactor = 1.0;

void setup() {

  size(1920, 1080, P3D);// img size

  //size(3508, 1080, P3D);
  frameRate(30);

  // setup Global Clock
  globalClock = new GlobalClock();

  String geoJSONBounds = "bounds.geojson";
  println("reading :"+geoJSONBounds);
  JSONObject JSONBounds = loadJSONObject(geoJSONBounds);
  JSONArray JSONBoundslines = JSONBounds.getJSONArray("bbox");
  setBoundingBox(JSONBoundslines);

  //ABM
  networkAgents = new NetworkAgent();


  offScreen = createGraphics(1920, 1080, P3D);
  // offScreen.hint(DISABLE_DEPTH_TEST);

  spotOffScreen  = createGraphics(1920, 1080, P3D);

  //offScreen.smooth(8);
  smooth(8);
  surface.setLocation(0, 0);
  surface.setResizable(false);

  mapImg = loadImage("cambridge.png");

  //road
  //morph_edges_extended
  roadNetwork = new RoadNetwork();
  String roadNetworkJson = "cambridge_roads.geojson";
  roadNetwork.loadNetwork(roadNetworkJson);


  //Agents
  agents = new ArrayList<AgentPath>();

  // create a new datagram connection on port 6000
  udp_analysis = new UDP( this, 15800 );
  udp_analysis.listen( true );

  //GUI
  createGUI();
}

//process events
void draw() {

  offScreen.beginDraw();
  offScreen.noStroke();
  offScreen.fill(0, 255);// - spotLight.counter*2.5);
  offScreen.rect(0, 0, offScreen.width, offScreen.height);
  //offScreen.image(map, 0, 0, offScreen.width, offScreen.height);


  float globalTime = globalClock.getCurrentTimeStamp();

  switch(drawMode) {
  case 3:
    drawABMTrips(offScreen);
    break;
  case 4://abm + interactive area
    if (drawBackgroundImg) {
      offScreen.image(mapImg, 0, 0, offScreen.width, offScreen.height);
    }

    //agents
    drawABMTrips(offScreen);

    //drawABMTrips(offScreen);
    break;
    //heat amps
  case 5:
    if (drawBackgroundImg) {
      offScreen.image(mapImg, 0, 0, offScreen.width, offScreen.height);
    }

    //road network
    drawABMTrips(offScreen);

    break;
  case 6:
    if (drawBackgroundImg) {
      offScreen.image(mapImg, 0, 0, offScreen.width, offScreen.height);
    }


    offScreen.pushStyle();
    offScreen.hint(ENABLE_DEPTH_TEST);
    offScreen.popStyle();

    break;
  }

  offScreen.endDraw();


  spotOffScreen.beginDraw();
  spotOffScreen.tint(255, 255);
  spotOffScreen.image(offScreen, 0, 0, spotOffScreen.width, spotOffScreen.height);
  spotOffScreen.endDraw();


  image(spotOffScreen, 0, 0, width, height);

  if (drawGUI) {
    cp5.draw();
  }

  textSize(28);
  int[] clockInfo = globalClock.getCurrentTime();
  String clockTxet = nf(clockInfo[0], 2) + ":" + nf(clockInfo[1], 2) + ":" +  nf(clockInfo[2], 2) + ":" +  nf(clockInfo[3], 2);
  text(clockTxet, 20, 80);
}



/**
 * on key pressed event:
 * send the current key value over the network
 */
void keyPressed() {

  //draw mode no roads
  if (key == 'q') {
    // frameRate(30);
    drawMode = 0;
    preDraMode = drawMode;
  }

  //draw grid with roads
  if (key == 'w') {
    //frameRate(30);
    drawMode = 1;
    preDraMode= drawMode;
  }

  //draw grid with roads
  if (key == 'e') {
    //frameRate(30);
    drawMode = 2;
    preDraMode = drawMode;
  }

  //roads AMB
  if (key == 'r') {
    // frameRate(10);
    drawMode = 3;
    preDraMode = drawMode;
  }

  //roads AMB
  if (key == 't') {
    //frameRate(30);
    drawMode = 4;
    drawBackgroundImg = false;
    preDraMode = drawMode;
  }

  if (key == 'y') {
    //frameRate(30);
    drawMode = 5;
    drawBackgroundImg = true;
    preDraMode = drawMode;
  }

  if (key == 'u') {
    //frameRate(30);
    drawMode = 6;
    drawBackgroundImg = true;
    preDraMode = drawMode;
  }

  //draw map
  if (key == 'm') {
    drawBackgroundImg = !drawBackgroundImg;
  }


  if (key == 't') {
  }
  if (key == 'p') {
    println("--");
  }

  if (key == '1') {
    activate = true;
    // send the message
    udp_analysis.send( testMsg, "127.0.0.1", 15800 );

    ///incRec+=0.01;
    //p/rintln("Inc rec: "+incRec);
  }

  if (key == '2') {
    incRec -=0.01;
    println("Inc rec: "+incRec);
  }

  if (key == 'g') {
    roadTransX +=5;
    println("roadTransX: "+roadTransX);
  }
  if (key == 'h') {
    roadTransX -=5;
    println("roadTransX: "+roadTransX);
  }
  if (key == 'b') {
    roadTransY +=5.0;
    println("roadTransY: "+roadTransY);
  }
  if (key == 'n') {
    roadTransY -=5.0;
    println("roadTransY: "+roadTransY);
  }
  //

  if (key == 'a') {
    roadRot += 0.01;
    println("roadRot: "+roadRot);
  }
  if (key == 's') {
    roadRot -= 0.01;
    println("roadRot: "+roadRot);
  }
  //
  if (key == 'z') {
    //roadMsy += 0.001;
    //createRoadNetwork();
    // println("roadMsy: "+roadMsy);
  }
  if (key == 'x') {
    // roadMsy -= 0.001;
    // createRoadNetwork();
    // println("roadMsy: "+roadMsy);
  }
  //
  if (key == 'd') {
    roadScx += 0.01;
    println("roadScx: "+roadScx);
  }
  if (key == 'f') {
    roadScx -= 0.01;
    println("roadScx: "+roadScx);
  }
  if (key == 'c') {
    roadScy += 0.01;
    println("roadScy: "+roadScy);
  }
  if (key == 'v') {
    roadScy -= 0.01;
    println("roadScy: "+roadScy);
  }

  if (key == '+') {
    int[] clockInfo = globalClock.getCurrentTime();
    globalClock.setGlobalClock(clockInfo[0] + 1, clockInfo[1], clockInfo[2], clockInfo[3]);
  }
  if (key == '-') {
    int[] clockInfo = globalClock.getCurrentTime();
    globalClock.setGlobalClock(clockInfo[0] - 1, clockInfo[1], clockInfo[2], clockInfo[3]);
  }
}
