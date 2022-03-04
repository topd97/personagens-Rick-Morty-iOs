//
//  DetailsViewModelTests.swift
//  Rick & Morty CharactersTests
//
//  Created by thiago.damasceno on 04/03/22.
//

import XCTest
@testable import Rick___Morty_Characters

final class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailsViewModel?
    var mock = RickMortyServiceMock()
    var loadDataSuccess = false
    var expectation: XCTestExpectation!
    let character = RickMortyServiceMock().characters.first

    override func setUp() {
        super.setUp()
        viewModel = DetailsViewModel(character: character, service: mock)
        viewModel?.setup(output: self)
    }
    
    func testLoadDataSuccess() {
        mock.isSuccess = true
        loadDataSuccess = false
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.loadData()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(loadDataSuccess)
    }
    
    func testGetCharacter() {
        mock.isSuccess = true
        
        let returnedCharacter = viewModel?.getCharacter()
        
        XCTAssertEqual(returnedCharacter?.id ?? -1, self.character?.id)
    }
    
    func testGetEpisode() {
        mock.isSuccess = true
        loadDataSuccess = false
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.loadData()
        waitForExpectations(timeout: 5, handler: nil)
        let episodes = viewModel?.getCharacterEpisodes()
        
        
        XCTAssertEqual(episodes?.count, self.character?.episode.count)
        for episode in episodes ?? [] {
            XCTAssertEqual(episode.id, mock.episode.id)
        }
        
    }
    
    
}

extension DetailsViewModelTests: DetailsViewModelProtocol {
    func didLoadData() {
        loadDataSuccess = true
        expectation.fulfill()
    }
}

