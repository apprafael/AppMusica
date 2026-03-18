//
//  ItunesLista.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI
import SwiftData
 
struct Response : Codable {
    var musicas: [Musica]
    
    enum CodingKeys: String, CodingKey {
        case musicas = "results"
    }
}
 
@Model
class Musica : Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case collectionName
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackId = try container.decode(Int.self, forKey: .trackId)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.collectionName = try container.decode(String.self, forKey: .collectionName)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trackId, forKey: .trackId)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(collectionName, forKey: .collectionName)
    }
    
    init(trackId: Int, trackName: String, collectionName: String) {
        self.trackId = trackId
        self.trackName = trackName
        self.collectionName = collectionName
    }
}
 
struct ItunesLista: View {
    @State private var results = [Musica] ()
    @State private var termoDeBusca = "eminem"
        
    var body: some View {
        NavigationStack {
            ListaDeMusicaView(musicas: results)
                .task {
                    await loadData()
                }
        }
        .searchable(text: $termoDeBusca)
        .onChange(of: termoDeBusca) { oldValue, newValue in
            Task {
                await loadData()
            }
        }
    }
    
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(termoDeBusca)&entity=song") else {
            print (" Inavalid Url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.musicas
            }
        }catch {
            print("Invalid data")
        }
            
    }
    
}
 
#Preview {
    ItunesLista()
}
