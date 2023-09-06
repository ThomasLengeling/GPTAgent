class Buildings {
  ArrayList<Building> buildings;

  Buildings() {
    buildings = new ArrayList<Building>();
  }

  void loadBuildings(String GeoJSONfile) {
    println("loading buildings");

    JSONObject JSON = loadJSONObject(GeoJSONfile);
    JSONArray JSONpolygons = JSON.getJSONArray("features");

    for (int i = 0; i < JSONpolygons.size(); i++) {
      JSONObject props = JSONpolygons.getJSONObject(i).getJSONObject("properties");

      String type  = props.isNull("type") ? "null" : props.getString("type");
      String usage = props.isNull("Usage") ? "null" : props.getString("Usage");
      String scale = props.isNull("Scale") ? "null" : props.getString("Scale");
      String category = props.isNull("Category") ? "null" : props.getString("Category");

      String geomType  = JSONpolygons.getJSONObject(i).getJSONObject("geometry").getString("type");
      if (geomType.equals("MultiPolygon") ) {
        JSONArray polygons  = JSONpolygons.getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
        println(polygons.size());

        for (int l = 0; l < polygons.size(); l++) {
          JSONArray poly = polygons.getJSONArray(l);
          PShape s = createShape();

          for (int j = 0; j < poly.size(); j++) {
            JSONArray points= poly.getJSONArray(j);

            //s.fill(colorMap.get(usage+scale));
            s.stroke(255);
            s.beginShape();
            for (int k = 0; k < points.size(); k++) {
              PVector pos =  new PVector(points.getJSONArray(k).getFloat(0), points.getJSONArray(k).getFloat(1), points.getJSONArray(k).getFloat(2));
              s.vertex(pos.x, pos.y);
            }
            s.endShape(CLOSE);
            Building b= new Building(s, usage, category);
            buildings.add(b);
          }
        }
      }
    }


    println("finish loading buildings");
  }

  void drawBuilings(PGraphics pg) {
    for (Building bui : buildings) {
      bui.draw(pg);
    }
  }
}

public class Building {
  PShape bShape;
  String usage;
  String category;

  Building(PShape bShape, String usage, String category) {
    this.bShape = bShape;
    this.usage = usage;
    this.category = category;
  }

  void draw(PGraphics pg) {
    pg.shape(bShape);
  }
}
