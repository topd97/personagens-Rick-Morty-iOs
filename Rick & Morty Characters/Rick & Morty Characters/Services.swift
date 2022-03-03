//
//  Services.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import Alamofire

class Services {
    static let shared = Services()
    
    var baseUrl: String  { return "https://rickandmortyapi.com/api/character" }
    
    func getRickMortyCharacters(_ completion: @escaping (([RickMortyCharacter]) -> Void)) {
        AF.request(
            "https://rickandmortyapi.com/api/character",
            method: .get
        ).response { (response) in
            guard let data = response.data else {
                // TODO: Handle corner case
                return
            }
            if let successResponse = try? JSONDecoder().decode(RequestResponse.self, from: data) {
                print("sucesso")
                completion(successResponse.results)
            } else {
                print("falha")
                // TODO: Handle corner case
            }
        }
    }
}

struct RequestResponse: Codable {
    let info: RequestResultInfo
    let results: [RickMortyCharacter]
}

struct RequestResultInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

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
