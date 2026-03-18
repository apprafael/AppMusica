//
//  ListaDeMusicasFavoritasView.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI
import SwiftData

struct ListaDeMusicasFavoritasView: View {
    @Query var musicas: [Musica]
    
    var body: some View {
        ListaDeMusicaView(musicas: musicas)
    }
}

#Preview {
    ListaDeMusicasFavoritasView()
}

//    var resultadosFiltrados: [Result] {
//        if termoDeBusca.isEmpty {
//            return results
//        } else {
//            return results.filter { faixa in
//                // Aqui a busca ignora o 'ç', o 'ê' e as maiúsculas
//                faixa.trackName.localizedStandardContains(termoDeBusca)
//            }
//        }
//    }
