//
//  SingleLinkedListTest.swift
//  SingleLinkedListTest
//
//  Created by 程昆 on 2021/1/8.
//

import XCTest

class SingleLinkedListTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let list = SingleLinkedList<Int>()
        list.addElement(at: 0, element: 0)
        list.addElement(at: 1, element: 1)
        list.addElement(at: 2, element: 2)
        list.add(element: 3)
        list.add(element: nil)
        assert(list.size == 5)
        assert(list.description == "SingleLinkedList[0->1->2->3->nil->]")
        print(list)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
