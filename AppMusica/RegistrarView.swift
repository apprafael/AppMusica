//
//  RegistrarView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 18/02/26.
//

import SwiftUI
import SwiftData
 
struct RegistrarView: View {
    @State var usuario: String = ""
    @State var senha: String = ""
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
            CorDeFundo()
            
            VStack {
                FormularioUsuarioSenha(usuario: $usuario, senha: $senha)
                
                Button("Registrar") {
                    modelContext.insert(Usuario(usuario: usuario, senha: senha))
                    
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}
 
#Preview {
    RegistrarView()
}
