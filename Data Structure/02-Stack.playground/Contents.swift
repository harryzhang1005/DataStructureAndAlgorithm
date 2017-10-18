//: Playground - noun: a place where people can play

import UIKit

/*
First In, Last Out (FILO)
*/

public struct Stack<T: Hashable> {
	
	private var list: [T] = [T]()
	
	public var isEmpty: Bool {
		return list.isEmpty
	}
	
	public var count: Int {
		return list.count
	}
	
	public mutating func push(item: T) {
		list.append(item)
	}
	
	public mutating func pop() -> T? {
		return list.popLast() // Removes and returns the last element of the array.
	}
	
	public func peek() -> T? {
		return list.last
	}
	
}

extension Stack: CustomStringConvertible {
	public var description: String {
		let topDivider = "--- Stack ---\n"
		let bottomDivider = "\n--------------\n"
		let stackItems = (list.reversed().map{"\($0)"}).joined(separator: "\n")
		return topDivider + stackItems + bottomDivider
	}
}

// MARK: - Test Stack

var intStack = Stack<Int>()
intStack.push(item: 3)
intStack.push(item: 5)
intStack.push(item: 7)
print(intStack)
intStack.pop()
print(intStack)
print(intStack.peek() ?? 0)

var strStack = Stack<String>()
strStack.push(item: "Apple")
strStack.push(item: "Banana")
strStack.push(item: "Orange")
print(strStack)
strStack.pop()
print(strStack)
print(strStack.peek() ?? "")
