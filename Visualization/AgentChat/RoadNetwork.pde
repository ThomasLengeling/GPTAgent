import ai.pathfinder.*;

class RoadNetwork {

  PVector[] bounds;
  PVector size;
  float scale;
  
  Pathfinder graph;
  int id; //road network id file

  //
  void loadNetwork(String roadNetworkJSON) {
    ArrayList<Node> nodes = new ArrayList<Node>();

    // Load file -->
    JSONObject JSON = loadJSONObject(roadNetworkJSON);
    JSONArray JSONlines = JSON.getJSONArray("features");


    // Import all nodes -->
    Node prevNode = null;
    for (int i=0; i<JSONlines.size(); i++) {

      JSONObject props = JSONlines.getJSONObject(i).getJSONObject("properties");
      String type = props.isNull("type") ? "null" : props.getString("type");
      //String name = props.isNull("name") ? "null" : props.getString("name");
      //boolean oneWay = props.isNull("oneway") ? false : props.getBoolean("oneway");

      JSONArray points = JSONlines.getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
      for (int j=0; j<points.size(); j++) {
        // Point coordinates to XY screen position -->
        PVector pos = toXY(points.getJSONArray(j).getFloat(1), points.getJSONArray(j).getFloat(0));

        // Node already exists (same X and Y pos). Connect  -->
        Node existingNode = nodeExists(pos.x, pos.y, nodes);
        if (existingNode != null) {
          if (j>0) {
            prevNode.connect( existingNode);
            existingNode.connect(prevNode);
            //prevNode.connectBoth( existingNode, type, name, allowedAccess );
            //if(oneWay) existingNode.forbid(prevNode, RoadAgent.CAR);
          }
          prevNode = existingNode;

          // Node doesn't exist yet. Create it and connect -->
        } else {
          Node newNode = new Node(pos.x, pos.y);
          if (j>0) {
            prevNode.connect( newNode);
            newNode.connect( prevNode);
          }
          nodes.add(newNode);
          prevNode = newNode;
        }
      }
    }
    graph = new Pathfinder(nodes);
  }
  
  //check if node exist
  Node nodeExists(float x, float y, ArrayList<Node> nodes) {
    for (Node node : nodes) {
      if (node.x == x && node.y == y) {
        return node;
      }
    }
    return null;
  }


  void drawNetwork(PGraphics pg) {
    for (int i = 0; i < graph.nodes.size(); i++) {
      Node tempN = (Node)graph.nodes.get(i);
      for (int j = 0; j < tempN.links.size(); j++) {
        color c= #FFFFFF;
        //float weight = model.getAgentInsideROI(new PVector(tempN.x, tempN.y), int(legoGrid.cellsize)).size()/5.0;
        //if (weight<0.5) {
        //  c = lerpColor(legoGrid.c1, legoGrid.c2, weight*2);
        //} else {
        //  c = lerpColor(legoGrid.c2, legoGrid.c3, (weight-0.5)*2);
        //}
        pg.stroke(c);
        pg.strokeWeight(2);
        pg.line(tempN.x, tempN.y, ((Connector)tempN.links.get(j)).n.x, ((Connector)tempN.links.get(j)).n.y);
        pg.noStroke();
      }
    }
  }
}
