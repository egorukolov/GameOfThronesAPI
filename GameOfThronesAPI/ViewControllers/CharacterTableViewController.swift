//
//  TableViewController.swift
//  GameOfThronesAPI
//
//  Created by Egor Ukolov on 04.07.2024.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "Thrones Characters"
        loadCharacters()
    }
    
    func loadCharacters() {
        
        NetworkManager.shared.fetchCharacters { [weak self] result in
                    switch result {
                    case .success(let characters):
                        self?.characters = characters
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print("Ошибка загрузки персонажей: \(error.localizedDescription)")
                    }
                }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "characterDetails", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.fullName
        return cell
    }



    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let character = characters[indexPath.row]
        
        let destinationVC = segue.destination as! CharacterDetailsViewController
        destinationVC.character = character
    }
    

}
