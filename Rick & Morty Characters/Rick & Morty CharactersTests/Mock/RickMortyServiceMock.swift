//
//  RickMortyServiceMock.swift
//  Rick & Morty CharactersTests
//
//  Created by thiago.damasceno on 04/03/22.
//

import Foundation
@testable import Rick___Morty_Characters

enum MyError: Error {
    case connectionError
}

class RickMortyServiceMock: RickMortyServiceProtocol {
    var isSuccess: Bool = true
    
    let characters = [RickMortyCharacter(id: 1,
                                         name: "um",
                                         status: "Vivo",
                                         species: "Humano",
                                         type: "tipo",
                                         gender: "masculino",
                                         origin: RickMortyCharacterOrigin(name: "origem 1", url: "urlOrigem.com.br"),
                                         location: RickMortyCharacterLocation(name: "localização 1", url: "urlLocal.com.br"),
                                         image: "imagem1",
                                         episode: ["1", "2"],
                                         url: "urlPersonagem.com.br",
                                         created: "criação"),
                      RickMortyCharacter(id: 2,
                                         name: "dois",
                                         status: "Morto",
                                         species: "Humano",
                                         type: "tipo",
                                         gender: "masculino",
                                         origin: RickMortyCharacterOrigin(name: "origem 2", url: "urlOrigem.com.br"),
                                         location: RickMortyCharacterLocation(name: "localização 2", url: "urlLocal.com.br"),
                                         image: "imagem2",
                                         episode: ["1", "2"],
                                         url: "urlPersonagem.com.br",
                                         created: "criação")]
    
        let episode = RickMortyEpisode(id: 1, name: "ep1", air_date: "lançamento", episode: "S0E0", characters: ["1", "2"], url: "urlepisodio.com.br", created: "Criação")
    
    func getRickMortyCharacters(page: Int) async throws -> [RickMortyCharacter] {
        if isSuccess {
            return characters
        } else {
            throw MyError.connectionError
        }
    }
    
    func getRickMortyEpisode(url: String) async throws -> RickMortyEpisode {
        if isSuccess {
            return episode
        } else {
            throw MyError.connectionError
        }
    }
}
