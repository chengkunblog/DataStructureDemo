//
//  main.swift
//  DynamicArray
//
//  Created by 程昆 on 2021/1/1.
//

import Foundation

var dynamicArray = DynamicArray<Int>();
dynamicArray.add(element: 1)
dynamicArray.add(element: 2)
dynamicArray.add(element: 3)
dynamicArray.add(element: 4)
dynamicArray.add(element: 5)
dynamicArray.add(element: 6)
dynamicArray.add(element: 7)
dynamicArray.add(element: 8)

var size = dynamicArray.size
assert(size == 8);

dynamicArray.addElement(at: 0, element: 0)
let element0 = dynamicArray.getElement(at: 0)
assert(element0 == 0)

dynamicArray.addElement(at: 2, element: 5)
let element2 = dynamicArray.getElement(at: 2)
assert(element2 == 5)

let element3 = dynamicArray[2]
assert(element3 == 5)

dynamicArray[3] = 6
let element4 = dynamicArray[3]
assert(element4 == 6)

assert(dynamicArray.size == 10)
assert(dynamicArray.capacity == 10)

dynamicArray.add(element: 11)
assert(dynamicArray.capacity == 20);

let index = dynamicArray.index(of: 6)
assert(index == 3)

let element5 = dynamicArray.remove(at: 0)
assert(element5 == 0)
assert(dynamicArray[0] == 1)

let element6 = dynamicArray.remove(at: 9)
assert(element6 == 11)
assert(dynamicArray.size == 9)

let contains = dynamicArray.contains(element: 5)
assert(contains == true)

let noContains = dynamicArray.contains(element: 9)
assert(noContains == false)

dynamicArray.clear()
assert(dynamicArray.size == 0)
assert(dynamicArray.capacity == 20)

print(dynamicArray,dynamicArray.capacity)

var dynamicArray1 = DynamicArray<Int>(capacity: 5);
assert(dynamicArray1.capacity == 10)
print(dynamicArray1,dynamicArray1.capacity)

var dynamicArray2 = DynamicArray<Int>(capacity: 11);
assert(dynamicArray2.capacity == 11)
print(dynamicArray2,dynamicArray2.capacity)

class Person: Equatable,CustomStringConvertible {
    deinit {
        print("deinit \(self)")
    }
    
    var description: String {
        return "Person{name:\(name),age:\(age)}"
    }
    
    var name: String
    var age: Int
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    init(name: String = "",age: Int = 0) {
        self.name = name
        self.age = age
    }
    
}

var dynamicArray3 = DynamicArray<Person>(capacity: 12);
var person1:Person? = Person(name: "aa", age: 10)
var person2:Person? = Person(name: "aa", age: 11)
var person3:Person? = Person(name: "bb", age: 10)
var person4:Person? = Person(name: "cc", age: 13)
dynamicArray3.add(element: person1)
dynamicArray3.add(element: person2)
dynamicArray3.add(element: person3)
dynamicArray3.add(element: person4)
dynamicArray3.setElement(at: 0, element: Person(name: "dd", age: 10))

assert(dynamicArray3.capacity == 12)
assert(dynamicArray3[2] == person3)
assert(dynamicArray3.getElement(at: 3) == person4)

assert(dynamicArray3.remove(at: 1) == person2)
assert(dynamicArray3.contains(element: Person(name: "dd", age: 10)) == true)

let person5 = Person(name: "ee", age: 15)
dynamicArray3.addElement(at: 1, element: person5)
assert(dynamicArray3[1] == person5)

dynamicArray3.add(element: Person(name: "a", age: 10))
dynamicArray3.add(element: Person(name: "b", age: 10))
dynamicArray3.add(element: Person(name: "c", age: 10))

let _ = dynamicArray3.remove(at: 5)
assert(dynamicArray3.isEmpty() == false)
dynamicArray3.clear()
assert(dynamicArray3.isEmpty() == true)
print(dynamicArray3,dynamicArray3.capacity)

var dynamicArray4 = DynamicArray<Person>(capacity: 12);
assert(dynamicArray4.isEmpty() == true)
dynamicArray4.add(element: Person(name: "gg", age: 10))
assert(dynamicArray4.isEmpty() == false)
print(dynamicArray4,dynamicArray4.size)
let _ = dynamicArray4.remove(at: 0)
assert(dynamicArray4.isEmpty() == true)
print(dynamicArray4,dynamicArray4.size)

var dynamicArray5 = DynamicArray<Person>(capacity: 12);
dynamicArray5.add(element: Person(name: "hh", age: 10))


var dynamicArray6 = dynamicArray5

let _ = dynamicArray5.remove(at: 0)
print(dynamicArray5)

dynamicArray6.add(element: Person(name: "ss", age: 10))
print(dynamicArray6)

var  dynamicArray7 = DynamicArray<Person>(capacity: 12);
dynamicArray7.add(element: nil);
print(dynamicArray7)









