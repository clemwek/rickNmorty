//
//  ViewController.swift
//  rickNmorty
//
//  Created by Clement  Wekesa on 06/09/2024.
//

import UIKit

class CharactersViewController: UIViewController {

    
    @IBOutlet weak var filterArea: UIView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTable.dataSource = self
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test text"
        return cell
    }
}
