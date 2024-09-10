//
//  Character.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 07/09/2024.
//


struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let location: CharacterLocation
}

struct PaginationInfo: Codable {
    let next: String?
}

struct RickAndMortyResponse: Codable {
    let results: [Character]
    let info: PaginationInfo
}
struct CharacterLocation: Codable {
    let name: String
}
