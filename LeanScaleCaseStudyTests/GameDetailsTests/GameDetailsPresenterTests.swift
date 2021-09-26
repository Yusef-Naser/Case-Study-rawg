//
//  GameDetailsVCTests.swift
//  LeanScaleCaseStudyTests
//
//  Created by Yusef Naser on 26/09/2021.
//

import XCTest
@testable import LeanScaleCaseStudy

class GameDetailsPresenterTests : XCTestCase {

    var sut : GameDetailsPresenter!
    var mockInteractor : MockInteractor!
    var fetchGameCount = 0
    
    override func setUp() {
        super.setUp()
        sut = GameDetailsPresenter(view: self , gameID: 1 )
        mockInteractor = MockInteractor()
    }
    
    override func tearDown() {
        sut = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func test_GetGame () {
        sut.interactor = mockInteractor
        sut.getGame()
        XCTAssertEqual(sut.getModelGame() , DataTests.games[0])
        XCTAssertEqual(fetchGameCount , 1)
    }
    
    func test_configurationView () {
        sut.interactor = mockInteractor
        sut.getGame()
        let view = MockView()
        sut.configurationView(view: view)
        
        XCTAssertEqual(view.setTitleCount , 1)
        XCTAssertEqual(view.setImageCount , 1)
        XCTAssertEqual(view.setDescriptionCount , 1)
        
        XCTAssertEqual(view.setTitle , DataTests.games[0].name)
        XCTAssertEqual(view.setImage , DataTests.games[0].backgroundImage)
        XCTAssertEqual(view.setDescription , DataTests.games[0].gameDescription)

    }

}

extension GameDetailsPresenterTests {
    
    class MockInteractor : GameDetailsInteractor {
        override func getGame(id: Int, completion: @escaping CompletionHandler<ModelGame>) {
            let data = DataTests.games[0]
            completion(data ,nil , 200 , nil )
        }
    }
    
    class MockView : GameDetailsViewConfiguration {
        var setImageCount = 0
        var setTitleCount = 0
        var setDescriptionCount = 0
        
        var setImage : String? = nil
        var setTitle: String? = nil
        var setDescription: String? = nil
        
        func setImage(image: String?) {
            setImageCount += 1
            self.setImage = image
        }
        
        func setTitle(title: String?) {
            setTitleCount += 1
            self.setTitle = title
        }
        
        func setDescription(desc: String?) {
            setDescriptionCount += 1
            self.setDescription = desc
        }
        
    }
    
}

extension GameDetailsPresenterTests : ProGameDetailsView {
    
    func fetchGame() {
        fetchGameCount += 1
    }
    
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
    
}
