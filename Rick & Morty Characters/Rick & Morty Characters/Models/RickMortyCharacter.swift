//
//  RickMortyCharacter.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

struct RickMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RickMortyCharacterOrigin
    let location: RickMortyCharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct RickMortyCharacterLocation: Codable {
    let name: String
    let url: String
}

struct RickMortyCharacterOrigin: Codable {
    let name: String
    let url: String
}
