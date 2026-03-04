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
                    LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue, Color.green]), startPoint: .top, endPoint: .trailing)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        //                    Text(usuarios.first?.usuario ?? "")
                        //Text("Foi encontrado? \(usuarioFoiEncontrado)")
                        Image("music_image")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        TextField("Usuário", text: $usuario)
                            .padding()
                        
                        SecureField("Senha", text: $senha)
                            .padding()
                        
                        Button("Entrar") {
                            usuarioFoiEncontrado = usuarios.contains { usuario in
                                return usuario.usuario == self.usuario && usuario.senha == self.senha
                            }
                            
                            if usuarioFoiEncontrado {
                                mostrarErro = false
                            } else {
                                mostrarErro = true
                            }
                            
                        }
                        .buttonStyle(.glassProminent)
                        
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
                        .buttonStyle(.glass)
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
