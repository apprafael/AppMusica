//
//  ItunesLista.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import Combine
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

class ItunesListaViewModel: ObservableObject {
    @Published var busca = ""
    @Published var debouncedBusca = ""
    
    init() {
        $debouncedBusca
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$busca)
    }
}
 
struct ItunesLista: View {
    @StateObject var viewModel = ItunesListaViewModel()
    
    @State private var results = [Musica]()
    @State private var textoBuscaDaTela = ""
    @State private var textoBusca = ""
        
    var body: some View {
        ListaDeMusicaView(musicas: results)
            .task {
                await loadData()
            }
            .safeAreaInset(edge: .bottom) {
                TextField("Busca", text: $viewModel.debouncedBusca)
                    .background(
                        Rectangle()
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    )
                    .padding()
                    .shadow(radius: 5)
            }
            .onChange(of: viewModel.busca) { _, _ in
                Task {
                    await loadData()
                }
            }
    }
    
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(viewModel.busca)&entity=song") else {
            print ("Inavalid Url")
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
