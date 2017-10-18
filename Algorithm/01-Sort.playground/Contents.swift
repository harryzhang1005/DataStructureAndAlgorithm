//: Playground - noun: a place where people can play

import UIKit

/* I: Merge Sort
The idea behind merge sort is to `divide and conquer`. Means split first and merge after.

Step-1: Split in half. You now have two unsorted piles.
		Keep spliting the resulting piles until you can't split anymore. In the end, you will have One card for each pile.

Step-2: Merge the piles together. During each merge, you put the contents in sorted order. Each individual pile is already sorted.
*/
func mergeSort<T: Comparable>(array: [T]) -> [T] {
	// Step-1: Split
	// All recursive implementations need a base case. Means exit condition. Here stop the recursion when the array has only 1 element.
	guard array.count > 1 else { return array }
	
	let middleIndex = array.count / 2
	let leftArray = mergeSort(array: Array(array[0..<middleIndex]))
	let rightArray = mergeSort(array: Array(array[middleIndex..<array.count]))
	
	// Step-2: Merage leftArray and rightArray
	return merge(left: leftArray, right: rightArray)
}

// the merge function is suppose to take in 2 sorted arrays. The strategy is to append elements from left and right array one by one.
func merge<T: Comparable>(left: [T], right: [T]) -> [T] {
	var leftIndex = 0
	var rightIndex = 0
	
	var orderedArray: [T] = []
	
	// 1 Comparing the elements in left and right arrays sequentially. If you reached the end of either array, there's nothing else to compare.
	while leftIndex < left.count && rightIndex < right.count {
		let leftElement = left[leftIndex]
		let rightElement = right[rightIndex]
		
		if leftElement < rightElement {
			orderedArray.append(leftElement)
			leftIndex += 1
		}
		else if leftElement > rightElement {
			orderedArray.append(rightElement)
			rightIndex += 1
		}
		else {
			orderedArray.append(leftElement)
			leftIndex += 1
			orderedArray.append(rightElement)
			rightIndex += 1
		}
	}
	
	// 2 The first loop guarantees that either left or right is empty. Since both arrays are sorted, this ascertains that the rest of the contents in the leftover array are equal or greater than the ones currently in orderedArray. In this scenario, you'll append the rest of the elements without comparison.
	while leftIndex < left.count {
		orderedArray.append(left[leftIndex])
		leftIndex += 1
	}
	while rightIndex < right.count {
		orderedArray.append(right[rightIndex])
		rightIndex += 1
	}
	
	return orderedArray
}

// The downside: the merge function is suppose to take in 2 sorted arrays. This is a crucial precondition that allows for optimizations. The sorted(by:) method doesn't take advantage of this, but you will.
func merge_v2(left: [Int], right: [Int]) -> [Int] {
	return (left + right).sorted(by: <)
}
//print(merge_v2(left: [3, 7], right: [2, 6]))

// MARK: - Test Merge Sort

let intArray = [7, 2, 6, 3, 9]
let strArray = ["Banana", "Apple", "Pear", "Orange", "Peach"]

print(mergeSort(array: intArray))
print(mergeSort(array: strArray))

/// II: Quick Sort

func quickSort(array: inout [Int], left: Int, right: Int) {
	let index = partition(array: &array, left: left, right: right)
	
	if (left < index - 1) { // sort left hand
		quickSort(array: &array, left: left, right: index-1)
	}
	
	if (index < right) {	// sort right hand
		quickSort(array: &array, left: index, right: right)
	}
}

func partition(array: inout [Int], left: Int, right: Int) -> Int {
	let pivot = array[(left+right)/2]	// pick a pivot point
	var left = left
	var right = right
	
	while(left <= right) {
		while(array[left] < pivot) {
			left = left + 1
		}
		
		while(array[right] > pivot) {
			right = right - 1
		}
		
		// Swap elements, and move left and right indices
		if (left <= right) {
			swap(array: &array, left: left, right: right)	// swaps elements
			left = left + 1
			right = right - 1
		}
	}
	return left;
}

func swap(array: inout [Int], left: Int, right: Int) {
	let tempValue = array[left]
	array[left] = array[right]
	array[right] = tempValue
}

/// MARK: - Test Quick Sort

let array = [1, 3, 6, 9, 5, 8, 4, 2, 6, 7]

var copyArray = array
quickSort(array: &copyArray, left: 0, right: 9)
print(copyArray)	// copyArray is a sorted array

/// MARK: - Binary Search

func binarySearch(array: [Int], x: Int) -> Int {
	var low = 0
	var high = array.count - 1
	var mid: Int
	
	while (low <= high) {
		mid = (low + high)/2
		if (array[mid] < x) {
			low = mid + 1
		}
		else if (array[mid] > x) {
			high = mid - 1
		}
		else {
			return mid
		}
	}
	return -1	// error
}

func binarySearchRecursive(array: [Int], x: Int, low: Int, high: Int) -> Int {
	if (low > high) { return -1 }
	
	let mid: Int = (low+high)/2
	if (array[mid] > x) {
		return binarySearchRecursive(array: array, x: x, low: low, high: mid-1)
	}
	else if (array[mid] < x) {
		return binarySearchRecursive(array: array, x: x, low: mid+1, high: high)
	}
	else {
		return mid
	}
}

// MARK: - Test Binary Search

let index1 = binarySearch(array: copyArray, x: 5)
if index1 != -1 {
	print("Index1: \(index1), and Value: \(copyArray[index1])")
}

let index2 = binarySearchRecursive(array: copyArray, x: 5, low: 0, high: 9)
if index2 != -1 {
	print("Index2: \(index2), and Value: \(copyArray[index2])")
}

func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
	for (index, obj) in array.enumerated() where obj == object {
		return index
	}
	return nil
}

print("Index: \(linearSearch(copyArray, 5)!) and Value: 5")

/* Test Cases

# Step-1: Define the test cases
-1. The normal case: Does it generate the correct output for typical inputs?
-2. The extremes: What happens when you pass in an empty array? Or a very small (one element) array? What if a very large one?
-3. Nulls and illegal input: It is worthwhile to think about how the code should behave when given illegal input.
-4. Strange input: What happens when you pass in an already sorted array? Or an array that's sorted in reverse order?

# Step-2: Define the expected result

# Step-3: Write test code
Once you have the test cases and results defined, writing the code to implement the test cases. For example:
func testAddThreeSorted() {
	var list: MyList = MyList()
	list.addThreeSorted(3, 1, 2)	// Adds 3 items in sorted order
	assertEquals(list.getElement(0), 1)
	assertEquals(list.getElement(1), 2)
	assertEquals(list.getElement(2), 3)
}

... Troubleshooting Questions
How you would debug or troubleshoot an existing issue?

# Step-1: Understand the Scenario
The first thing you should do is ask questions to understand as much about the situation as possible.
- How long has the user been exeriencing this issue?
- What version of the browser is it? What operating system?
- Does the issue happen consistently, or how often does it happen? When does it happen?
- Is there an error report that launches?

# Step-2: Break Down the Problem
After you understand the details of the scenario, you break down the problem into testable units.

# Step-3: Create Specific, Manageable Tests

*/
