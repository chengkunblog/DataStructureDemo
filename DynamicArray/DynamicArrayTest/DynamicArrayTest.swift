//
//  DynamicArrayTest.swift
//  DynamicArrayTest
//
//  Created by 程昆 on 2021/1/4.
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

class DynamicArrayTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample1() throws {
        let dynamicArray = DynamicArray<Int>();
        dynamicArray.add(element: 1)
        dynamicArray.add(element: 2)
        dynamicArray.add(element: 3)
        dynamicArray.add(element: 4)
        dynamicArray.add(element: 5)
        dynamicArray.add(element: 6)
        dynamicArray.add(element: 7)
        dynamicArray.add(element: 8)

        let size = dynamicArray.size
        XCTAssert(size == 8)

        dynamicArray.addElement(at: 0, element: 0)
        let element0 = dynamicArray.getElement(at: 0)
        XCTAssert(element0 == 0)

        dynamicArray.addElement(at: 2, element: 5)
        let element2 = dynamicArray.getElement(at: 2)
        XCTAssert(element2 == 5)

        let element3 = dynamicArray[2]
        XCTAssert(element3 == 5)

        dynamicArray[3] = 6
        let element4 = dynamicArray[3]
        XCTAssert(element4 == 6)

        XCTAssert(dynamicArray.size == 10)
        XCTAssert(dynamicArray.capacity == 10)

        dynamicArray.add(element: 11)
        XCTAssert(dynamicArray.capacity == 20);

        let index = dynamicArray.index(of: 6)
        XCTAssert(index == 3)

        let element5 = dynamicArray.remove(at: 0)
        XCTAssert(element5 == 0)
        XCTAssert(dynamicArray[0] == 1)

        let element6 = dynamicArray.remove(at: 9)
        XCTAssert(element6 == 11)
        XCTAssert(dynamicArray.size == 9)

        let contains = dynamicArray.contains(element: 5)
        XCTAssert(contains == true)

        let noContains = dynamicArray.contains(element: 9)
        XCTAssert(noContains == false)

        dynamicArray.clear()
        XCTAssert(dynamicArray.size == 0)
        XCTAssert(dynamicArray.capacity == 20)
        XCTAssert(dynamicArray.contains(element: 9) == false)

        print(dynamicArray,dynamicArray.capacity)
    }
    
    func testExample2() throws {
        let dynamicArray1 = DynamicArray<Int>(capacity: 5);
        assert(dynamicArray1.capacity == 10)
        print(dynamicArray1,dynamicArray1.capacity)

        let dynamicArray2 = DynamicArray<Int>(capacity: 11);
        assert(dynamicArray2.capacity == 11)
        print(dynamicArray2,dynamicArray2.capacity)
        
    }
    
    func testExample3() throws {
        let dynamicArray3 = DynamicArray<Person>(capacity: 12);
        let person1:Person? = Person(name: "aa", age: 10)
        let person2:Person? = Person(name: "aa", age: 11)
        let person3:Person? = Person(name: "bb", age: 10)
        let person4:Person? = Person(name: "cc", age: 13)
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
    }

    func testExample4() throws {
        let dynamicArray4 = DynamicArray<Person>(capacity: 12);
        assert(dynamicArray4.isEmpty() == true)
        dynamicArray4.add(element: Person(name: "gg", age: 10))
        assert(dynamicArray4.isEmpty() == false)
        print(dynamicArray4,dynamicArray4.size)
        let _ = dynamicArray4.remove(at: 0)
        assert(dynamicArray4.isEmpty() == true)
        print(dynamicArray4,dynamicArray4.size)
    }
    
    func testExample5() throws {
        let dynamicArray5 = DynamicArray<Person>(capacity: 12);
        dynamicArray5.add(element: Person(name: "hh", age: 10))

        let dynamicArray6 = dynamicArray5
        let _ = dynamicArray5.remove(at: 0)
        XCTAssert(dynamicArray5.size == 0)
        print(dynamicArray5)

        dynamicArray6.add(element: Person(name: "ss", age: 10))
        print(dynamicArray6)
        XCTAssert(dynamicArray6.size == 1)
    }
    
    func testExample6() throws {
        let  dynamicArray7 = DynamicArray<Person>(capacity: 12);
        dynamicArray7.add(element: nil);
        print(dynamicArray7)
        XCTAssert(dynamicArray7[0] == nil)
    }
    
    func testExample7() throws {
        
    }
    
    func testExample8() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
