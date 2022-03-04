//
//  ListViewModelTests.swift
//  Rick & Morty CharactersTests
//
//  Created by thiago.damasceno on 04/03/22.
//

import XCTest
@testable import Rick___Morty_Characters


final class ListViewModelTests: XCTestCase {
    var viewModel: ListViewModel?
    var mock = RickMortyServiceMock()
    var getCharacterSuccess = false
    var presentCalled = false
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        viewModel = ListViewModel(output: self, service: mock)
    }
    
    func testGetCharacterSuccess() {
        mock.isSuccess = true
        getCharacterSuccess = false
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(getCharacterSuccess)
    }
    
    func testGetCharacterFail() {
        mock.isSuccess = false
        getCharacterSuccess = true
        expectation = self.expectation(description: "Test get character load fail")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(getCharacterSuccess)
    }
    
    func testGetCharacterCount() {
        mock.isSuccess = true
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        let numberOfItens = viewModel?.getCharactersCount()
        
        XCTAssertEqual(numberOfItens, 2)
    }
    
    func testGetCharacterForValidNumber() {
        mock.isSuccess = true
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        let character = viewModel?.getCharacterFor(index: 1)
        
        XCTAssertEqual(character?.id, mock.characters.get(index: 1)?.id)
    }
    
    func testGetCharacterForNotValidNumber() {
        mock.isSuccess = true
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        let character = viewModel?.getCharacterFor(index: -1)
        
        XCTAssertNil(character)
    }
    
    func testDidTapItemForValidRow() {
        mock.isSuccess = true
        presentCalled = false
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        viewModel?.didTapItem(row: 1)
        
        XCTAssertTrue(presentCalled)
    }
    
    func testDidTapItemForNotValidRow() {
        mock.isSuccess = true
        presentCalled = false
        
        expectation = self.expectation(description: "Test get character load success")
        viewModel?.getCharacters()
        waitForExpectations(timeout: 5, handler: nil)
        
        viewModel?.didTapItem(row: -1)
        
        XCTAssertFalse(presentCalled)
    }
}

extension ListViewModelTests: ListViewModelOutput {
    
    func charactersHasLoad() {
        getCharacterSuccess = true
        expectation.fulfill()
    }

    func characterNotLoad() {
        getCharacterSuccess = false
        expectation.fulfill()
    }

    func present(vc: UIViewController) {
        presentCalled = true
    }
}
