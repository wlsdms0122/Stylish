import SwiftSyntax
import SwiftSyntaxMacros
import SwiftUI

public struct StylishMacro { }

extension StylishMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self), structDecl.isInherited((any View).self) else {
            throw StylishError("@Stylish can use struct and adopt View protocol only.")
        }
        
        let extenstion = DeclSyntax("""
            extension \(type.trimmed): Stylish { }
            """)
        
        return [
            extenstion
        ]
            .compactMap { $0.as(ExtensionDeclSyntax.self) }
    }
}
