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
    private var selectedFilter: CharacterStatus = .clear
    
    @IBOutlet weak var filterArea: UIView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownButton: UIButton!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacterTableView()
        viewModel.fetchCharacters()
        setupBindings()
        setupFilterButton()
    }
    
    @IBAction func filterAlive(_ sender: Any) {
        selectedFilter == .alive ? filter(.clear, button: aliveButton) : filter(.alive, button: aliveButton)
    }
    
    @IBAction func filterDead(_ sender: Any) {
        deadButton.tintColor = .red
        selectedFilter == .dead ? filter(.clear, button: deadButton) : filter(.dead, button: deadButton)
    }
    
    @IBAction func filterUnknown(_ sender: Any) {
        unknownButton.tintColor = .blue
        selectedFilter == .unknown ? filter(.clear, button: unknownButton) : filter(.unknown, button: unknownButton)
    }
    
    private func filter(_ type: CharacterStatus, button: UIButton) {
        switch type {
        case .alive:
            button.isSelected = true
            button.tintColor = .green
            deadButton.tintColor = .clear
            unknownButton.tintColor = .clear
            selectedFilter = .alive
            viewModel.filterCharacters(by: .alive)
        case .dead:
            button.isSelected = true
            button.tintColor = .red
            aliveButton.tintColor = .clear
            unknownButton.tintColor = .clear
            selectedFilter = .dead
            viewModel.filterCharacters(by: .dead)
        case .unknown:
            button.isSelected = true
            button.tintColor = .blue
            aliveButton.tintColor = .clear
            deadButton.tintColor = .clear
            selectedFilter = .unknown
            viewModel.filterCharacters(by: .unknown)
        case .clear:
            button.isSelected = false
            button.tintColor = .clear
            selectedFilter = .clear
            viewModel.filterCharacters(by: .clear)
        }
    }
    
    private func setupFilterButton() {
        aliveButton.layer.cornerRadius = 12
        aliveButton.layer.borderWidth = 1.0
        aliveButton.layer.borderColor = UIColor.lightGray.cgColor
        
        deadButton.layer.cornerRadius = 12
        deadButton.layer.borderWidth = 1.0
        deadButton.layer.borderColor = UIColor.lightGray.cgColor
        
        unknownButton.layer.cornerRadius = 12
        unknownButton.layer.borderWidth = 1.0
        unknownButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupCharacterTableView() {
        charactersTable.register(CharacterViewCell.self, forCellReuseIdentifier: "CharacterViewCell")
        charactersTable.rowHeight = 120
        
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
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.characters.count)
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterViewCell", for: indexPath) as! CharacterViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character, cache: imageCache)
        
        
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.fetchCharacters()
        }
        
        return cell
    }
}
