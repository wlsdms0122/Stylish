//
//  StyledComponentTests.swift
//  Stylish
//
//  Created by JSilver on 10/6/24.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
#if canImport(StylishMacros)
import StylishMacros

final class StyledComponentTests: XCTestCase {
    // MARK: - Property
    let macros = ["StyledComponent": StyledComponentMacro.self]
    
    // MARK: - Lifecycle
    
    // MARK: - Test
    func testExpansion() throws {
        assertMacroExpansion("""
            struct Option { }
            
            @StyledComponent(Option.self)
            struct CustomView: View { 
                
            }
            """,
            expandedSource:
            """
            struct Option { }
            struct CustomView: View { 

                typealias StyleOption = Option
                
            }

            extension CustomView: StyledComponent {
            }
            """,
            macros: macros
        )
    }
    
    func testExpansionPublicComponent() throws {
        assertMacroExpansion("""
            struct Option { }
            
            @StyledComponent(Option.self)
            public struct CustomView: View { 
                
            }
            """,
            expandedSource:
            """
            struct Option { }
            public struct CustomView: View { 

                public typealias StyleOption = Option
                
            }

            extension CustomView: StyledComponent {
            }
            """,
            macros: macros
        )
    }
}

#endif
