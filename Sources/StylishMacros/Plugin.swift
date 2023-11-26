//
//  Plugin.swift
//  
//
//  Created by jsilver on 11/26/23.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct StylishPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StylishMacro.self,
        StyleMacro.self
    ]
}
