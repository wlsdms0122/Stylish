//
//  StyleMacro.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct StyleMacro { }

extension StyleMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let extenstion = DeclSyntax("""
            extension \(type.trimmed): StyleConfigurable { }
            """)
        
        return [
            extenstion
        ]
            .compactMap { $0.as(ExtensionDeclSyntax.self) }
    }
}

extension StyleMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw StylishError("@Styly can use struct only.")
        }
        
        var initializer: DeclSyntax
        if let accessModifier = structDecl.accessModifier?.name.text {
            initializer = "\(raw: accessModifier) init() { }"
        } else {
            initializer = "init() { }"
        }
        
        return [
            initializer
        ]
    }
}

extension StyleMacro: MemberAttributeMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        return [
            AttributeSyntax(
                leadingTrivia: [.newlines(1), .spaces(2)],
                attributeName: IdentifierTypeSyntax(
                    name: .identifier("Config")
                )
            )
        ]
    }
}
