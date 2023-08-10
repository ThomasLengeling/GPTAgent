/*
Simple agent that travels along a set of points
 */
class AgentPath {
  // baisc info
  int id;
  ArrayList points;
  ArrayList<Integer> timeStamp;
  ArrayList status;

  //positions & animate index
  PVector currentPosition;
  int prevIndex = 0;
  int nextIndex = 1;

  // agent status
  String statusMode = "move";
  boolean isAnimating = false;

  // point type
  int modeStatus = 1;
  color colorMode = color(0);
  color colorModeTmp = color(0);

  // optimization
  int prevTimeStamp;
  int nextTimeStamp;
  PVector prevPosition;
  PVector nextPosition;

  // sprint shape
  PShape part;  // The particle PShape
  float partSize;  // The particle size

  AgentPath() {
    currentPosition = new PVector();

    points = new ArrayList<PVector>();
    timeStamp = new ArrayList<Integer>();
    status = new ArrayList<String>();

    id = 0;
  }

  void addPoint(float x, float y, float z) {
    this.points.add(new PVector(x, y, z));
  }
  void addTime(int tstamp) {
    this.timeStamp.add(tstamp);
  }
  void addStatus(String stat) {
    this.status.add(stat);
  }

  void addMode(int mode) {
    this.modeStatus = mode;
  }
  void addId(int id) {
    this.id = id;
  }
  void addMode(String mode) {
    //this.mode =  Integer.parseInt(mode);
    colorMode = getABMTypeColor(mode);
    modeStatus = getABMType(mode);
  }

  void addModeTmp(String mode) {
    colorModeTmp = getABMTypeColor(mode);
  }

  void resetMode() {
    colorMode =colorModeTmp;
  }

  //add path point
  void addPoint(PVector point) {
    points.add(point);
  }

  //draw agents
  void drawAgents(PGraphics pg, int alpha) {
    if (isAnimating) {
      pg.pushStyle();

      // if (!startAnim) {
      //  pg.stroke(colorMode, 25);
      // } else {
      pg.stroke(colorMode, alpha);
      //}

      if (statusMode.equals("stay")) {
        pg.strokeWeight(floor(scaleFactor*3.5));
        pg.point( currentPosition.x, currentPosition.y, currentPosition.z);

        int step =3;
        pg.strokeWeight(floor(scaleFactor*3.5));
        pg.point( currentPosition.x + step, currentPosition.y + step, currentPosition.z);
        pg.point( currentPosition.x + step, currentPosition.y + 0, currentPosition.z);
        pg.point( currentPosition.x + 0, currentPosition.y + step, currentPosition.z);

        pg.point( currentPosition.x + 0, currentPosition.y - step, currentPosition.z);
        pg.point( currentPosition.x - step, currentPosition.y - 0, currentPosition.z);
        pg.point( currentPosition.x - step, currentPosition.y - step, currentPosition.z);
        pg.point( currentPosition.x + step, currentPosition.y - step, currentPosition.z);
        pg.point( currentPosition.x - step, currentPosition.y + step, currentPosition.z);
      } else {
        pg.strokeWeight(int(scaleFactor*2));
        pg.point( currentPosition.x, currentPosition.y, currentPosition.z);
      }
      pg.popStyle();
    } else {
      //agent has finished itrs trip
      pg.pushStyle();
      pg.stroke(colorMode, 20);
      pg.strokeWeight(ceil(scaleFactor*2.5));
      int step =2;
      pg.point( currentPosition.x, currentPosition.y, currentPosition.z);
      pg.point( currentPosition.x + step, currentPosition.y + step, currentPosition.z);
      pg.point( currentPosition.x + step, currentPosition.y + 0, currentPosition.z);
      pg.point( currentPosition.x + 0, currentPosition.y + step, currentPosition.z);
      pg.popStyle();
    }
    //}
  }


  //draw agent with its path
  void drawAgenPath(PGraphics pg) {
    if (!isAnimating) return;

    pg.strokeWeight(1);
    pg.noFill();
    pg.stroke(120, 30);
    pg.beginShape();
    for (int i = 3; i < points.size(); i++) {
      PVector pos = (PVector)points.get(i);
      pg.vertex(pos.x, pos.y, pos.z);
    }
    pg.endShape();
    // pg.popStyle();

    pg.pushMatrix();
    pg.lights();
    //pg.ambientLight(102, 102, 102);

    pg.sphereDetail(90);
    pg.translate(currentPosition.x, currentPosition.y, currentPosition.z);
    pg.stroke(colorMode, 50);
    pg.sphere(10);
    pg.popMatrix();
  }

  private void updateIndex(float currentTimeStamp) {

    int prevTimeStamp = timeStamp.get(prevIndex);
    int nextTimeStamp = timeStamp.get(nextIndex);
    boolean updated = false;

    // check if misplace happens, re-search whole array
    if ((prevTimeStamp > nextTimeStamp) || (currentTimeStamp < prevTimeStamp))
      for (int i = 0; i < points.size() - 1; i++)
        if ((currentTimeStamp > timeStamp.get(i)) && (currentTimeStamp < timeStamp.get(i + 1))) {
          prevIndex = i;
          nextIndex = i + 1;
          updated = true;
          break;
        }

    // move to next index
    if (currentTimeStamp > nextTimeStamp)
      for (int i = prevIndex; i < points.size() - 1; i++)
        if ((currentTimeStamp > timeStamp.get(i)) && (currentTimeStamp < timeStamp.get(i + 1))) {
          prevIndex = i;
          nextIndex = i + 1;
          updated = true;
          break;
        }

    if (updated) updateAgent();
  }

  void updateAgent() {
    statusMode = (String)status.get(prevIndex);
    prevPosition = (PVector)points.get(prevIndex);
    nextPosition = (PVector)points.get(nextIndex);
    prevTimeStamp = timeStamp.get(prevIndex);
    nextTimeStamp = timeStamp.get(nextIndex);
  }


  //update routine, check if the agents as finished its local path
  void update() {
    if (!isAnimating) return;
    if (points.size() <= 1) return;

    // update index
    float currentTimeStamp = globalClock.getCurrentTimeStamp();
    updateIndex(currentTimeStamp);

    float perc = 0;
    if (statusMode.equals("stay"))
      perc = 0;
    else// (statusMode.equals("move"))
      perc = (currentTimeStamp - prevTimeStamp) / (nextTimeStamp - prevTimeStamp);


    perc = Math.max(0, Math.min(perc, 1));
    currentPosition = PVector.lerp(prevPosition, nextPosition, perc);

  //  println("curr :"+currentPosition.x+", "+currentPosition.y+" "+perc+" "+currentTimeStamp);
   // println("next :"+nextPosition.x+ ", "+nextPosition.y+" "+prevTimeStamp);
   // println("prev :"+prevPosition.x+ ", "+prevPosition.y+" "+nextTimeStamp);
  }
}
