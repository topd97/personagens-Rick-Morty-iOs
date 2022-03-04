//
//  CharacterRequestResponse.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

import Foundation

struct CharacterRequestResponse: Codable {
    let info: CharacterResultInfo
    let results: [RickMortyCharacter]
}
