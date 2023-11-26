//
//  View+Stylish.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

public extension EnvironmentValues {
    var styles: Styles {
        get { self[Styles.Key.self] }
        set { self[Styles.Key.self] = newValue }
    }
}

public extension View {
    func configure<S: Stylish, Value>(
        _ type: S.Type,
        path keyPath: WritableKeyPath<S.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let member = String(describing: type)
        
        let originPath = \EnvironmentValues.styles
        let configurationPath: WritableKeyPath<Styles, S.Configuration> = \Styles.[dynamicMember: member]
        let stylePath = originPath.appending(path: configurationPath)
            .appending(path: keyPath)
        
        return environment(stylePath, value)
    }
}
