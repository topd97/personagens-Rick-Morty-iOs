//
//  CharacterResultInfo.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//
struct CharacterResultInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
