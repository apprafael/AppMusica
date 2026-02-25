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
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                TextField("Usuário", text: $usuario)
                    .padding()
                
                SecureField("Senha", text: $senha)
                    .padding()
                
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
