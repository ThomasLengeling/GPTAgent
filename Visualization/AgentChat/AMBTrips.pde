void drawABMTrips(PGraphics pg) {

  pg.pushMatrix();
  pg.scale(roadScx, roadScy);
  pg.rotate(roadRot);
  pg.translate(roadTransX, roadTransY);
  roadNetwork.drawNetwork(pg);

  for (int i = 0; i < agents.size(); i++) {
    AgentPath ag = (AgentPath)agents.get(i);
    ag.update();
    ag.drawAgenPath(pg);
  }
  

  pg.popMatrix();
}
