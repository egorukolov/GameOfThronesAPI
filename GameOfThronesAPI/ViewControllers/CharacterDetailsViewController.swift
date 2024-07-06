//
//  CharacterDetailsViewController.swift
//  GameOfThronesAPI
//
//  Created by Egor Ukolov on 05.07.2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var character: Character?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var familyLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = character?.firstName ?? "Нет данных"
        lastNameLabel.text = character?.lastName ?? "Нет данных"
        titleLabel.text = character?.title ?? "Нет данных"
        familyLabel.text = character?.family ?? "Нет данных"
        
        
        guard let imageUrl = URL(string: character?.imageUrl ?? "") else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
            
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
