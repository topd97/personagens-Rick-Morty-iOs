//
//  DetailsViewModel.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

protocol DetailsViewModelProtocol: AnyObject {
    func didLoadData()
    func didFailToLoadEpisodes()
}

class DetailsViewModel {
    private var character: RickMortyCharacter?
    private var characterEpisodes: [RickMortyEpisode] = []
    private var output: DetailsViewModelProtocol?
    private let service: RickMortyServiceProtocol
    
    init(character: RickMortyCharacter? = nil, service: RickMortyServiceProtocol = RickMortyService()) {
        self.character = character
        self.service = service
    }
    
    func setup(output: DetailsViewModelProtocol) {
        self.output = output
    }
    
    func loadData() {
        getEpisode()
    }
    
    private func getEpisode() {
        guard let character = character else { return }
        Task.init {
            var didFailSomeEpisodes = false
            for episode in character.episode {
                do {
                    let episode = try await service.getRickMortyEpisode(url: episode)
                    self.characterEpisodes.append(episode)
                } catch {
                    didFailSomeEpisodes = true
                }
            }
            output?.didLoadData()
            if didFailSomeEpisodes {
                output?.didFailToLoadEpisodes()
            }
        }
    }
    
    func getCharacter() -> RickMortyCharacter? {
        return character
    }
    
    func getCharacterEpisodes() -> [RickMortyEpisode] {
        return characterEpisodes
    }
}
