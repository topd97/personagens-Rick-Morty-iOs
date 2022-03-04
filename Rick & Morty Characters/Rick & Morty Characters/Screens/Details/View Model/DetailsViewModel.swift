//
//  DetailsViewModel.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

protocol DetailsViewModelProtocol: AnyObject {
    func didLoadData()
}

class DetailsViewModel {
    private var character: RickMortyCharacter?
    private var characterEpisodes: [RickMortyEpisode] = []
    private var output: DetailsViewModelProtocol?
    
    init(character: RickMortyCharacter? = nil) {
        self.character = character
    }
    
    func setup(output: DetailsViewModelProtocol) {
        self.output = output
    }
    
    func loadData() {
        getEpisode()
    }
    
    func getEpisode() {
        guard let character = character else { return }
        Task.init {
            for episode in character.episode {
                do {
                    let episode = try await RickMortyService.shared.getRickMortyEpisode(url: episode)
                    self.characterEpisodes.append(episode)
                } catch {
                    // TODO: Tratar erro da API
                    print("erro")
                }
            }
            output?.didLoadData()
        }
    }
    
    func getCharacter() -> RickMortyCharacter? {
        return character
    }
    
    func getCharacterEpisodes() -> [RickMortyEpisode] {
        return characterEpisodes
    }
}
