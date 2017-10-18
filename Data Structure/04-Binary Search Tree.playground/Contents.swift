//: Playground - noun: a place where people can play

import UIKit

/*
## Binary Search Trees
A binary search tree is a special kind of binary tree that performs insertions and deletions such that the tree is always sorted.
Each left child is smaller than its parent node, and each right child is greater than its parent node.

There is always only one possible place where the new element can be inserted in the tree. Finding this place is usually pretty quick.
It takes O(h) time, where h is the height of the tree.

## Insertion Time Complexity
You need to create a new copy of the tree every time you make an insertion. Creating a new copy requires going through all the nodes of the previous tree.
This gives the insertion method a time complexity of O(n).

Note: Average time complexity for a binary search tree for the traditional implementation using classes is O(log n), which is considerably faster. Using classes (reference semantics) won't have the copy-on-write behaviour, so you'll be able to insert without making a complete copy of the tree.

## Traversal Algorithms
There are three main ways to traverse a binary tree:
-1. In-order	Traversal	: Left, current node, Right
-2. Pre-order	Traversal	: current node, Left, Right
-3. Post-order	Traversal	: Left, Right, current node

## Time complexity of the traversal algorithms is O(n)
Traversing a tree is to go through all the nodes.

## Searching
A binary search tree is known best for facilitating efficient searching.
A proper binary search tree will have all it's left children less than it's parent node, and all it's right children equal to or greater than it's parent node.

Unlike the traversal algorithms, the search algorithm will traverse only 1 side at every recursive step. On average, this leads to a time complexity of O(log n), which is considerably faster than the O(n) traversal.

*/

class Node<T> {
	var value: T
	var leftChild: Node?
	var rightChild: Node?
	
	init(value: T) {
		self.value = value
	}
}

// recursive enum 'BinaryTree<T>' is not marked 'indirect'
// indirect applies a layer of indirection between two value types. This introduces a thin layer of reference semantics to the value type.
enum BinaryTree<T: Comparable> {
	case empty
	indirect case node(BinaryTree, T, BinaryTree)
	
	// Since only the node case is recursive, you only need to apply indirect to that case.
	// indirect case node(BinaryTree, T, BinaryTree)
	
	// number of nodes in the tree
	var count: Int {
		switch self {
		case let .node(left, _, right):
			return left.count + 1 + right.count
		case .empty:
			return 0
		}
	}
	
	// Value types are immutable by default. If you create a method that tries to mutate something within the value type, you'll need to explicitly specify that by prepending the mutating keyword in front of your method.
	mutating func naiveInsert(newValue: T) {
		guard case .node(var left, let rootValue, var right) = self else {
			self = .node(.empty, newValue, .empty)		// Here insert the root node, so rootValue = newValue
			return
		}
		
		// Insert a node
		if rootValue > newValue { // insert left side
			left.naiveInsert(newValue: newValue)
		} else { // insert right side
			right.naiveInsert(newValue: newValue)
		}
	}
	
	mutating func insert(newValue: T) {
		self = newTreeWithInsertedValue(newValue: newValue)
	}
	
	// This is a method that returns a new tree with the inserted element. Return a BinaryTree to avoid copy-on-write.
	private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
		switch self {
		// 1
		case .empty:
			return .node(.empty, newValue, .empty)
		// 2
		case let .node(left, value, right):
			if newValue < value {
				return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
			} else {
				return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
			}
		}
	}
	
	// left, current node, right
	func traverseInOrder(process: (T) -> Void) {
		switch self {
		// 1
		case .empty:
			return
		// 2
		case let .node(left, value, right):
			// The definition of in-order traversal is to go down the left side, visit the node, and then the right side.
			left.traverseInOrder(process: process)
			process(value)
			right.traverseInOrder(process: process)
		}
	}
	
	// current node first, then left, and then right children
	func traversePreOrder( process: (T) -> Void) {
		switch self {
		case .empty:
			return
		case let .node(left, value, right):
			process(value)
			left.traversePreOrder(process: process)
			right.traversePreOrder(process: process)
		}
	}
	
	// Left, right children then current node
	func traversePostOrder( process: (T) -> Void) {
		switch self {
		case .empty:
			return
		case let .node(left, value, right):
			left.traversePreOrder(process: process)
			right.traversePreOrder(process: process)
			process(value)
		}
	}
	
	// Search - a binary search tree is known best for facilitating efficient searching.
	func search(searchValue: T) -> BinaryTree? {
		switch self {
		case .empty:
			return nil
		case let .node(left, value, right):
			// 1
			if searchValue == value {
				return self
			}
			
			// 2
			if searchValue < value {
				return left.search(searchValue: searchValue)
			} else {
				return right.search(searchValue: searchValue)
			}
		}
	}
	
}

extension BinaryTree: CustomStringConvertible {
	var description: String {
		switch self {
		case let .node(left, value, right):
			return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
		case .empty:
			return ""
		}
	}
}

// Take this for an example for modeling (5 * (a - 10)) + (-4 * (3 / b))

// leaf nodes
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)
print(tree)
print("Tree nodes count: \(tree.count)")

// Test Binary Tree
var binaryTree: BinaryTree<Int> = .empty
binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 9)
print(binaryTree)

// Test In-order traversal
var treeInOrder: BinaryTree<Int> = .empty
treeInOrder.insert(newValue: 7)
treeInOrder.insert(newValue: 10)
treeInOrder.insert(newValue: 2)
treeInOrder.insert(newValue: 1)
treeInOrder.insert(newValue: 5)
treeInOrder.insert(newValue: 9)

// traverseInOrder will go through your nodes in ascending order, passing the value in each node to the trailing closure.
treeInOrder.traverseInOrder { print($0) }

print(treeInOrder.search(searchValue: 5)!)
