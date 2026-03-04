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
            ListaDeMusicasView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            ListDeMusicasFavoritasView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}
 
#Preview {
    HomeView()
}
