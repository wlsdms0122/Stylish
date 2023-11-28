//
//  Styles.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

@dynamicMemberLookup
public struct Styles {
    public struct Key: EnvironmentKey {
        public static var defaultValue = Styles()
    }
    
    // MARK: - Property
    private var configurations: [String: Any] = [:]

    subscript<Configuration: StyleConfigurable>(dynamicMember member: String) -> Configuration {
        get {
            guard let configuration = configurations[member] else { return Configuration() }
            return (configuration as? Configuration) ?? Configuration()
        }
        set {
            configurations[member] = newValue
        }
    }
    
    // MARK: - Initializer
    
    // MARK: - Public
    
    // MARK: - Private
}
