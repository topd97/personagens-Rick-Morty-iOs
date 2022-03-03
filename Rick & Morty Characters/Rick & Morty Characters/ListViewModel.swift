//
//  ListViewModel.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import Foundation

protocol ListViewModelOutput: AnyObject {
    func charactersHasLoad()
}

class ListViewModel {
    private var characters: [RickMortyCharacter] = []
    let output: ListViewModelOutput
    
    init(output: ListViewModelOutput) {
        self.output = output
    }
    
    func getCharacters() {
        Services.shared.getRickMortyCharacters() { characters in
            self.characters = characters
            self.output.charactersHasLoad()
        }
    }
    
    func getCharactersCount() -> Int {
        return characters.count
    }
    
    func getCharacterFor(index: Int) -> RickMortyCharacter? {
        return characters.get(index: index)
    }
}
