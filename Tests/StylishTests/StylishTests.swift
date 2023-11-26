import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(StylishMacros)
import StylishMacros

let testMacros: [String: Macro.Type] = [
    "Stylish": StylishMacro.self,
    "Style": StyleMacro.self,
]
#endif

final class StylishTests: XCTestCase {
    func testStylishMacro() throws {
        #if canImport(StylishMacros)
        assertMacroExpansion(
            """
            @Stylish
            public struct MyView: View {
                var body: some View {
                    Text("Hello World")
                }
            }
            """,
            expandedSource: """
            public struct MyView: View {
                var body: some View {
                    Text("Hello World")
                }
            }
            
            extension MyView: Stylish {
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testStyleMacro() throws {
        #if canImport(StylishMacros)
        assertMacroExpansion(
            #"""
            @Style
            public struct Configuration {
                var backgroundColor: Color = .black
                var foregroundColor: Color = .black
            }
            """#,
            expandedSource: #"""
            public struct Configuration {
                @Config
                var backgroundColor: Color = .black
                @Config
                var foregroundColor: Color = .black
            
                public init() {
                }
            }
            
            extension Configuration: StyleConfigurable {
            }
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
