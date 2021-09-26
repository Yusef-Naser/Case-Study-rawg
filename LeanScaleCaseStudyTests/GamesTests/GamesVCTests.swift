//
//  GamesVCTests.swift
//  LeanScaleCaseStudyTests
//
//  Created by Yusef Naser on 25/09/2021.
//

import XCTest
@testable import LeanScaleCaseStudy

class GamesVCTests: XCTestCase {

    var sut : GamesVC!
    var mockPresenter : GamesPresenterMock!
  
    override func setUp() {
        super.setUp()
        sut = GamesVC()
        mockPresenter = GamesPresenterMock(view: self)
        UIApplication.shared.windows[0].rootViewController = sut
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func test_delegateAndDataSourceCollection () {
        let delegate = sut.mainView.collectionView.delegate
        let dataSource = sut.mainView.collectionView.dataSource
        
        XCTAssertTrue(delegate is GamesVC )
        XCTAssertTrue(dataSource is GamesVC )
        
    }
    
    func test_refreshControllerNotNil () {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.refreshController)
    }
    
    func test_delegateAndDatasourceCollectionView () {
        
        sut.presenter = mockPresenter
        
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 100, height: 100 )
        let collectionMock = MockCollectionView(frame: CGRect(x: 0, y: 0, width: 200 , height: 200 ), collectionViewLayout: l )
        collectionMock.delegate = self
        collectionMock.dataSource = self
        collectionMock.register(MockCellGame.self , forCellWithReuseIdentifier: MockCellGame.getIdentifier())
        
        
        let rows = collectionMock.numberOfItems(inSection: 0)
        
       
        sut.mainView.addSubview(collectionMock)
        collectionMock.reloadData()
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
        
        guard let cell = collectionMock.cellForItem(at: IndexPath(row: 0, section: 0)) as? MockCellGame else {
            XCTFail()
            return
        }
        
        XCTAssertEqual( rows , 3 )
        XCTAssertTrue(collectionMock.callDequeuedCell > 0 )
  
        
        XCTAssertTrue(cell.callSetTitle > 0 )
        XCTAssertTrue(cell.callSetImage > 0 )
        XCTAssertTrue(cell.callSetMetacric > 0 )
        XCTAssertTrue(cell.callSetCategory > 0 )
        XCTAssertTrue(cell.callSetIsOpened > 0 )
        
        
    }
    

}

extension GamesVCTests : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let c = mockPresenter.getGamesCount()
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockCellGame.getIdentifier() , for: indexPath ) as! MockCellGame
        mockPresenter.configurationGame(cell: cell , index: indexPath.row)
        return cell
    }
    
}


extension GamesVCTests : ProGamesView {
    func fetchGames() {
        
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


extension GamesVCTests {
    
    class GamesPresenterMock : GamesPresenter {
        
        var paginationGamesTest: PaginationClass<ModelGame> {
            let p = PaginationClass<ModelGame>()
            p.listData = DataTests.games
            self.paginationGames = p
            self.paginationGamesSearch = p
            return p
        }
        
        override func getGamesCount() -> Int {
            paginationGamesTest.listData.count
        }
        
        override func getGame(index: Int) -> ModelGame? {
            guard paginationGamesTest.listData.count > index else {
                return nil
            }
            return paginationGamesTest.listData[index]
        }
        
        override func configurationGame(cell: CellGameViewConfiguration, index: Int) {
            guard let game = getGame(index: index) else {
                return
            }
            cell.setTitla(title: game.name)
            cell.setCategory(category: game.genres?.map({$0.name}).compactMap({$0}).joined(separator: ", "))
            cell.setImage(image: game.backgroundImage)
            cell.setMetacritic(metacritic: game.metacritic)
            cell.isOpened(bool: SharedData.instance.gameOpened.contains(game.id ?? 0))
        }
        
    }
    
    
    class MockCellGame : UICollectionViewCell , CellGameViewConfiguration {
        
        var callSetTitle = 0
        var callSetImage = 0
        var callSetMetacric = 0
        var callSetCategory = 0
        var callSetIsOpened = 0
        
        func setTitla(title: String?) {
            callSetTitle += 1
        }
        
        func setImage(image: String?) {
            callSetImage += 1
        }
        
        func setMetacritic(metacritic: Int?) {
            callSetMetacric += 1
        }
        
        func setCategory(category: String?) {
            callSetCategory += 1
        }
        
        func isOpened(bool: Bool) {
            callSetIsOpened += 1
        }
        
        
    }
    
    class MockCollectionView : UICollectionView {
        
        var callDequeuedCell = 0
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            callDequeuedCell += 1
            return super.dequeueReusableCell(withReuseIdentifier: identifier , for: indexPath)
        }
       
    }
    
    
    
}
