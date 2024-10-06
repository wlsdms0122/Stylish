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

@attached(extension, conformances: StyledComponent)
@attached(member, names: named(StyleOption), named(option))
public macro StyledComponent<Option: Stylish>(_: Option.Type) = #externalMacro(module: "StylishMacros", type: "StyledComponentMacro")
