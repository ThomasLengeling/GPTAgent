/*
Load agents from a json file
 */
class NetworkAgent {
  ArrayList agents;
  PShape particleShape;

  NetworkAgent() {
    agents = new ArrayList<AgentPath>();
    particleShape = createShape(GROUP);
  }

  //load agents from json file
  void loadTrips(String path) {
    JSONArray  JSON_trips = loadJSONArray(path);
    println("trips "+JSON_trips.size());

    //only load HAFT the agents
    //change me
    for (int i = 0; i < JSON_trips.size(); i+=2) {
      JSONObject  paths  = JSON_trips.getJSONObject(i);//.getJSONObject("path");//getJSONArray("path");
      JSONArray   coords = paths.getJSONArray("coords");
      JSONArray   time   = paths.getJSONArray("timestamps");
      JSONArray   status = paths.getJSONArray("status");
      String      type   = paths.getString("profile");
      int         personId = paths.getInt("person_id");
      JSONArray   land_use = paths.getJSONArray("land_use");


      // println ("loc: "+coords.size());
      //println("new Path");

      AgentPath jsonAgent = new AgentPath();
      //jsonAgent.createSprint();
      jsonAgent.addMode(type);//getABMType(type));
      jsonAgent.addModeTmp(type);
      jsonAgent.addId(personId);

      int []  tstamps = time.getIntArray(); //time
      String []  aStatus = status.getStringArray(); //time

      for (int j = 0; j < coords.size(); j++) {
        JSONArray position = coords.getJSONArray(j);

        //x y positions
        float []  xypos = position.getFloatArray();
        PVector roadXY = toXY( xypos[1], xypos[0]);
        //roadXY.z =  map(xypos[2], 480, 1010, 0, maxZGeo);

        jsonAgent.addPoint(roadXY);
        jsonAgent.addTime(tstamps[j]);
        jsonAgent.addStatus(aStatus[j]);

        // println(roadXY.x+ " "+roadXY.y);
      }

      agents.add(jsonAgent);
      // particleShape.addChild(jsonAgent.getShape());
    }
    for (int i = 0; i < agents.size(); i++) {
      AgentPath ag = (AgentPath)agents.get(i);
      ag.updateAgent(); // init
      ag.isAnimating = true;
    }
  }

  //draw agents and update
  void drawUpdate(PGraphics pg) {
    pg.pushMatrix();
    for (int i = 0; i <agents.size(); i++) {///agents.size(); i++) { 8-9
      AgentPath ag = (AgentPath)agents.get(i);
      ag.update();
      ag.drawAgents(pg, 160);
    }
    pg.popMatrix();
  }

  void addSingleAgent(int id, float [] lat, float [] lng, int [] times, String [] status) {
    AgentPath jsonAgent = new AgentPath();
    //jsonAgent.createSprint();
    //jsonAgent.addMode(type);//getABMType(type));
    //jsonAgent.addModeTmp(type);
    jsonAgent.addId(id);


    for (int j = 0; j < lat.length; j++) {

      PVector roadXY = toXY(lat[j], lng[j]);
      //roadXY.z =  map(xypos[2], 480, 1010, 0, maxZGeo);

      jsonAgent.addPoint(roadXY);
      jsonAgent.addTime(times[j]);
      jsonAgent.addStatus(status[j]);

      // println(roadXY.x+ " "+roadXY.y);
    }

    agents.add(jsonAgent);
  }


  //draw agent only corresponding a particular profile
  void drawUpdateProfile(PGraphics pg, int profile) {
    pg.pushMatrix();
    for (int i = 0; i <agents.size(); i++) {///agents.size(); i++) { 8-9
      AgentPath ag = (AgentPath)agents.get(i);

      if (ag.modeStatus == profile) {
        ag.update();
        ag.drawAgents(pg, 160);
      }
    }

    pg.popMatrix();
  }


  //draw only 3 agents per 3 profiles
  void drawUpdateOnlyAgents(PGraphics pg) {
    pg.pushMatrix();
    boolean counters [] = {true, true, true};
    int countersn [] = {0, 0, 0};
    for (int i = 0; i < agents.size(); i++) {///agents.size(); i++) { 8-9

      AgentPath ag = (AgentPath)agents.get(i);
      ag.update();

      if (counters[0]) {
        if (ag.modeStatus == 0) {
          ag.drawAgents(pg, 180);
          countersn[0]++;
          if (countersn[0] >= 2) {
            counters[0] =false;
          }
        }
      }

      if (counters[1]) {
        if (ag.modeStatus == 1) {
          ag.drawAgents(pg, 180);
          countersn[1]++;
          if (countersn[1] >= 2) {
            counters[1] = false;
          }
        }
      }

      if (counters[2]) {
        if (ag.modeStatus == 2) {
          ag.drawAgents(pg, 180);
          countersn[2]++;
          if (countersn[2] >= 2) {
            counters[2] =false;
          }
        }
      }
    }
    pg.popMatrix();
  }


  //stop agents
  void endAnimation() {
    for (int i = 0; i <agents.size(); i++) {///agents.size(); i++) { 8-9
      AgentPath agi = (AgentPath)agents.get(i);
      agi.isAnimating = false;
    }
  }

  //draw collision potential
  void drawConnections(PGraphics pg) {
    pg.pushMatrix();
    pg.strokeWeight(2);

    for (int i = 0; i <agents.size(); i+=2) {///agents.size(); i++) { 8-9
      AgentPath agi = (AgentPath)agents.get(i);

      //if (agi.currentPosition.z <= 900) {
      for (int j = 0; j <agents.size(); j+=2) {
        AgentPath agj = (AgentPath)agents.get(j);

        float distc =  PVector.dist(agi.currentPosition, agj.currentPosition);
        if (distc >= 20 && distc <= 50) {
          pg.beginShape(LINES);
          pg.stroke(pg.lerpColor(agi.colorMode, agj.colorMode, 0.5), 30);
          pg.vertex(agi.currentPosition.x, agi.currentPosition.y, agi.currentPosition.z);
          pg.vertex(agj.currentPosition.x, agj.currentPosition.y, agj.currentPosition.z);
          pg.endShape();
        }
        // }
      }
    }
    pg.popMatrix();
  }
}
