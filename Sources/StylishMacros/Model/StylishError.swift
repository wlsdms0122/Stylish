//
//  StylishError.swift
//
//
//  Created by jsilver on 11/26/23.
//

import Foundation

struct StylishError: CustomStringConvertible, Error {
    // MARK: - Property
    let description: String
    
    // MARK: - Initializer
    init(_ description: String) {
        self.description = description
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
