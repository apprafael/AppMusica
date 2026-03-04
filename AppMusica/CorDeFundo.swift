//
//  CorDeFundo.swift
//  AppMusica
//
//  Created by Rafael Almeida on 04/03/26.
//

import SwiftUI

struct CorDeFundo: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.blue.opacity(0.5), Color.green.opacity(0.5)]), startPoint: .top, endPoint: .trailing)
            .ignoresSafeArea()
    }
}

#Preview {
    CorDeFundo()
}
