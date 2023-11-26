//
//  Config.swift
//
//
//  Created by jsilver on 11/26/23.
//

import Foundation

@propertyWrapper
public struct Config<Value> {
    // MARK: - Property
    private var isSet: Bool = false
    public var wrappedValue: Value {
        didSet {
            isSet = true
        }
    }
    
    public var projectedValue: (Value) -> Value {
        {
            isSet ? wrappedValue : $0
        }
    }
    
    // MARK: - Initializer
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
