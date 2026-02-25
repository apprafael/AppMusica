//
//  Item.swift
//  AppMusica
//
//  Created by Rafael Almeida on 18/02/26.
//

import Foundation
import SwiftData
 
@Model
final class Usuario {
    var usuario: String
    var senha: String
    
    init(usuario: String, senha: String) {
        self.usuario = usuario
        self.senha = senha
    }
}
