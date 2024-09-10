//
//  CharacterDetailsViewController.swift
//  rickNmorty
//
//  Created by Clement Wekesa on 09/09/2024.
//

import UIKit
import SwiftUI

class CharacterDetailsViewController: UIViewController {
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupNavigation()
    }
    
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func setupNavigation() {
        let imgBack = UIImage(systemName: "arrow.left")
        
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    private func setupUI() {
        // 1. Profile Image SwiftUI View
        let imageView = CharacterImageView(imageUrl: character.image)
        let imageHostingController = UIHostingController(rootView: imageView)
        
        // 2. Character Name SwiftUI View
        let nameView = CharacterNameView(name: character.name, species: character.species, gender: character.gender, status: character.status)
        let nameHostingController = UIHostingController(rootView: nameView)
        
        // 3. Character Status SwiftUI View
        let statusView = CharacterStatusView(location: character.location.name)
        let statusHostingController = UIHostingController(rootView: statusView)
        
        // Add SwiftUI views as child view controllers
        addChild(imageHostingController)
        addChild(nameHostingController)
        addChild(statusHostingController)
        
        // Add the views
        view.addSubview(imageHostingController.view)
        view.addSubview(nameHostingController.view)
        view.addSubview(statusHostingController.view)
        
        imageHostingController.didMove(toParent: self)
        nameHostingController.didMove(toParent: self)
        statusHostingController.didMove(toParent: self)
        
        // Set up Auto Layout for each SwiftUI view
        imageHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        nameHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        statusHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Image constraints
            imageHostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageHostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageHostingController.view.heightAnchor.constraint(equalToConstant: 250),
            
            // Name view constraints
            nameHostingController.view.topAnchor.constraint(equalTo: imageHostingController.view.bottomAnchor, constant: 90),
            nameHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Status view constraints
            statusHostingController.view.topAnchor.constraint(equalTo: nameHostingController.view.bottomAnchor, constant: 16),
            statusHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
