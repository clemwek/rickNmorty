//
//  CharacterImageView.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 09/09/2024.
//

import SwiftUI

struct CharacterImageView: View {
    let imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    CharacterImageView(imageUrl: "https://rickandmortyapi.com/api/character/avatar/361.jpeg")
}
