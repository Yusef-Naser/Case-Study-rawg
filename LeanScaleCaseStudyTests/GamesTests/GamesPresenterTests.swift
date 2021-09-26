//
//  GamesPresenterTests.swift
//  LeanScaleCaseStudyTests
//
//  Created by Yusef Naser on 25/09/2021.
//

import XCTest
@testable import LeanScaleCaseStudy

class GamesPresenterTests : XCTestCase {
    
    var sut : GamesPresenter!
    var totalCountGames = 0
    var mockInteractor : GameInteractorMock!
    
    override func setUp() {
        super.setUp()
        sut = GamesPresenter(view: self )
        mockInteractor = GameInteractorMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getGamesWithNoSearch () {
        sut.interactor = mockInteractor
        sut.getGames()
        
        XCTAssertEqual(sut.paginationGames.listData.count , 2)
        XCTAssertEqual(sut.paginationGames.totalCount , 10)
        XCTAssertEqual(sut.getGamesCount() , 2)
        XCTAssertEqual(sut.getGame(index: 0), DataTests.games[0])
        XCTAssertEqual(totalCountGames , 2)
        totalCountGames = 0
    }
    
    func test_getGamesWithSearch () {
        sut.interactor = mockInteractor
        sut.getGameSearch(search: "search")
        
        XCTAssertEqual(sut.paginationGamesSearch.listData.count , 1)
        XCTAssertEqual(sut.paginationGamesSearch.totalCount , 20)
        XCTAssertEqual(sut.getGamesCount() , 1)
        XCTAssertEqual(sut.getGame(index: 0), DataTests.games[2])
        
        XCTAssertEqual(totalCountGames , 1)
        totalCountGames = 0
        
    }
    
    func test_configurationGames () {
        sut.interactor = mockInteractor
        sut.getGames()
        
        let c = ConfigurationGameCellMock()
        let gameData = DataTests.games[0]
        sut.configurationGame(cell: c  , index: 0 )
        
        XCTAssertEqual(c.title , gameData.name)
        XCTAssertEqual(c.titleCount , 1)
        
        XCTAssertEqual(c.category , gameData.genres?.map({$0.name}).compactMap({$0}).joined(separator: ", "))
        XCTAssertEqual(c.categoryCount , 1)
        
        XCTAssertEqual(c.image , gameData.backgroundImage)
        XCTAssertEqual(c.imageCount , 1)
        
        XCTAssertEqual(c.metacriticCount , 1)
        XCTAssertEqual(c.metacritic , gameData.metacritic)
    }
    
}

extension GamesPresenterTests : ProGamesView {
    func showMessage(_ message: String) {
        
    }
    
    func onError(_ message: String, error: Error?, userInfo: [String : Any]) {
        
    }
    
    func onFailure(_ message: String, error: Error?, userInfo: [String : Any]) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showProgress() {
        
    }
    
    func fetchGames () {
        totalCountGames = sut.getGamesCount()
    }
}

extension GamesPresenterTests {
    
    class GameInteractorMock : GamesInteractor {
        override func getGames(page: Int, search: String?, completion: @escaping CompletionHandler<ModelGames>) {
            if search == nil {
                let data = [DataTests.games[0] , DataTests.games[1]]
                let games = ModelGames(count: 10, next: "", previous: "", results: data )
                completion(games , nil , 200, 2 )
            }else {
                let data = [DataTests.games[2] ]
                let games = ModelGames(count: 20, next: "", previous: "", results: data )
                completion(games , nil , 200, 2 )
            }
            
        }
    }
    
    class ConfigurationGameCellMock : CellGameViewConfiguration {
        var titleCount = 0
        var title : String? = ""
        
        var imageCount = 0
        var image : String? = ""
        
        var metacriticCount = 0
        var metacritic : Int? = 0
        
        var categoryCount = 0
        var category : String? = ""
        
        func setTitla(title: String?) {
            titleCount += 1
            self.title = title
        }
        
        func setImage(image: String?) {
            imageCount += 1
            self.image = image
        }
        
        func setMetacritic(metacritic: Int?) {
            metacriticCount += 1
            self.metacritic = metacritic
        }
        
        func setCategory(category: String?) {
            categoryCount += 1
            self.category = category
        }
        
        func isOpened(bool: Bool) {
            
        }
        
        
    }
    
}
