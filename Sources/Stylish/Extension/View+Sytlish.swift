//
//  View+Stylish.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

extension EnvironmentValues {
    var container: StyleContainer {
        get { self[StyleContainer.Key.self] }
        set { self[StyleContainer.Key.self] = newValue }
    }
}

public extension View {
    func config<S: Stylish, Value>(
        _ style: S.Type,
        style keyPath: WritableKeyPath<S, Value>,
        to value: Value
    ) -> some View {
        let member = String(describing: style)
        
        let originPath = \EnvironmentValues.container
        let configurationPath: WritableKeyPath<StyleContainer, S> = \StyleContainer.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
            .appending(path: keyPath)
        
        return environment(stylePath, value)
    }
    
    func config<Component: StyledComponent, Value>(
        _ component: Component.Type,
        style keyPath: WritableKeyPath<Component.StyleOption, Value>,
        to value: Value
    ) -> some View {
        config(Component.StyleOption.self, style: keyPath, to: value)
    }
}
