import Foundation

open class AdjacencyList<T: Hashable> {
	// Use this dictionary to store your graph. The key is a Vertex and the value is an array of edges.
	public var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
	public init() {}	// need this line code 
}

extension AdjacencyList: Graphable {
	public typealias Element = T	// Since AAdjacencyList is also generic
	
	// MARK: - Public APIs
	
	// let you define print out a graph
	public var description: CustomStringConvertible {
		var result = ""
		for (vertex, edges) in adjacencyDict {
			var edgeString = ""
			for (index, edge) in edges.enumerated() {
				if index != edges.count - 1 {
					edgeString.append("\(edge.destination), ")
				} else {
					edgeString.append("\(edge.destination)")
				}
			}
			result.append("\(vertex)  --->  [ \(edgeString) ]\n")
		}
		return result
	}
	
	// MARK: - Graphable methods
	
	public func createVertex(data: Element) -> Vertex<Element> {
		let vertex = Vertex(data: data)
		
		if adjacencyDict[vertex] == nil {
			adjacencyDict[vertex] = []
		}
		
		return vertex
	}
	
	public func addEdge(type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
		switch type {
		case .directed:
			addDirectedEdge(from: source, to: destination, weight: weight)
		case .undirected:
			addUndirectedEdge(vertexs: (source, destination), weight: weight)
		}
	}
	
	public func getWeight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
		guard let edges = adjacencyDict[source] else {
			return nil
		}
		
		for edge in edges {
			if edge.destination == destination {
				return edge.weight
			}
		}
		
		return nil
	}
	
	public func getEdges(from source: Vertex<Element>) -> [Edge<Element>]? {
		guard let edges = adjacencyDict[source] else { return nil }
		return edges
	}
	
	// MARK: - Pirvate helpers
	
	fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
		let edge = Edge(source: source, destination: destination, weight: weight, edgeType: .directed)
		adjacencyDict[source]?.append(edge)
	}
	
	// NOTE: In an undirected edge, you can treat it as a directed edge that goes both ways.
	fileprivate func addUndirectedEdge(vertexs: (Vertex<Element>, Vertex<Element>), weight: Double?) {
		let (source, destination) = vertexs
		addDirectedEdge(from: source, to: destination, weight: weight)
		addDirectedEdge(from: destination, to: source, weight: weight)
	}
	
}
