//: Playground - noun: a place where people can play

import UIKit

/*
A queue (FIFO) is a list where you can only insert new items at the back and remove items from the front.
*/

public struct Queue<T: Hashable> {
	
	// You also can use Linked List to implement this
	private var list: [T] = [T]()
	
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

// MARK: - Test Queue

var intQueue = Queue<Int>()
intQueue.enqueue(item: 3)
intQueue.enqueue(item: 5)
intQueue.enqueue(item: 7)
print(intQueue)
intQueue.dequeue()
print(intQueue)
print(intQueue.peek() ?? 0)

var strQueue = Queue<String>()
strQueue.enqueue(item: "Apple")
strQueue.enqueue(item: "Banana")
strQueue.enqueue(item: "Orange")
print(strQueue)
strQueue.dequeue()
print(strQueue)
print(strQueue.peek() ?? "")
