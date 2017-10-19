//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

//: ![Demo Graph BFS](demoGraph.png)

enum Visit<Element: Hashable> {
	case source
	case edge(Edge<Element>)
}

extension Graphable {
	
	// BFS for any Graphable types
	public func breadthFirstSearch(from start: Vertex<Element>, to end: Vertex<Element>) -> [Edge<Element>]? {
		// Returns a route in edges which will take you from the source to the destination
		
		// To keep a record of your exploration, you’re going to replace your set of explored vertices with a dictionary, containing all your explored vertices and how you got there.
		var visits: [Vertex<Element> : Visit<Element>] = [start : .source]	// vertex keys and Visit values
		
		var queue = Queue<Vertex<Element>>()
		queue.enqueue(item: start)
		
		while let visitedVertex = queue.dequeue() {
			if visitedVertex == end {	// found the path/route
				// backtrack from then destination to the entrance
				var vertex = end
				var route: [Edge<Element>] = []
				
				// You created a while-loop, which will continue as long as the visits Dictionary has an entry for the vertex, and as long as that entry is an edge. If the entry is a source, then the while-loop will end.
				while let visit = visits[vertex], case .edge(let edge) = visit {
					// You added that edge to the start of your route, and set the vertex to that edge’s source. You’re now one step closer to the beginning.
					route = [edge] + route
					vertex = edge.source
				}
				
				return route
			}
			
			// enqueue the visited vertex's neighbors
			let neighborEdges = getEdges(from: visitedVertex) ?? []
			for edge in neighborEdges {
				if visits[edge.destination] == nil { // the vertex has not been enqueued yet
					queue.enqueue(item: edge.destination)	// vertexs to process
					visits[edge.destination] = .edge(edge)	// vertexs encountered, record the edge too
				}
			}
		}
		
		return nil	// no path/route
	}
	
	// DFS for any Graphable types
	func depthFirstSearch(from start: Vertex<Element>, to end: Vertex<Element>, graph: AdjacencyList<Element>) -> Stack<Vertex<Element>> {
		// store all the Vertexs that have been visited. To avoid infinite loop
		var visited = Set<Vertex<Element>>()
		
		var stack = Stack<Vertex<Element>>()
		
		// BFS
		stack.push(item: start)
		visited.insert(start)
		
		// Once the stack contains the end vertex, you have found a path from start to finish.
		outer: while let vertex = stack.peek(), vertex != end { // 1 keep peeking until vertex is the end/exit
			
			guard let neighbors = graph.getEdges(from: vertex), neighbors.count > 0 else { // 2 any neighbors
				// If none, means you reached a deadend. So backtrack by popping the current vertex off the stack.
				print("Backtrack-1 from \(vertex)")
				stack.pop()
				continue
			}
			
			for edge in neighbors { // 3 loop through each edge
				if !visited.contains(edge.destination) {
					visited.insert(edge.destination)
					stack.push(item: edge.destination)	// means this vertex is a potential candidate for the final path
					print("Current Path: \(stack)")
					continue outer	// branch off the vertex you just pushed, restarting the while loop
				}
			}
			
			print("Backtrack-2 from \(vertex)")	// 4 all edges visited
			stack.pop()
		}//End-while-loop
		
		return stack
	}
	
}//End-Graphable-extension

/* Graph Search

========= DFS ==========
Imagine yourself being shrunk down to the size of an ant. You fall into an ant nest, and have to find your way out. What strategy are you going to use?

In Depth-first search algorithm, you explore a branch as far as possible until you reach the end of the branch. At that point, you backtrack (go back a step), and explore the next available branch, until you find a way out.

## Use cases for depth-first search
-1. Topological sorting
-2. Detecting a cycle
-3. Pathfinding
-4. Finding connected components in a sparse graph
...

## Traversing Breadth-First Search vs. Depth-First Search
BFS: It visits every vertex's immediate neighbors before going to the next.

DFS: Assuming that it will always traverse the left side first before the right. It will start exploring all the vertexs on the left-most branch.
If the exit is not found, it will backtrack to the previous vertex, till it finds another path to explore.

========= BFS ==========
The idea behind Breadth-First Search is:
-1. Explore every single vertex within a set number of moves of the start/origin/source.
-2. Then, incrementally increase the number of moves until the destination is found.

The breadth first search algorithm works as follows:
-1. Search your current vertex. If this is the destination, stop searching.
-2. Search the neighbors of your current vertex. If any of them are destination, stop searching.
-3. Search all the neighbors of those vertexs. If any of them are the destination, stop searching.
-4. Eventually, If there is a route to the destination, you will find it, and always in the fewest number of moves from the start/source/origin.

*/

