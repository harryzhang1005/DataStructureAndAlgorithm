import Foundation

public struct Vertex<T: Hashable> {
	// Any relationship, Such as airline flights, a person, city, street address, etc.
	let data: T
}

// Since you are storing a Vertex as a custom key in a dictionary, it has to conform to Hashable protocol.
extension Vertex: Hashable {
	public var hashValue: Int {
		return "\(data)".hashValue
	}
	
	// Conform to Equatable protocol
	static public func ==(lhs: Vertex, rhs: Vertex) -> Bool {
		return lhs.data == rhs.data
	}
}

extension Vertex: CustomStringConvertible {
	public var description: String {
		return "\(data)"
	}
}
