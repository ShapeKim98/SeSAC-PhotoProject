import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ConfigurableMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            return []
        }
        let members = classDecl.memberBlock.members
        
        let funcDecls = members.compactMap { $0.decl.as(FunctionDeclSyntax.self)?.name.text }
        let configureFuncDecl = funcDecls.filter {
            $0 != "configureUI"
            && $0 != "configureLayout"
            && $0.hasPrefix("configure")
        }
        let calls = configureFuncDecl.map { "\($0)()" }.joined(separator: "\n")
        
        let configureUIFunc = DeclSyntax(stringLiteral:"""
        private func configureUI() {
            \(calls)
        }
        """)
        
        return [configureUIFunc]
    }
}

@main
struct BaseKitPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ConfigurableMacro.self,
    ]
}
