//
//  AbstractLinkedList.swift
//  DynamicArray
//
//  Created by 程昆 on 2021/1/4.
//

protocol LinkedList {
    associatedtype E:Equatable
    
    var size: Int { get }
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

extension LinkedList {
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

extension LinkedList {
    typealias Element = E
    
//    func isEmpty() -> Bool {
//        return size == 0
//    }
    
    func contains(element: Element) -> Bool {
        return index(of: element) != Self.notFound
    }
    
    func add(element: Element?)  {
        addElement(at: size, element: element)
    }
}


fileprivate struct Constant {
    static let defautCapacity = 10;
    static let notFound = -1;
}

class DynamicArray<Element:Equatable> : LinkedList {
    enum ErrorType: Error {
        case message(_:String)
    }
    
    static var notFound:Int {
        Constant.notFound
    }
    
    private static var defautCapacity:Int {
        Constant.defautCapacity
    }
    
    private(set) var size = 0;
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
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
//    func contains(element: Element) -> Bool {
//        return index(of: element) != Self.notFound
//    }
    
//    func add(element: Element?)  {
//        addElement(at: size, element: element)
//    }
    
    func addElement(at index: Int, element: Element?) {
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
    
    func getElement(at index: Int) -> Element? {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        return elements[index];
    }
    
    subscript(index: Int) -> Element?  {
        get {
            return getElement(at: index)
        }
        set {
            setElement(at: index, element:newValue)
        }
    }
    
    func setElement(at index: Int, element: Element?) {
        guard cheackInBounds(at: index) else {
            fatalError("size = \(size),index = \(index),越界访问")
        }
        
        elements[index] = element
    }
    
    func remove(at index: Int) -> Element? {
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
    
    func index(of element: Element) -> Int {
        for index in (0..<size) {
            if elements[index] == element {
                return index
            }
        }
        
        return Self.notFound
    }
    
    func clear() {
        for index in 0..<size {
            elements[index] = nil
        }
        size = 0
    }
    
//    private func cheackInBounds(at index: Int) -> Bool {
//        if  index >= size {
//            return false;
//        }
//        
//        return true;
//    }
    
    
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

