//
//  Style.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

@propertyWrapper
public struct Style<Value>: DynamicProperty {
    // MARK: - Property
    @Environment
    private var environment: Value
    
    public var wrappedValue: Value { environment }
    
    // MARK: - Initializer
    public init(
        _ option: Value.Type
    ) where Value: Stylish {
        let member = String(describing: option)
        
        let originPath = \EnvironmentValues.container
        let configurationPath: WritableKeyPath<StyleContainer, Value> = \StyleContainer.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
        
        self._environment = .init(stylePath)
    }
    
    public init<S: Stylish>(
        _ option: S.Type,
        style keyPath: KeyPath<S, Value>
    ) {
        let member = String(describing: option)
        
        let originPath = \EnvironmentValues.container
        let configurationPath: WritableKeyPath<StyleContainer, S> = \StyleContainer.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
            .appending(path: keyPath)
        
        self._environment = .init(stylePath)
    }
    
    public init<Component: StyledComponent>(
        _ component: Component.Type
    ) where Value: Stylish, Component.StyleOption == Value {
        self.init(Component.StyleOption.self)
    }
    
    public init<Component: StyledComponent>(
        _ component: Component.Type,
        style keyPath: KeyPath<Component.StyleOption, Value>
    ) {
        self.init(Component.StyleOption.self, style: keyPath)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
