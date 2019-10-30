//
//  main.swift
//  LinkedList
//
//  Created by Maxim Sidorov on 26.10.2019.
//  Copyright © 2019 Maxim Sidorov. All rights reserved.
//

import Foundation

indirect enum List<T> {
    
    case node(elem: T, next: List<T>)
    case end
    
    init() {
        self = .end
    }
    
    init(element: T) {
        self = .node(elem: element, next: .end)
    }
    
    func size() -> UInt {
        var size: UInt = 0
        var list = self
        while !list.isEmpty() {
            list = list.getNext()
            size += 1
        }
        return size
    }
    
    mutating func addFirst(element: T) {
        let newNode = List<T>.node(elem: element, next: self)
        self = newNode
    }
    
    func getNext() -> List<T> {
        switch self {
        case let .node(_, next):
            return next
        default:
            return .end
        }
    }
    
    func getElem(at index: UInt) -> T? {
        var list = self
        for _ in 0..<index {
            list = list.getNext()
        }
        switch list {
        case let .node(elem, _):
            return elem
        default:
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        switch self {
        case .end:
            return true
        default:
            return false
        }
    }
    
    func vNextAdd(e: T, list: List<T>) -> List<T> {
        switch list {
        case let .node(elem, next):
            return .node(elem: elem, next: vNextAdd(e: e, list: next))
        case .end:
            return .node(elem: e, next: .end)
        }
    }
    
    mutating func addLast(element: T) {
        switch self {
        case let .node(elem, next):
            self = .node(elem: elem, next: vNextAdd(e: element, list: next))
        case .end:
            self = .node(elem: element, next: .end)
        }
    }
    
    func vIndNextAdd(e: T, list: List<T>, ind: UInt) -> List<T> {
        switch list {
        case let .node(elem, next):
            if (ind == 1) {
                return .node(elem: e, next: list)
            }
            return .node(elem: elem, next: vIndNextAdd(e: e, list: next, ind: ind - 1))
        case .end:
            return .node(elem: e, next: .end)
        }
    }
    
    mutating func add(at index: UInt, element: T) {
        if index == 0 {
            addFirst(element: element)
        } else {
            switch self {
            case let .node(elem, next):
                self = .node(elem: elem, next: vIndNextAdd(e: element, list: next, ind: index))
            case .end:
                self = .node(elem: element, next: .end)
            }
        }
    }
    
    mutating func removeFirst() {
        switch self {
        case let .node(_, next):
            self = next
        default:
            break
        }
    }
    
    func vNextRemove(list: List<T>) -> List<T> {
        switch list {
        case let .node(elem1, next1):
            switch next1 {
            case .node(_, _):
                return .node(elem: elem1, next: vNextRemove(list: next1))
            case .end:
                return .end
            }
        case .end: return .end
        }
    }
    
    mutating func removeLast() {
        self = vNextRemove(list: self)
    }
    
    func vIndNextRemove(at index: UInt, list: List<T>) -> List<T> {
        switch list {
        case let .node(elem1, next1):
            switch next1 {
            case .node(_, _):
                if index == 0 {
                    return next1
                }
                return .node(elem: elem1, next: vIndNextRemove(at: index - 1, list: next1))
            case .end:
                return .end
            }
        case .end:
            return .end
        }
    }
    
    mutating func remove(at index: UInt) {
        if index == 0 {
            removeFirst()
        } else {
            self = vIndNextRemove(at: index, list: self)
        }
    }
    
    func printList() {
        var list = self
        if list.isEmpty() {
            print("Empty")
        }
        while !list.isEmpty() {
            switch list {
            case let .node(elem, _):
                print(elem)
                list = list.getNext()
            default:
                break
            }
        }
    }
}
