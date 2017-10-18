//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

/* Graph

A Graph is a useful data structure to capture relationships between objects, made up of a set of vertexs paired with a set of edges.

## Weighted Graph
You can associate a weight to every edge.

## Directed and Undirected Graphs
A directed graph, where edges have direction.
A directed graph can also be bidirectional, where two vertexs have two edges going back and forth.
An undirected graph, where there is no direction on edges.

## Representing a Graph
The two common ways to represent a graph is through an `adjacency matrix` or `adjacency list`.

# Adjacency List
The basic idea of an adjacency list is you store every single vertex, each vertex will hold a sub adjacency list.

# Approach
A few popular approaches to describe the adjacency list are:
- Stroing an array of arrays.		The outer array represents vertexs, providing an index. The inner array contains edges.
- Storing an array of linked-lists.	Each index in the array represents a vertex. Each value in the array stores a linked-list.
- Storing a dictionary of arrays.	Each key in the dictionary is a vertex, and each value is the corresponding array of edges.

*/

struct Constants {
	static let kSingapore = "Singapore"
	static let kTokyo = "Tokyo"
	static let kDetroit = "Detroit"
	static let kHongKong = "Hong Kong"
	static let kSanFrancisco = "San Francisco"
	static let kWashingtonDC = "Washington DC"
	static let kAustinTexas = "Austin Texas"
	static let kSeattle = "Seattle"
}

let adjacencyList = AdjacencyList<String>()

let singapore = adjacencyList.createVertex(data: Constants.kSingapore)
let tokyo = adjacencyList.createVertex(data: Constants.kTokyo)
let detroit = adjacencyList.createVertex(data: Constants.kDetroit)
let hongKong = adjacencyList.createVertex(data: Constants.kHongKong)
let sanFrancisco = adjacencyList.createVertex(data: Constants.kSanFrancisco)
let washingtonDC = adjacencyList.createVertex(data: Constants.kWashingtonDC)
let austinTexas = adjacencyList.createVertex(data: Constants.kAustinTexas)
let seattle = adjacencyList.createVertex(data: Constants.kSeattle)

adjacencyList.addEdge(type: .undirected, from: singapore, to: hongKong, weight: 300)
adjacencyList.addEdge(type: .undirected, from: singapore, to: tokyo, weight: 500)
adjacencyList.addEdge(type: .undirected, from: hongKong, to: tokyo, weight: 250)
adjacencyList.addEdge(type: .undirected, from: tokyo, to: detroit, weight: 450)
adjacencyList.addEdge(type: .undirected, from: tokyo, to: washingtonDC, weight: 300)
adjacencyList.addEdge(type: .undirected, from: hongKong, to: sanFrancisco, weight: 600)
adjacencyList.addEdge(type: .undirected, from: detroit, to: austinTexas, weight: 50)
adjacencyList.addEdge(type: .undirected, from: austinTexas, to: washingtonDC, weight: 292)
adjacencyList.addEdge(type: .undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
adjacencyList.addEdge(type: .undirected, from: washingtonDC, to: seattle, weight: 277)
adjacencyList.addEdge(type: .undirected, from: sanFrancisco, to: seattle, weight: 218)
adjacencyList.addEdge(type: .undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(adjacencyList.description)

print(adjacencyList.getEdges(from: sanFrancisco)!)

print(adjacencyList.getWeight(from: singapore, to: tokyo) ?? 0.0)
