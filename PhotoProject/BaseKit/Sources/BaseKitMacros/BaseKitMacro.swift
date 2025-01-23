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
        
        var decls = [DeclSyntax]()
        
        if members.contains(where: { $0.decl.is(InitializerDeclSyntax.self) }) {
            decls.append(DeclSyntax(stringLiteral:"""
            @available(*, unavailable)
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            """))
        }
        
        let funcDecls = members.compactMap { $0.decl.as(FunctionDeclSyntax.self)?.name.text }
        let configureFuncDecl = funcDecls.filter {
            $0 != "configureUI"
            && $0 != "configureLayout"
            && $0.hasPrefix("configure")
        }
        if !configureFuncDecl.isEmpty {
            let calls = configureFuncDecl.map { "\($0)()" }.joined(separator: "\n")
            
            decls.append(DeclSyntax(stringLiteral:"""
            private func configureUI() {
                \(calls)
            }
            """))
        }
        
        return decls
    }
}

@main
struct BaseKitPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ConfigurableMacro.self,
    ]
}
