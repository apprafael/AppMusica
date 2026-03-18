//
//  AppMusicaApp.swift
//  AppMusica
//
//  Created by Rafael Almeida on 18/02/26.
//

import SwiftUI
import SwiftData

@main
struct AppMusicaApp: App {
    var body: some Scene {
        WindowGroup {
           LoginView()
        }
        .modelContainer(for: [Usuario.self, Musica.self])
    }
}
