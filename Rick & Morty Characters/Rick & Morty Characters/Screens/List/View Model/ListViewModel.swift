//
//  ListViewModel.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

protocol ListViewModelOutput: AnyObject {
    func charactersHasLoad()
}

final class ListViewModel {
    private var characters: [RickMortyCharacter] = []
    private let output: ListViewModelOutput
    private var actualPage: Int = 1
    private var isUpdating = false
    
    init(output: ListViewModelOutput) {
        self.output = output
    }
    
    func getCharacters() {
        if !isUpdating {
            isUpdating = true
            Task.init {
                self.characters += try await RickMortyService.shared.getRickMortyCharacters(page: actualPage)
                self.actualPage += 1
                self.output.charactersHasLoad()
                self.isUpdating = false
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
