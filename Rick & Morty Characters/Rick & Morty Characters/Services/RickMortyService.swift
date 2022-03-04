//
//  Services.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//
import Alamofire

protocol RickMortyServiceProtocol {
    func getRickMortyCharacters(page: Int) async throws -> [RickMortyCharacter]
    func getRickMortyEpisode(url: String) async throws -> RickMortyEpisode
}

class RickMortyService: RickMortyServiceProtocol {
    static let shared = RickMortyService()
    
    var baseUrl: String  { return "https://rickandmortyapi.com/api/" }
    
    func getRickMortyCharacters(page: Int) async throws -> [RickMortyCharacter] {
        return try await AF.request(baseUrl + "character", method: .get, parameters: ["page": page]).serializingDecodable(CharacterRequestResponse.self).value.results
    }
    
    func getRickMortyEpisode(url: String) async throws -> RickMortyEpisode {
        return try await AF.request(url, method: .get).serializingDecodable(RickMortyEpisode.self).value
    }
}
