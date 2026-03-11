//
//  HomeView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    var body: some View {
            TabView {
                ItunesLista()
                    .tabItem {
                        Label("Musicas", systemImage: "list.dash")
                    }
                
                ListaDeMusicasFavoritasView()
                    .tabItem {
                        Label("Favoritas", systemImage: "heart.fill")
                    }
            }
        }
}

#Preview {
    HomeView()
}
