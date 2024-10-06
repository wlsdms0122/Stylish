//
//  StyleContainer.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

@dynamicMemberLookup
struct StyleContainer {
    struct Key: EnvironmentKey {
        public static var defaultValue = StyleContainer()
    }
    
    // MARK: - Property
    private var styles: [String: Any] = [:]

    subscript<S: Stylish>(dynamicMember member: String) -> S {
        get {
            guard let style = styles[member] else { return S() }
            return (style as? S) ?? S()
        }
        set {
            styles[member] = newValue
        }
    }
    
    // MARK: - Initializer
    
    // MARK: - Public
    
    // MARK: - Private
}
