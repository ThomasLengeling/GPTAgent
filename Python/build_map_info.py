import networkx as nx
import osmnx as ox
import taxicab as tc
import geopandas as gpd
import geocoder
import json


class cityMap():
    def __init__(self, loaction) -> None:
        self.loaction = loaction
        self.which = "networkx"

    def getNetwork(self, network_type):
        """
        network_type ==> all_private, all, bike, drive, drive_service, walk
        """
        self.graph = ox.graph_from_place(self.loaction, network_type=network_type)
        nodes, edges = ox.graph_to_gdfs(self.graph)
        self.nodes = nodes
        self.edges = edges
    
    def plotNetwork(self, route_index=-1):
        if route_index == -1 and self.which == "networkx":
            ox.plot_graph(self.graph)
        elif self.which == "networkx":
            ox.plot_graph_route(self.graph, self.routes[route_index], route_color="c", node_size=1)
        elif self.which == "taxicab":
            tc.plot.plot_graph_route(self.graph, self.routes[0])


    def getRoute(self, coordinates):
        # print(coordinates)
        routes = []
        if self.which == "taxicab":
            # routes = [tc.distance.shortest_path(self.graph, (-71.1266, 42.3847), (-71.1127, 42.3781))]
            routes = [tc.distance.shortest_path(self.graph, coordinates[i], coordinates[i+1]) for i in range(len(coordinates)-1)]
        
        elif self.which == "networkx":
            for i in range(len(coordinates) - 1):
                # (lng, lat)
                ori = ox.nearest_nodes(self.graph, coordinates[i][0], coordinates[i][1])
                dis = ox.nearest_nodes(self.graph, coordinates[i+1][0], coordinates[i+1][1])
                routes.append(nx.shortest_path(self.graph, ori, dis, weight='travel_time'))
                # print(f'{i}: {coordinates[i]}: {ori} <> {coordinates[i+1]}: {dis} ==> {routes[i]}')

        self.routes = routes
        
                 

if __name__ == "__main__":
    from update_agent_schedule import Agents

    # ag = Agents(1)
    # ag.testAgent()
    # ag.addCoordinates()

    mmap = cityMap(loaction="Cambridge, MA, USA")

    mmap.getNetwork(network_type='drive')
    
    # print(f"agent coord num: {len(ag.agents_coords[0])}")
    tmpCoords = [[-71.08401, 42.36458], [-71.08401, 42.36458], [-71.08401, 42.36458], [-71.08473, 42.36225], [-71.08731, 42.36038], [-71.08744, 42.36065], [-71.08401, 42.36458], [-71.08995, 42.36798], [-71.08731, 42.36038], [-71.08899, 42.35941], [-71.08731, 42.36038], [-71.09125, 42.35984], [-71.0961, 42.35856], [-71.08401, 42.36458], [-71.08401, 42.36458], [-71.08401, 42.36458], [-71.08401, 42.36458], [-71.08401, 42.36458]]

    # mmap.getRoute(coordinates=ag.agents_coords[0])
    mmap.getRoute(coordinates=tmpCoords)
    
    mmap.plotNetwork(1)
    

