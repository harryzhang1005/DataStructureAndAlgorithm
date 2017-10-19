//: Playground - noun: a place where people can play

import UIKit

//: ![Demo Tree Structure](DemoTree.png)

/*
The root of a tree is level 0.
The root of a tree refers to the 0th level's node of a tree. Means the entry point to a tree data structure.
They are all nodes: root/root-node, node/normal-node, leaf/terminal-node

*/

// typealias RequiredProtocols = SomeProtocol & SomeOtherProtocol
// T: SomeProtocol<Hashable, Equatable>
public class Node<T: Hashable & Equatable> {
	var value: T
	var children: [Node<T>] = []
	weak var parent: Node<T>?
	
	// an initializer, which is required for initializing all non-optional stored properties for your class.
	init(value: T) {
		self.value = value
	}
	
	func add(node: Node<T>) {
		self.children.append(node)
		node.parent = self
	}
	
	// The goal of the this method is to search if a value exists in the tree (tree is also a node). If it does, return the node associated with the value. If it does not exist, just return nil.
	func search(value: T) -> Node<T>? {
		// Recursive exit: This is the case where you've found the value. You return self, which is the current node.
		if self.value == value {
			return self
		}
		
		// recursively iterate through all the children
		for child in children {
			if let found = child.search(value: value) {
				return found
			}
		}
		
		return nil
	}
	
}

extension Node: CustomStringConvertible {
	public var description: String {	// magic recursive
		var content = "\(value)"
		if !children.isEmpty {
			// Defined by types that adopt the Sequence protocol, map allows you to perform operations on every element of the array.
			content += " {" + ((children).map { "\($0.description)" }).joined(separator: ", ") + "} "
		}
		return content
	}
}

// MARK: - Test Tree
let beverages = Node(value: "beverages")
let hotBeverage = Node(value: "hot")
let coldBeverage = Node(value: "cold")

let tea = Node(value: "tea")
	let teaBlack = Node(value: "black")
	let teaGreen = Node(value: "green")
	let teaChai = Node(value: "chai")
	tea.add(node: teaBlack)
	tea.add(node: teaGreen)
	tea.add(node: teaChai)
let coffee = Node(value: "coffee")
let cocoa = Node(value: "cocoa")
hotBeverage.add(node: tea)
hotBeverage.add(node: coffee)
hotBeverage.add(node: cocoa)

let soda = Node(value: "soda")
	let sodaGingerAle = Node(value: "ginger ale")
	let sodaBitterLemon = Node(value: "bitter lemon")
	soda.add(node: sodaGingerAle)
	soda.add(node: sodaBitterLemon)
let milk = Node(value: "milk")
coldBeverage.add(node: soda)
coldBeverage.add(node: milk)

beverages.add(node: hotBeverage)
beverages.add(node: coldBeverage)

// beverages {hot {tea {black, green, chai} , coffee, cocoa} , cold {soda {ginger ale, bitter lemon} , milk} }
print(beverages)

if let tea = beverages.search(value: "tea") {
	print(tea)
}
