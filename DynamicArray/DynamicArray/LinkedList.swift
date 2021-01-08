//
//  AbstractLinkedList.swift
//  DynamicArray
//
//  Created by 程昆 on 2021/1/4.
//

import Foundation

fileprivate struct Constant {
    static let defautCapacity = 10;
    static let notFound = -1;
}

fileprivate struct AssociatedKeys {
        static var sizeKey = "size"
}

protocol LinkedList {
    associatedtype E:Equatable
    
    var size: Int {get}
    static var notFound:Int {get}
    
    func isEmpty() -> Bool
    func contains(element: E) -> Bool
    func add(element: E?)
    func addElement(at index: Int, element: E?)
    func getElement(at index: Int) -> E?
    subscript(index: Int) -> E? { get set }
    func setElement(at index: Int, element: E?)
    func remove(at index: Int) -> E?
    func index(of element: E) -> Int
    func clear()
}

class AbstractLinkedList<Element:Equatable>: LinkedList {
    typealias E = Element
    
    fileprivate(set) var size = 0;
    
    static var notFound:Int {
        Constant.notFound
    }
    
    init() {
        if type(of: self) == AbstractLinkedList.self {
            fatalError("不能直接使用AbstractLinkedList抽象类,请实例化子类")
        }
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func contains(element: Element) -> Bool {
        return index(of: element) != Self.notFound
    }
    
    func add(element: Element?)  {
        addElement(at: size, element: element)
    }
    
    subscript(index: Int) -> Element?  {
        get {
            return getElement(at: index)
        }
        set {
            setElement(at: index, element:newValue)
        }
    }
    
    func addElement(at index: Int, element: Element?) {
        fatalError("必须重写\(#function)")
    }
    
    func getElement(at index: Int) -> Element? {
        fatalError("必须重写\(#function)")
    }
    
    func setElement(at index: Int, element: Element?) {
        fatalError("必须重写\(#function)")
    }
    
    func remove(at index: Int) -> Element? {
        fatalError("必须重写\(#function)")
    }
    
    func index(of element: Element) -> Int {
        fatalError("必须重写\(#function)")
    }
    
    func clear() {
        fatalError("必须重写\(#function)")
    }
}

extension AbstractLinkedList {
     fileprivate func cheackInBounds(at index: Int) -> Bool {
           if  index >= size {
               return false;
           }
           return true;
     }
    
     fileprivate func cheackAddInBounds(at index: Int) -> Bool {
        if  index > size {
            return false;
        }
        
        return true;
     }
}


class DynamicArray<Element: Equatable>: AbstractLinkedList<Element>  {
    typealias E = Element
    
    private static var defautCapacity:Int {
        Constant.defautCapacity
    }
    
    private(set) var capacity = DynamicArray.defautCapacity;
    private var elements = {
        return UnsafeMutablePointer<Element?>.allocate(capacity: DynamicArray.defautCapacity);
    }();

    init(capacity: Int = DynamicArray.defautCapacity) {
        if capacity >=  DynamicArray.defautCapacity {
            self.capacity = capacity
            elements = UnsafeMutablePointer<Element?>.allocate(capacity: capacity)
            elements.initialize(repeating: nil, count: capacity)
        }
    }
    
   override func addElement(at index: Int, element: Element?) {
        guard cheackAddInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        ensureCapacity(capacity: size + 1)
        
        for index in (index ..< size).reversed() {
            elements[index + 1] = elements[index]
        }
        elements[index] = element
        size += 1
    }
    
    override func getElement(at index: Int) -> Element? {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        return elements[index];
    }
    
    override func setElement(at index: Int, element: Element?) {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        elements[index] = element
    }
    
    override func remove(at index: Int) -> Element? {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        let oldElement = elements[index]
        for index in (index + 1 ..< size) {
            elements[index - 1] = elements[index]
        }
        elements[size - 1] = nil
        size -= 1
        
        return oldElement
    }
    
    override func index(of element: Element) -> Int {
        for index in (0..<size) {
            if elements[index] == element {
                return index
            }
        }
        
        return Self.notFound
    }
    
    override func clear() {
        for index in 0..<size {
            elements[index] = nil
        }
        size = 0
    }

    private func ensureCapacity(capacity: Int)  {
        if capacity > self.capacity {
            let oldCapacity = self.capacity
            let oldElements = self.elements
            self.capacity = oldCapacity << 1
            elements = UnsafeMutablePointer<Element?>.allocate(capacity: self.capacity)
            
            for index in (0 ..< size) {
                elements[index] = oldElements[index];
            }
        }
    }
}
    

extension DynamicArray: CustomStringConvertible {
    var description: String {
        var string = "DynamicArray["
        if size == 0 {
            return string + "]"
        }

        for index in 0..<size {
            if index > 0 {
                string += ", "
            }
            if let element = elements[index] {
                string += "\(element)"
            } else {
                string += "nil"
            }
        }
        
        string += "]"
        
        return string
    }
}

class SingleLinkedList<Element: Equatable>: AbstractLinkedList<Element> {
    private class Node {
        var element:Element?
        var next:Node?
        
        init(element:Element? = nil,next:Node? = nil) {
            self.element = element
            self.next = next
        }
    }
    
    private var first:Node?
    
    override func addElement(at index: Int, element: Element?) {
        guard cheackAddInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        guard var preNode = first else {
            first = Node(element: element, next: nil)
            size += 1
            return
        }

        if index > 0 {
            preNode = getNode(at: index - 1)
        }
        let node = preNode.next
        let newNode = Node(element: element, next: node)
        preNode.next = newNode
        size += 1
    }
    
    override func getElement(at index: Int) -> Element? {
        return getNode(at: index).element;
    }
    
    override func setElement(at index: Int, element: Element?) {
        let node  = getNode(at: index)
        node.element = element
    }
    
    override func remove(at index: Int) -> Element? {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        var oldNode = first!
        if index == 0 {
            first = oldNode.next
        } else {
            let  preNode = getNode(at:index - 1)
            oldNode = preNode.next!
            preNode.next = oldNode.next
        }
    
        size -= 1
        return oldNode.element
    }
    
    override func index(of element: Element) -> Int {
        for index in (0..<size) {
            if self[index] == element {
                return index
            }
        }
        
        return Self.notFound
    }
    
    override func clear() {
        first = nil
        size = 0
    }
    
    private func getNode(at index: Int) -> Node {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        var node = self.first
        for _ in 0..<index {
            node = node?.next
        }
        return node!
    }
}

extension SingleLinkedList:CustomStringConvertible {
    var description: String {
        var string = "SingleLinkedList["
        guard size > 0 else {
            return string + "]"
        }
        
        var node = first
        while node != nil {
            if let element = node?.element {
                string = string + "\(element)" + "->"
            } else {
                string = string + "nil" + "->"
            }
            node = node!.next
        }
        
        string += "]"
        return string
    }
}
