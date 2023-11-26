//
//  Stylish.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftUI

public protocol Stylish: View {
    associatedtype Configuration: StyleConfigurable
}

public protocol StyleConfigurable {
    init()
}
