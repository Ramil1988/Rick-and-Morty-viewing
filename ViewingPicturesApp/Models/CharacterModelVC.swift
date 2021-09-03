//
//  CharacterModelVC.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-51.
//  

import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let status: Status
    let gender: Gender
    let location: Location
    let image: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    var name: String
    var url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
