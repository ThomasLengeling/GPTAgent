import hypermedia.net.*; //<>// //<>//

String testMsg = "[\n  {\n    \"Person_id\": 0,\n    \"Profile\": {\n      \"Name\": \"John Smith\",\n      \"Age\": 26,\n      \"Nationality\": \"American\",\n      \"Academic Background\": \"University of California, Berkeley\",\n      \"Research Interests\": [\n        \"Sustainable urban systems\",\n        \"Equitable city design\",\n        \"Resilience in urban infrastructure\",\n        \"Data-driven urban planning\",\n        \"Smart cities\"\n      ],\n      \"Residence\": \"303 3rd St, Cambridge, MA 02142, USA\",\n      \"Personal Interests\": [\n        \"Cycling\",\n        \"Sustainability\",\n        \"Reading\",\n        \"Cooking\",\n        \"Podcasts\",\n        \"Photography\"\n      ],\n      \"Skills\": [\n        \"Python\",\n        \"R\",\n        \"GIS\",\n        \"Basic machine learning\",\n        \"Communication\",\n        \"Data analysis\",\n        \"Project management\"\n      ]\n    },\n    \"coords\": [\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.083472,\n        -71.083472\n      ],\n      [\n        -71.0837939,\n        -71.0837939\n      ],\n      [\n        -71.0843197,\n        -71.0843197\n      ],\n      [\n        -71.084407,\n        -71.084407\n      ],\n      [\n        -71.0851555,\n        -71.0851555\n      ],\n      [\n        -71.085167,\n        -71.085167\n      ],\n      [\n        -71.085167,\n        -71.085167\n      ],\n      [\n        -71.0853823,\n        -71.0853823\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0882048,\n        -71.0882048\n      ],\n      [\n        -71.088217,\n        -71.088217\n      ],\n      [\n        -71.0899422,\n        -71.0899422\n      ],\n      [\n        -71.0893731,\n        -71.0893731\n      ],\n      [\n        -71.0879238,\n        -71.0879238\n      ],\n      [\n        -71.0824513,\n        -71.0824513\n      ],\n      [\n        -71.0827668,\n        -71.0827668\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0827668,\n        -71.0827668\n      ],\n      [\n        -71.0824513,\n        -71.0824513\n      ],\n      [\n        -71.0823709,\n        -71.0823709\n      ],\n      [\n        -71.0844274,\n        -71.0844274\n      ],\n      [\n        -71.0860568,\n        -71.0860568\n      ],\n      [\n        -71.0880928,\n        -71.0880928\n      ],\n      [\n        -71.0882196,\n        -71.0882196\n      ],\n      [\n        -71.0909338,\n        -71.0909338\n      ],\n      [\n        -71.0907622,\n        -71.0907622\n      ],\n      [\n        -71.0907622,\n        -71.0907622\n      ],\n      [\n        -71.0909338,\n        -71.0909338\n      ],\n      [\n        -71.0882196,\n        -71.0882196\n      ],\n      [\n        -71.0880928,\n        -71.0880928\n      ],\n      [\n        -71.0894757,\n        -71.0894757\n      ],\n      [\n        -71.0899422,\n        -71.0899422\n      ],\n      [\n        -71.0882048,\n        -71.0882048\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0876473,\n        -71.0876473\n      ],\n      [\n        -71.0871703,\n        -71.0871703\n      ],\n      [\n        -71.090535,\n        -71.090535\n      ],\n      [\n        -71.090535,\n        -71.090535\n      ],\n      [\n        -71.0947599,\n        -71.0947599\n      ],\n      [\n        -71.0950896,\n        -71.0950896\n      ],\n      [\n        -71.0950896,\n        -71.0950896\n      ],\n      [\n        -71.0930839,\n        -71.0930839\n      ],\n      [\n        -71.0948847,\n        -71.0948847\n      ],\n      [\n        -71.0899422,\n        -71.0899422\n      ],\n      [\n        -71.0893731,\n        -71.0893731\n      ],\n      [\n        -71.0879238,\n        -71.0879238\n      ],\n      [\n        -71.0824513,\n        -71.0824513\n      ],\n      [\n        -71.0827668,\n        -71.0827668\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ],\n      [\n        -71.0847663,\n        -71.0847663\n      ]\n    ],\n    \"timestamps\": [\n      0,\n      420,\n      480,\n      489,\n      498,\n      506,\n      515,\n      523,\n      532,\n      540,\n      560,\n      580,\n      600,\n      660,\n      667,\n      674,\n      680,\n      687,\n      694,\n      700,\n      707,\n      714,\n      720,\n      726,\n      732,\n      738,\n      744,\n      750,\n      756,\n      762,\n      768,\n      774,\n      780,\n      788,\n      795,\n      803,\n      810,\n      818,\n      825,\n      833,\n      840,\n      900,\n      960,\n      980,\n      1000,\n      1020,\n      1040,\n      1060,\n      1080,\n      1087,\n      1094,\n      1100,\n      1107,\n      1114,\n      1120,\n      1127,\n      1134,\n      1140,\n      1200,\n      1260,\n      1320\n    ],\n    \"status\": [\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Stay\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Bike\",\n      \"Walk\",\n      \"Walk\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Walk\",\n      \"Bike\",\n      \"Stay\",\n      \"Stay\",\n      \"Stay\"\n    ],\n    \"person_id\": 0\n  }\n]";
boolean activate = false;

void receive( byte[] data, String ip, int port ) {  // <-- extended handl

  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  //byte [] ndata = subset(data, 0, data.length-1);

  //String [] message = new String( ndata ).split(" ");

  String messageIn = new String( data );
  //messageIn = messageIn.substring(1, messageIn.length() - 1);
  String st = "hola";
  //println(st);
  //println(messageIn);

  JSONArray json_trips = parseJSONArray(messageIn);

  if (activate) {
    json_trips = parseJSONArray(testMsg);
    activate = false;
  }

  if (json_trips !=  null) {
    println(json_trips);

    JSONObject  paths  = json_trips.getJSONObject(0);//.getJSONObject("path");//getJSONArray("path");
    JSONArray   coords = paths.getJSONArray("coords");
    JSONArray   time   = paths.getJSONArray("timestamps");
    JSONArray   status = paths.getJSONArray("status");
    int         personId = paths.getInt("Person_id");
    JSONObject   land_use = paths.getJSONObject("Profile");
    // println ("loc: "+coords.size());
    //println("new Path");

    AgentPath jsonAgent = new AgentPath();
    jsonAgent.addId(personId);

    int []  tstamps = time.getIntArray(); //time
    String []  aStatus = status.getStringArray(); //time

    float latA[] = new float[ coords.size() ];
    float lngA[] = new float[ coords.size() ];

    // iterate over the activities
    for (int i = 0; i < coords.size(); i++) {
      JSONArray position = coords.getJSONArray(i);

      //x y positions
      float []  xypos = position.getFloatArray();
      PVector roadXY = toXY( xypos[1], xypos[0]);
      //roadXY.z =  map(xypos[2], 480, 1010, 0, maxZGeo);

      jsonAgent.addPoint(roadXY);
      jsonAgent.addTime(tstamps[i]*60);
      jsonAgent.addStatus(aStatus[i]);
    }
          jsonAgent.updateAgent(); // init
      jsonAgent.isAnimating = true;
    
    agents.add(jsonAgent);
    





    println("agent created");
  } else {
    println("error format json");
  }
}
