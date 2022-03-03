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
    var actualPage: Int = 1
    var isUpdating = false
    
    init(output: ListViewModelOutput) {
        self.output = output
    }
    
    func getCharacters() {
        if !isUpdating {
            isUpdating = true
            Services.shared.getRickMortyCharacters(page: actualPage) { characters in
                self.isUpdating = false
                self.actualPage += 1
                self.characters = characters
                self.output.charactersHasLoad()
            }
        }
    }
    
    func getCharactersCount() -> Int {
        return characters.count
    }
    
    func getCharacterFor(index: Int) -> RickMortyCharacter? {
        return characters.get(index: index)
    }
}
