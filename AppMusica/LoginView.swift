//
//  LoginView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 18/02/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @State var usuario: String = ""
    @State var senha: String = ""
    
    @Query var usuarios: [Usuario]
    
    @State var usuarioFoiEncontrado = false
    @State var mostrarErro = false
    
    var body: some View {
        NavigationStack {
            
            if usuarioFoiEncontrado{
                HomeView()
            }
            else {
                ZStack {
                    CorDeFundo()
                    
                    VStack {

                        Image(systemName: "music.note")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                            )
                        
                        FormularioUsuarioSenha(usuario: $usuario, senha: $senha)
                        
                        Button {
                            usuarioFoiEncontrado = usuarios.contains { usuario in
                                return usuario.usuario == self.usuario && usuario.senha == self.senha
                            }
                            
                            if usuarioFoiEncontrado {
                                mostrarErro = false
                            } else {
                                mostrarErro = true
                            }
                        } label: {
                            Text("Entrar")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
    
                        
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(Color.gray)
                            Text("ou")
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        
                        NavigationLink("Registrar") {
                            RegistrarView()
                        }
                        .buttonStyle(.plain)
                    }
                }
                .alert("Erro de Autenticação", isPresented: $mostrarErro) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Usuário ou senha incorretos. Por favor, tente novamente.")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
