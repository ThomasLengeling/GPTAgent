

PVector mapSize;
float   mapScale;

PVector[] mapBounds;  // [0] Left-Top  [1] Right-Bottom



void loadBuildings() {
  buildings.loadBuildings("cambridge_buildings.geojson"); //test
  doneBuildings = true;
}

//bounding box
// FIND NODES BOUNDS -->
public void setBoundingBox(JSONArray JSONlines) {
  float minLat = Float.MAX_VALUE;
  float minLng = Float.MAX_VALUE;
  float maxLat = -Float.MAX_VALUE;
  float maxLng = -Float.MAX_VALUE;

  for (int i=0; i < int(JSONlines.size()/2.0); i++) {
    float Lat = JSONlines.getFloat(1 + i*2); //1
    float Lng = JSONlines.getFloat(0 + i*2); //0
    if ( Lat < minLat ) minLat = Lat;
    if ( Lat > maxLat ) maxLat = Lat;
    if ( Lng < minLng ) minLng = Lng;
    if ( Lng > maxLng ) maxLng = Lng;
  }

  // Conversion to Mercator projection -->
  println(minLat+" "+minLng+" "+maxLat+" "+maxLng);
  PVector coordsTL = toWebMercator(minLat, minLng);
  PVector coordsBR = toWebMercator(maxLat, maxLng);
  mapBounds = new PVector[] { coordsTL, coordsBR };
  println("coordsTL" + coordsTL + "coordsBR" + coordsBR);

  // Resize map keeping ratio -->
  float mapRatio = (coordsBR.x - coordsTL.x) / (coordsBR.y - coordsTL.y);
  mapSize = mapRatio < 1 ? new PVector( height * mapRatio, height ) : new PVector( width, width / mapRatio ) ;
  mapScale = (coordsBR.x - coordsTL.x) / mapSize.x;
}

// CONVERT TO WEBMERCATOR PROJECTION
private PVector toWebMercator( float lat, float lng ) {
  float RADIUS = 6378137f; // Earth Radius
  float sin = sin( radians(lat) );
  return new PVector(lng * radians(RADIUS), ( RADIUS / 2 ) * log( ( 1.0 + sin ) / ( 1.0 - sin ) ));
}

// LAT, LNG COORDINATES TO XY SCREEN POINTS -->
private PVector toXY(float lat, float lng) {
  PVector projectedPoint = toWebMercator(lat, lng);
  return new PVector(
    map(projectedPoint.x, mapBounds[0].x, mapBounds[1].x, 0, mapSize.x),
    map(projectedPoint.y, mapBounds[0].y, mapBounds[1].y, mapSize.y, 0));
}

//ABM Colors for each one of the profiles
color [] abmcolors         = {#5911F7, #FF86D7, #39C8FF, #00FFCE, #E000FF, #FDFF86, #ff2a6d, #ff7a33};
String agentsProfiles [] = {"dependents", "amenity", "students", "faculty", "r&d", "office", "industrial", "2ndHome"};

color getABMTypeColor(String mode) {

  if (mode.equals("Dependents") || mode.equals("0")) {
    return abmcolors[0];
  } else if (mode.equals("Amenity Workers")|| mode.equals("1")) {
    return abmcolors[1];
  } else if (mode.equals("Students")|| mode.equals("2")) {
    return abmcolors[2];
  } else if (mode.equals("Univ Faculty")|| mode.equals("3")) {
    return abmcolors[3];
  } else if (mode.equals("R&D Workers")  || mode.equals("4")) {
    return abmcolors[4];
  } else if (mode.equals("Office Workers")  || mode.equals("5")) {
    return abmcolors[5];
  } else if (mode.equals("Industrial Workers")|| mode.equals("6")) {
    return abmcolors[6];
  } else if (mode.equals("2nd Home Owners")|| mode.equals("7") ) {
    return abmcolors[7];
  } else {
    return abmcolors[1];
  }
}

int getABMType(String mode) {
  if (mode.equals("Dependents")) {
    return 0;
  } else if (mode.equals("Tourists")) {
    return 1;
  } else if (mode.equals("Amenity Workers")) {
    return 2;
  } else if (mode.equals("2nd Home Owners")) {
    return 3;
  } else if (mode.equals("Students")) {
    return 4;
  } else if (mode.equals("Univ Faculty")  ) {
    return 4;
  } else if (mode.equals("R&D Workers")) {
    return 5;
  } else if (mode.equals("Office Workers")) {
    return 5;
  } else if ( mode.equals("Industrial Workers")) {
    return 6;
  }
  return -1;
}
