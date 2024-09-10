//
//  CharacterNameView.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 09/09/2024.
//

import SwiftUI

struct CharacterNameView: View {
    let name: String
    let species: String
    let gender: String
    let status: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                HStack {
                    Text(species)
                    Text("•")
                    Text(gender)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer()
            Text(status)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

#Preview {
    CharacterNameView(name: "Morty", species: "Human", gender: "Male", status: "Alive")
}
