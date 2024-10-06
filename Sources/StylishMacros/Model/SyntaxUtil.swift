//
//  SyntaxUtil.swift
//  Stylish
//
//  Created by JSilver on 10/5/24.
//

import SwiftSyntaxBuilder
import SwiftSyntax

extension StructDeclSyntax {
    func isInherited<T>(_ type: T.Type) -> Bool {
        let typeText = String(describing: type)
        
        return inheritanceClause?.inheritedTypes.contains { syntax in
            syntax.type.as(IdentifierTypeSyntax.self)?.name.text == typeText
        } ?? false
    }
}

extension DeclGroupSyntax {
    var accessModifier: DeclModifierSyntax? {
        modifiers.first { syntax in
            [
                TokenSyntax.keyword(.open).text,
                TokenSyntax.keyword(.public).text,
                TokenSyntax.keyword(.internal).text,
                TokenSyntax.keyword(.private).text,
                TokenSyntax.keyword(.accesses).text
            ]
                .contains(syntax.name.text)
        }
    }
}

extension SyntaxStringInterpolation {
    mutating func appendInterpolation<Node: SyntaxProtocol>(_ node: Node?) {
        if let node {
            appendInterpolation(node)
        }
    }
}
