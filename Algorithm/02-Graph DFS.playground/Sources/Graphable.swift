import Foundation

// To create an protocol to build a graph.
protocol Graphable {
	associatedtype Element: Hashable	// This makes the protocol to be generic, to hold any type
	var description: CustomStringConvertible { get }	// let you define print out a graph 
	
	func createVertex(data: Element) -> Vertex<Element>
	func addEdge(type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
	func getWeight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
	func getEdges(from source: Vertex<Element>) -> [Edge<Element>]?
}
