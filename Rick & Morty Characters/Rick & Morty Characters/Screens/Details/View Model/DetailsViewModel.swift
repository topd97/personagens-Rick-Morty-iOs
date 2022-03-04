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
            for episode in character.episode {
                do {
                    let episode = try await service.getRickMortyEpisode(url: episode)
                    self.characterEpisodes.append(episode)
                } catch {
                    // TODO: Tratar erro da API
                    // talvez aqui não precise de tratamento, apenas esconder o quadrado caso não tenha nenhum ep
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
