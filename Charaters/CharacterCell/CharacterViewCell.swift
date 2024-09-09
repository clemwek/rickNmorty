//
//  CharacterViewCell.swift
//  rickNmorty
//
//  Created by Clement  Wekesa on 09/09/2024.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
    var imageURL: URL?
    
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 50),
            characterImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            speciesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with character: Character, cache: NSCache<NSString, UIImage>) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        // Check if the image is cached
        if let cachedImage = cache.object(forKey: NSString(string: character.image)) {
            self.characterImageView.image = cachedImage
        } else {
            // Set a placeholder image until the image is loaded
            self.characterImageView.image = UIImage(named: "rickNmortysilhouette")
            loadImage(from: character.image, cache: cache)
        }
    }
    
    private func loadImage(from urlString: String, cache: NSCache<NSString, UIImage>) {
        guard let url = URL(string: urlString) else { return }
        self.imageURL = url
        
        // Fetch the image asynchronously
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            // Convert data to UIImage
            if let image = UIImage(data: data) {
                // Cache the image
                cache.setObject(image, forKey: NSString(string: urlString))
                
                // Ensure that the image is still relevant to the cell
                if self.imageURL == url {
                    DispatchQueue.main.async {
                        self.characterImageView.image = image
                    }
                }
            }
        }.resume()
    }
    
}
