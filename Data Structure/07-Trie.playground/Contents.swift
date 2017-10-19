//: Playground - noun: a place where people can play

import UIKit

/* Trie

Trie is not a Tree; this is actually a different data structure.

Each TrieNode will represent a character of a word. For instance, `cute` will be nodes: c -> u -> t -> e .
The Trie class will manage the insertion logic and keep a reference to the nodes.

*/

class TrieNode<T: Hashable> {
	var value: T?
	weak var parent: TrieNode?
	var children: [T : TrieNode] = [:]
	var isTerminating = false	// the end of a word or not
	
	init(value: T? = nil, parent: TrieNode? = nil) {
		self.value = value
		self.parent = parent
	}
	
	func add(child: T) {
		guard children[child] == nil else { return }
		children[child] = TrieNode(value: child, parent: self)
	}
	
}

// This class manage TrieNodes
class Trie {
	typealias Node = TrieNode<Character>
	fileprivate let root: Node
	
	init() { root = Node() }
}

extension Trie {
	
	func insert(word: String) -> Void {
		guard !word.isEmpty else { return }
		
		var currentNode = root
		
		let characters = Array(word.lowercased().characters)
		var currentIndex = 0
		
		while currentIndex < characters.count {
			let character = characters[currentIndex]
			
			if let child = currentNode.children[character] {
				currentNode = child
			} else {
				currentNode.add(child: character)
				currentNode = currentNode.children[character]!
			}
			
			currentIndex += 1
			
			if currentIndex == characters.count {
				currentNode.isTerminating = true
			}
		}
	}
	
	func contains(word: String) -> Bool {
		guard !word.isEmpty else { return false }
		
		var currentNode = root
		let characters = Array(word.lowercased().characters)
		var currentIndex = 0
		
		while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
			currentIndex += 1
			currentNode = child
		}
		
		if currentIndex == characters.count && currentNode.isTerminating {
			return true
		} else {
			return false
		}
	}
	
}

// MARK: - Test Trie

let trie = Trie()
trie.insert(word: "cute")

print(trie.contains(word: "cute"))
print(trie.contains(word: "cut"))

trie.insert(word: "cut")
print(trie.contains(word: "cut"))
