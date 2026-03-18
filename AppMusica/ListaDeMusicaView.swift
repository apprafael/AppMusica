//
//  ListaDeMusicaView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 18/03/26.
//

import SwiftUI
import SwiftData

struct ListaDeMusicaView: View {
    @Environment(\.modelContext) var modelContext

    var musicas: [Musica]
    
    @Query var musicasDB: [Musica]
    
    var body: some View {
        List (musicas, id: \.trackId) { musica in
            HStack {
                VStack(alignment: .leading) {
                    Text(musica.trackName)
                        .font(.headline)
                    Text(musica.collectionName)
                }
                
                Spacer()
                
                Button("") {
                    if let musicaDB = musicaExisteNoBancoDeDados(musica: musica) {
                        modelContext.delete(musicaDB)
                    } else {
                        modelContext.insert(musica)
                    }
                }
                .padding()
                .background {
                    Image(systemName: musicaExisteNoBancoDeDados(musica: musica) != nil ? "heart.fill" : "heart")
                }
            }
        }
    }
    
    func musicaExisteNoBancoDeDados(musica: Musica) -> Musica? {
        musicasDB.first(where: { musicaDB in musicaDB.trackId == musica.trackId})
    }
}

//@StateObject var viewModel = ListaDeMusicaViewModel()

//class ListaDeMusicaViewModel: ObservableObject {
//    @Published var buttonToggle = false
//}
