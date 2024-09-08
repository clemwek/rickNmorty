//
//  NetworkManager.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 07/09/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchCharacters(page: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(RickAndMortyResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
