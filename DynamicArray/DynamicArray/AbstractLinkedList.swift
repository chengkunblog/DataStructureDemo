////
////  AbstractLinkedList.swift
////  DynamicArray
////
////  Created by 程昆 on 2021/1/4.
////
//
//fileprivate struct Constant {
//    static let defautCapacity = 10;
//    static let notFound = -1;
//}
//
//class AbstractLinkedList<Element:Equatable>: LinkedList {
//    var size = 0;
//
//    static var notFound:Int {
//        Constant.notFound
//    }
//
//    func isEmpty() -> Bool {
//        return size == 0
//    }
//
//    func contains(element: Element) -> Bool {
//        return index(of: element) != Self.notFound
//    }
//
//    func add(element: Element?)  {
//        addElement(at: size, element: element)
//    }
//
//    func addElement(at index: Int, element: Element?) {
//        <#code#>
//    }
//
//    func getElement(at index: Int) -> Element? {
//        <#code#>
//    }
//
//    subscript(index: Int) -> Element? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//
//    func setElement(at index: Int, element: Element?) {
//        <#code#>
//    }
//
//    func remove(at index: Int) -> Element? {
//        <#code#>
//    }
//
//    func index(of element: Element) -> Int {
//        <#code#>
//    }
//
//    func clear() {
//        <#code#>
//    }
//
//    typealias E = Element
//
//
//}
