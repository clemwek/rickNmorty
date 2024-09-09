//
//  CharactersViewModel.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 07/09/2024.
//

import Combine


class CharactersViewModel {
    // Publisher to notify the view when the characters change
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false

    private var currentPage = 1
    private var canFetchMore = true
    private var filterStatus: String?

    // Fetch characters from API
    func fetchCharacters() {
        guard !isLoading, canFetchMore else { return }
        isLoading = true
        
        NetworkManager.shared.fetchCharacters(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let newCharacters):
                if let filter = self.filterStatus {
                    let filteredCharacters = newCharacters.filter { $0.status.lowercased() == filter }
                    self.characters += filteredCharacters
                } else {
                    self.characters += newCharacters
                }
                self.currentPage += 1
                self.canFetchMore = !newCharacters.isEmpty
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }
    }

    // Filter characters by status
    func filterCharacters(by status: String?) {
        self.filterStatus = status
        self.characters.removeAll()
        self.currentPage = 1
        self.canFetchMore = true
        fetchCharacters()
    }
}

