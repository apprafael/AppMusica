//
//  ItunesLista.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI
 
struct Response : Codable {
    var results: [Result]
}
 
struct Result : Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
 
struct ItunesLista: View {
    @State private var results = [Result] ()
    @State private var termoDeBusca = "eminem"

    
    var body: some View {
        NavigationStack {
            List (results, id: \.trackId) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                    }
                    
                    Spacer()
                    
                    Button("") {
                      // salvar a faixa de música na lista de favoritos
                    }
                    .padding()
                    .background {
                        Image(systemName: "heart")
                    }
                }
            }
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
                results = decodedResponse.results
            }
        }catch {
            print("Invalid data")
        }
            
    }
    
}
 
#Preview {
    ItunesLista()
}
