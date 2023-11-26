//
//  EnvironmentConfig.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

@propertyWrapper
public struct EnvironmentConfig<S: Stylish, Value>: DynamicProperty {
    // MARK: - Property
    @Environment
    private var environment: Value
    
    public var wrappedValue: Value { environment }
    
    // MARK: - Initializer
    public init(
        _ type: S.Type,
        path keyPath: KeyPath<S.Configuration, Value>
    ) {
        let member = String(describing: type)
        
        let originPath = \EnvironmentValues.styles
        let configurationPath: WritableKeyPath<Styles, S.Configuration> = \Styles.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
            .appending(path: keyPath)
        
        self._environment = .init(stylePath)
    }
    
    public init(
        _ type: S.Type
    ) where S.Configuration == Value {
        let member = String(describing: type)
        
        let originPath = \EnvironmentValues.styles
        let configurationPath: WritableKeyPath<Styles, S.Configuration> = \Styles.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
        
        self._environment = .init(stylePath)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
