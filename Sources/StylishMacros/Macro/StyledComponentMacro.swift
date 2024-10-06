//
//  StyledComponentMacro.swift
//  Stylish
//
//  Created by JSilver on 10/5/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct StyledComponentMacro { }

extension StyledComponentMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let extenstion: DeclSyntax = "extension \(type.trimmed): StyledComponent { }"
        
        return [
            extenstion
        ]
            .compactMap { $0.as(ExtensionDeclSyntax.self) }
    }
}

extension StyledComponentMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard case let .argumentList(arguments) = node.arguments,
            let memberAccessExpression = arguments.first?.expression.as(MemberAccessExprSyntax.self),
            let optionType = memberAccessExpression.base?.as(DeclReferenceExprSyntax.self)
        else {
            throw StylishError("@StyledComponent requires the Stylish Option type as an argument.")
        }
        
        let accessModifier = declaration.accessModifier
        let typealiasDeclaration: DeclSyntax = "\(accessModifier)typealias StyleOption = \(optionType)"
        
        return [
            typealiasDeclaration
        ]
    }
}
