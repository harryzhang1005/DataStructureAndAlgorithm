//: Playground - noun: a place where people can play

import UIKit

/* Linked List

Singly linked lists, are linked lists where each node only has a reference to the next node.
Doubly linked lists, are linked lists where each node has a reference to the previous and next node.

## Linked List
What's head and tail pointers?
Of course, they are head or tail Node. They keep track of where the list begins and ends.

In special case, if only one node in the linked list, then: head = tail = theOneNode
*/

public class Node<T>: CustomStringConvertible {
	var value: T
	var next: Node<T>?
	weak var previous: Node<T>?	// avoid retain cycle
	
	init(value: T) {
		self.value = value
	}
	
	public var description: String {
		return "\(value)"
	}
}

// This class keep track of where the list begins and ends
public class LinkedList<T> {
	
	private var head: Node<T>?
	private var tail: Node<T>?
	public var count: Int = 0	// how many nodes
	
	public var isEmpty: Bool {
		return head == nil
	}
	
	public var first: Node<T>? {
		return head
	}
	
	public var last: Node<T>? {
		return tail
	}
	
	// MARK: - CRUD
	
	public func append(value: T) {
		let aNode = Node(value: value)
		
		if let tailNode = tail {	// there is something in the linked list already
			aNode.previous = tailNode
			tailNode.next = aNode
		}
		else {	// first node
			head = aNode
		}
		
		tail = aNode
		count += 1
	}
	
	public func addNode(node: Node<T>) {
		if let tailNode = tail {	// there is something in the linked list already
			node.previous = tailNode
			tailNode.next = node
		}
		else {	// first node
			head = node
		}
		
		tail = node
		count += 1
	}
	
	public func nodeAt(index: Int) -> Node<T>? {
		guard index < count && index >= 0 else { return nil }
		
		var node = head
		var num = 0
		while node != nil && num < index {
			node = node!.next
			num += 1
		}
		return node
	}
	
	public func nodeAt_V2(index: Int) -> Node<T>? {
		// 1
		if index >= 0 {
			var node = head
			var i = index
			// 2
			while node != nil {
				if i == 0 { return node }
				i -= 1
				node = node!.next
			}
		}
		// 3
		return nil
	}
	
	public func removeAll() {
		head = nil
		tail = nil
		count = 0
	}
	
	// Remove node at index if have, and return this removed node
	public func removeAt(index: Int) -> Node<T>? {
		guard index < count && index >= 0 else { return nil }
		
		if index == 0 {	// remove head node
			let node = head
			head = head?.next
			count -= 1
			return node
		}
		
		// remove normal node or tail node
		var node = head
		var num = 0
		while node != nil && num < index {
			node = node!.next
			num += 1
		}
		
		node?.previous?.next = node?.next
		node?.next?.previous = node?.previous
		count -= 1
		
		return node
	}
	
	// remove the first node, middle node, and last node
	public func remove(node: Node<T>) -> T {
		let prev = node.previous
		let next = node.next
		
		if let prev = prev { // 1 you are not remvoing the first node in the list
			prev.next = next
		} else { // 2 you are removing the first node in the list
			head = next
		}
		
		next?.previous = prev // 3
		
		if next == nil { // 4 you are removing the last node
			tail = prev
		}
		
		// 5
		node.previous = nil
		node.next = nil
		
		// 6
		return node.value
	}
	
}

extension LinkedList: CustomStringConvertible {
	public var description: String {	// computed property
		var text = "["
		var node = head
		while node != nil {
			text += "\(node!.value)"
			node = node!.next
			if node != nil { text += ", " }
		}
		return text + "]"
	}
}

// MARK: - Test Linked List

// String Linked List
let fruitLink = LinkedList<String>()
fruitLink.append(value: "Apple")
fruitLink.append(value: "Orange")
fruitLink.append(value: "Banana")
fruitLink.append(value: "Pear")
fruitLink.append(value: "Strawberry")

print(fruitLink)
print("Linked List Length: \(fruitLink.count)")
print("First Node: \(fruitLink.first!)")
print("Last Node: \(fruitLink.last!)")
print("No.Index+1 Node: \(fruitLink.nodeAt(index: 2)!)")
print("Remove No.Index+1 Node: \(fruitLink.removeAt(index: 2)!)")
print("Linked List Length: \(fruitLink.count)")
print(fruitLink)

// Int Linked List
var numbers = LinkedList<Int>()
numbers.append(value: 3)
numbers.append(value: 5)
numbers.append(value: 7)
numbers.append(value: 9)
numbers.append(value: 2)
print(numbers)

let aNode = Node(value: 8)
numbers.addNode(node: aNode)
print(numbers)
numbers.remove(node: aNode)
print(numbers)
