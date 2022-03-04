//
//  RickMortyEpisode.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

struct RickMortyEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
