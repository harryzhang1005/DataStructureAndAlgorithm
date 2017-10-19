import Foundation

public enum EdgeType {
	case directed, undirected
}

public struct Edge<T: Hashable> {
	public var source: Vertex<T>
	public var destination: Vertex<T>
	
	public var weight: Double? = 0
	public var edgeType: EdgeType = .undirected
}

extension Edge: Hashable {
	public var hashValue: Int {
		return "\(source)\(destination)\(weight!)".hashValue
	}
	
	public static func ==(lhs: Edge, rhs: Edge) -> Bool {
		return lhs.weight == rhs.weight && lhs.source == rhs.source && lhs.destination == rhs.destination
	}
}

extension Edge: CustomStringConvertible {
	public var description: String {
		return "\(source) -> \(destination) and \(weight!)\n"
	}
}
