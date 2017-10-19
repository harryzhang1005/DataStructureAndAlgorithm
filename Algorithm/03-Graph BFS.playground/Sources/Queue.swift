import Foundation

/*
A queue (FIFO) is a list where you can only insert new items at the back and remove items from the front.
*/

public struct Queue<T: Hashable> {
	
	// You also can use Linked List to implement this
	private var list: [T] = [T]()
	
	public init() {}
	
	public var isEmpty: Bool {
		return list.isEmpty
	}
	
	public mutating func enqueue(item: T) {
		list.append(item)
	}
	
	public mutating func dequeue() -> T? {
		guard !list.isEmpty, let item = list.first else { return nil }
		list.removeFirst()	// or queue.remove(at: 0)
		return item
	}
	
	public func peek() -> T? {
		guard !list.isEmpty, let item = list.first else { return nil }
		return item
	}
	
}

extension Queue: CustomStringConvertible {
	public var description: String {
		let queueItems = (list.map{"\($0)"}).joined(separator: ", ")
		return "[" + queueItems + "]"
	}
}
