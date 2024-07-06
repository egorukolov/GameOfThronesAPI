//
//  NetworkManager.swift
//  GameOfThronesAPI
//
//  Created by Egor Ukolov on 04.07.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var characters: [Character] = []
    
    private let charactersUrl = "https://thronesapi.com/api/v2/Characters"
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: charactersUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let characters = try decoder.decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(characters))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
