//
//  StructDeclSyntax+Extension.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftSyntax

extension StructDeclSyntax {
    func isInherited<T>(_ type: T.Type) -> Bool {
        let typeText = String(describing: type)
        
        return inheritanceClause?.inheritedTypes.contains(where: { syntax in
            syntax.type.as(IdentifierTypeSyntax.self)?.name.text == typeText
        }) ?? false
    }
    
    var accessModifier: DeclModifierSyntax? {
        modifiers.first { syntax in
            [
                TokenSyntax.keyword(.open).text,
                TokenSyntax.keyword(.public).text,
                TokenSyntax.keyword(.internal).text,
                TokenSyntax.keyword(.private).text
            ]
                .contains(syntax.name.text)
        }
    }
}
