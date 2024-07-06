//
//  Model.swift
//  GameOfThronesAPI
//
//  Created by Egor Ukolov on 04.07.2024.
//

import Foundation

struct Character: Codable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let image: String
    let imageUrl: String?
}
