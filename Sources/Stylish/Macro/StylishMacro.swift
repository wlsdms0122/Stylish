//
//  StylishMacro.swift
//
//
//  Created by jsilver on 11/26/23.
//

@attached(extension, conformances: Stylish)
public macro Stylish() = #externalMacro(module: "StylishMacros", type: "StylishMacro")

@attached(extension, conformances: StyleConfigurable)
@attached(member, names: named(init))
@attached(memberAttribute)
public macro Style() = #externalMacro(module: "StylishMacros", type: "StyleMacro")
