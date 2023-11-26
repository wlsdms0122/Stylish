//
//  StylishError.swift
//
//
//  Created by jsilver on 11/26/23.
//

import Foundation

struct StylishError: CustomStringConvertible, Error {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
}
