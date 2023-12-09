//
//  Styles.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

@propertyWrapper
public struct Styles<Value>: DynamicProperty {
    // MARK: - Property
    @Environment
    private var environment: Value
    
    public var wrappedValue: Value { environment }
    
    // MARK: - Initializer
    public init<S: Stylish>(
        _ style: S.Type,
        style keyPath: KeyPath<S, Value>
    ) {
        let member = String(describing: style)
        
        let originPath = \EnvironmentValues.container
        let configurationPath: WritableKeyPath<StyleContainer, S> = \StyleContainer.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
            .appending(path: keyPath)
        
        self._environment = .init(stylePath)
    }
    
    public init(
        _ style: Value.Type
    ) where Value: Stylish {
        let member = String(describing: style)
        
        let originPath = \EnvironmentValues.container
        let configurationPath: WritableKeyPath<StyleContainer, Value> = \StyleContainer.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
        
        self._environment = .init(stylePath)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
