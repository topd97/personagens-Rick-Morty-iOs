//
//  ListViewModel.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import UIKit

protocol ListViewModelOutput: AnyObject {
    func charactersHasLoad()
    func characterNotLoad()
    func present(vc:UIViewController)
}

final class ListViewModel {
    private var characters: [RickMortyCharacter] = []
    private let output: ListViewModelOutput
    private var actualPage: Int = 1
    private let service: RickMortyServiceProtocol
    
    init(output: ListViewModelOutput, service: RickMortyServiceProtocol = RickMortyService.shared) {
        self.output = output
        self.service = service
    }
    
    func getCharacters() {
        Task.init {
            do {
                self.characters += try await service.getRickMortyCharacters(page: actualPage)
                self.actualPage += 1
                self.output.charactersHasLoad()
            } catch {
                self.output.characterNotLoad()
            }
        }
    }
    
    func didTapItem(row: Int) {
        guard let selectedCharacter = getCharacterFor(index: row) else { return }
        let vc = DetailsViewController(character: selectedCharacter)
        vc.modalPresentationStyle = .fullScreen
        output.present(vc: vc)
    }
    
    func getCharactersCount() -> Int {
        return characters.count
    }
    
    func getCharacterFor(index: Int) -> RickMortyCharacter? {
        return characters.get(index: index)
    }
}
