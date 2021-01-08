//
//  SingleLinkedListTest.swift
//  SingleLinkedListTest
//
//  Created by 程昆 on 2021/1/8.
//

import XCTest

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


class SingleLinkedListTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample1() throws {
        let list = SingleLinkedList<Int>()
        list.addElement(at: 0, element: 0)
        list.addElement(at: 1, element: 1)
        list.addElement(at: 2, element: 2)
        list.add(element: 3)
        list.add(element: nil)
        assert(list.size == 5)
        assert(list.description == "SingleLinkedList[0->1->2->3->nil->]")
        
        assert(list[3] == 3)
        assert(list[4] == nil)
        
        list[0] = 6
        assert(list[0] == 6)
        
        list.setElement(at: 0, element: 7)
        assert(list[0] == 7)
        assert(list.getElement(at: 0) == 7)
        
        list.setElement(at: 4, element: 8)
        assert(list[4] == 8)
        assert(list.getElement(at: 4) == 8)
        
        print(list)
        
    }
    
    func testExample2() throws {
        let list = SingleLinkedList<Person>()
        
        let person1:Person? = Person(name: "aa", age: 10)
        let person2:Person? = Person(name: "aa", age: 11)
        let person3:Person? = Person(name: "bb", age: 10)
        let person4:Person? = Person(name: "cc", age: 13)
        
        list.add(element: person1)
        list.add(element: person2)
        list.add(element: person3)
        list.add(element: person4)
        list.setElement(at: 0, element: Person(name: "dd", age: 10))

        assert(list[2] == person3)
        assert(list.getElement(at: 3) == person4)

        assert(list.remove(at: 0)?.name == "dd")
        assert(list.remove(at: 2)?.name == "cc")
        
        let list1 = SingleLinkedList<Person>()
        list1.add(element: Person(name: "dd", age: 10))
        assert(list1.remove(at: 0)?.name == "dd")
        assert(list1.size == 0)
        assert(list1.description == "SingleLinkedList[]")
        
        let list2 = SingleLinkedList<Person>()
        list2.add(element: nil)
        assert(list2.description == "SingleLinkedList[nil->]")
        assert(list2.isEmpty() == false)
        assert(list2.remove(at: 0)?.name == nil)
        assert(list2.size == 0)
        assert(list2.description == "SingleLinkedList[]")
        assert(list2.isEmpty() == true)
        
        let list3 = SingleLinkedList<Person>()
        list3.add(element: nil)
        list3.add(element: nil)
        list3.add(element: nil)
        assert(list3.description == "SingleLinkedList[nil->nil->nil->]")
        list3.clear()
        assert(list3.description == "SingleLinkedList[]")
        assert(list3.isEmpty() == true)
        
        let list4 = SingleLinkedList<Person>()
        list4.add(element: Person(name: "aa", age: 10))
        list4.add(element: Person(name: "bb", age: 10))
        list4.add(element: Person(name: "cc", age: 10))
        assert(list4.contains(element: Person(name: "aa", age: 10)) == true)
        assert(list4.contains(element: Person(name: "dd", age: 10)) == false)
        assert(list4.description == "SingleLinkedList[Person{name:aa,age:10}->Person{name:bb,age:10}->Person{name:cc,age:10}->]")
        list4.clear()
        assert(list4.contains(element: Person(name: "aa", age: 10)) == false)
        assert(list4.description == "SingleLinkedList[]")
        assert(list4.isEmpty() == true)
        
        print(list)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
