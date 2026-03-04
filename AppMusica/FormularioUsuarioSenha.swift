//
//  FormularioUsuarioSenha.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI

struct FormularioUsuarioSenha: View {
    @Binding var usuario: String
    @Binding var senha: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Olá, digite usuário e senha:")
                .font(.title3)
                .padding(.horizontal)
                .padding(.top)
            TextField("Usuário", text: $usuario)
                .padding(.horizontal)
            
            SecureField("Senha", text: $senha)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background {
            Rectangle()
                .foregroundStyle(.white.opacity(0.5))
                .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    FormularioUsuarioSenha(usuario: .constant(""), senha: .constant(""))
}
