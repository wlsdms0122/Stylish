//
//  StylishMacro.swift
//
//
//  Created by jsilver on 11/26/23.
//

@attached(extension, conformances: Stylish)
@attached(member, names: named(init))
@attached(memberAttribute)
public macro Stylish() = #externalMacro(module: "StylishMacros", type: "StylishMacro")
