//
//  StylishTests.swift
//
//
//  Created by jsilver on 11/26/23.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
#if canImport(StylishMacros)
import StylishMacros

final class StylishMacroTests: XCTestCase {
    // MARK: - Property
    let macros = ["Stylish": StylishMacro.self]
    
    // MARK: - Lifecycle
    
    // MARK: - Test
    func testExpansionEmptyOption() throws {
        assertMacroExpansion("""
            @Stylish
            struct Option { 
            
            }
            """,
            expandedSource:
            """
            struct Option { 

                init() {
                }

            }

            extension Option: Stylish {
            }
            """,
            macros: macros
        )
    }
    
    func testExpansionOption() throws {
        assertMacroExpansion(
            """
            @Stylish
            struct Option { 
                var text: String = "hello world"
            }
            """,
            expandedSource:
            """
            struct Option { 
                @Config
                var text: String = "hello world"

                init() {
                }
            }

            extension Option: Stylish {
            }
            """,
            macros: macros
        )
    }
    
    func testExpansionPublicOption() throws {
        assertMacroExpansion(
            """
            @Stylish
            public struct Option { 
                public var text: String = "hello world"
            }
            """,
            expandedSource:
            """
            public struct Option { 
                @Config
                public var text: String = "hello world"

                public init() {
                }
            }

            extension Option: Stylish {
            }
            """,
            macros: macros
        )
    }
}

#endif