struct Constants {
	static let kS = "S"		// Start Vertex
	static let kE = "E"		// End/Exit Vertex
	
	static let kA = "A"		// Some middle vertexs
	static let kB = "B"
	static let kC = "C"
	static let kD = "D"
	static let kF = "F"
	static let kG = "G"
}

let adjacencyList = AdjacencyList<String>()

let vertexS = adjacencyList.createVertex(data: Constants.kS)
let vertexE = adjacencyList.createVertex(data: Constants.kE)
let vertexA = adjacencyList.createVertex(data: Constants.kA)
let vertexB = adjacencyList.createVertex(data: Constants.kB)
let vertexC = adjacencyList.createVertex(data: Constants.kC)
let vertexD = adjacencyList.createVertex(data: Constants.kD)
let vertexF = adjacencyList.createVertex(data: Constants.kF)
let vertexG = adjacencyList.createVertex(data: Constants.kG)

adjacencyList.addEdge(type: .undirected, from: vertexS, to: vertexA, weight: 300)
adjacencyList.addEdge(type: .undirected, from: vertexA, to: vertexB, weight: 450)
adjacencyList.addEdge(type: .undirected, from: vertexA, to: vertexC, weight: 500)
adjacencyList.addEdge(type: .undirected, from: vertexA, to: vertexD, weight: 250)
adjacencyList.addEdge(type: .undirected, from: vertexB, to: vertexD, weight: 300)
adjacencyList.addEdge(type: .undirected, from: vertexD, to: vertexG, weight: 600)
adjacencyList.addEdge(type: .undirected, from: vertexD, to: vertexF, weight: 50)
adjacencyList.addEdge(type: .undirected, from: vertexF, to: vertexE, weight: 292)

//print(adjacencyList.description)		// print the graph

// Q: Given a directed or undirected graph, use DFS to find a path between two vertexs.
func depthFirstSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) -> Stack<Vertex<String>> {
	// store all the Vertexs that have been visited. To avoid infinite loop
	var visited = Set<Vertex<String>>()
	
	var stack = Stack<Vertex<String>>()
	
	// BFS
	stack.push(item: start)
	visited.insert(start)
	
	// Once the stack contains the end vertex, you have found a path from start to finish.
	outer: while let vertex = stack.peek(), vertex != end { // 1 keep peeking until vertex is the end/exit
		
		guard let neighbors = graph.getEdges(from: vertex), neighbors.count > 0 else { // 2 any neighbors
			// If none, means you reached a deadend. So backtrack by popping the current vertex off the stack.
			print("Backtrack-1 from \(vertex)")
			stack.pop()
			continue
		}
		
		for edge in neighbors { // 3 loop through each edge
			if !visited.contains(edge.destination) {
				visited.insert(edge.destination)
				stack.push(item: edge.destination)	// means this vertex is a potential candidate for the final path
				print("Current Path: \(stack)")
				continue outer	// branch off the vertex you just pushed, restarting the while loop
			}
		}
		
		print("Backtrack-2 from \(vertex)")	// 4 all edges visited
		stack.pop()
	}//End-while-loop
	
	return stack
}

//print(depthFirstSearch(from: vertexS, to: vertexE, graph: adjacencyList))

// NOTE: Left-most branch first search
// So from S to C, the backtrack vertexs are G, E, F, D, B
//print(depthFirstSearch(from: vertexS, to: vertexC, graph: adjacencyList))

//adjacencyList.depthFirstSearch(from: vertexS, to: vertexC, graph: adjacencyList)	// wroks

if let edges = adjacencyList.breadthFirstSearch(from: vertexS, to: vertexG) {
	print(edges)
}
