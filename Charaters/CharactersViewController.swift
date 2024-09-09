//
//  ViewController.swift
//  rickNmorty
//
//  Created by Clement  Wekesa on 06/09/2024.
//

import UIKit
import Combine


class CharactersViewController: UIViewController {
    private let viewModel = CharactersViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var filterArea: UIView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacterTableView()
        viewModel.fetchCharacters()
        setupBindings()
    }
    
    private func setupCharacterTableView() {
        charactersTable.register(CharacterViewCell.self, forCellReuseIdentifier: "CharacterViewCell")
        
        charactersTable.delegate = self
        charactersTable.dataSource = self
    }
    
    private func setupBindings() {
        // Bind ViewModel data to the view
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.charactersTable.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                // Show or hide a loading indicator if needed
                if isLoading {
                    print("loading...")
                } else {
                    print("done loading.")
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func filterTapped() {
        let alert = UIAlertController(title: "Filter by Status", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "All", style: .default, handler: { _ in
            self.viewModel.filterCharacters(by: nil)
        }))
        alert.addAction(UIAlertAction(title: "Alive", style: .default, handler: { _ in
            self.viewModel.filterCharacters(by: "alive")
        }))
        alert.addAction(UIAlertAction(title: "Dead", style: .default, handler: { _ in
            self.viewModel.filterCharacters(by: "dead")
        }))
        alert.addAction(UIAlertAction(title: "Unknown", style: .default, handler: { _ in
            self.viewModel.filterCharacters(by: "unknown")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.characters.count)
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterViewCell", for: indexPath) as! CharacterViewCell
        
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character, cache: imageCache)
        
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.fetchCharacters()
        }
        
        return cell
    }
}
