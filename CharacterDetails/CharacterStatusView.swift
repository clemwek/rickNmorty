//
//  CharacterStatusView.swift
//  rickNmorty
//
//  Created by Clement  Wekesa on 09/09/2024.
//

import SwiftUI

struct CharacterStatusView: View {
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                HStack {
                    Text("Location:")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(location)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CharacterStatusView(location: "Earth")
}
