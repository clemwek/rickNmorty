//
//  CharacterViewCell.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 09/09/2024.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
    var imageURL: URL?
    
    private let characterCellView = UIView()
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
        characterCellView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        characterCellView.layer.cornerRadius = CGFloat(25)
        characterCellView.layer.borderWidth = 1.0
        characterCellView.layer.borderColor = UIColor.lightGray.cgColor
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        speciesLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
        
        
        contentView.addSubview(characterCellView)
        characterCellView.addSubview(characterImageView)
        characterCellView.addSubview(nameLabel)
        characterCellView.addSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            
            characterCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            characterImageView.leadingAnchor.constraint(equalTo: characterCellView.leadingAnchor, constant: 10),
            characterImageView.centerYAnchor.constraint(equalTo: characterCellView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 64),
            characterImageView.heightAnchor.constraint(equalToConstant: 64),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 0),
            
            speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
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
