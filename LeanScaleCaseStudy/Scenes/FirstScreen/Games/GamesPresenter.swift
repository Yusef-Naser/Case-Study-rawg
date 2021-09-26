//
//  GamesPresenter.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 23/09/2021.
//VC


protocol ProGamesView : StatusApi {
    func fetchGames ()
}

protocol ProGamesPresetner {

    func getGames()
    func getGamesCount () -> Int
    func getGame(index : Int ) -> ModelGame?
    func configurationGame ( cell : CellGameViewConfiguration , index : Int )
    func callPaginationGames (index : Int)
    func refreshGames()
    func getGameSearch (search : String)
}


class GamesPresenter : ProGamesPresetner {
    
    weak var view : ProGamesView?
    var interactor = GamesInteractor()
    
    var paginationGames = PaginationClass<ModelGame>()
    
    var paginationGamesSearch = PaginationClass<ModelGame>()
    
    
    private var searchText = ""
    
    init(view : ProGamesView ) {
        self.view = view
    }
    
    
    func getGames() {
        searchText = ""
        if  !( paginationGames.beforeCallService() ) {
            self.view?.hideLoading()
            return
        }
        if paginationGames.refreshValue {
            paginationGames.refreshValue = false
        }else {
            self.view?.showLoading()
        }
        
        interactor.getGames(page: paginationGames.currentPage , search: nil) { data , errors , statusCode , currentPage in
            
            self.view?.hideLoading()
            
            guard let games = data?.results else {
                return
            }
            self.paginationGames.setDataPagination(listData: games , currentPage: currentPage ?? 0 , totalCount: data?.count ?? 0)
            self.view?.fetchGames()
            
        }
    }
    
    func getGameSearch(search : String) {
        if search != searchText {
            paginationGamesSearch.resetData()
        }
        searchText = search
        if  !( paginationGamesSearch.beforeCallService() ) {
            self.view?.hideLoading()
            return
        }
        if paginationGamesSearch.refreshValue {
            paginationGamesSearch.refreshValue = false
        }else {
            self.view?.showLoading()
        }
        
        interactor.getGames(page: paginationGamesSearch.currentPage , search: search ) { data , errors , statusCode , currentPage in
            
            self.view?.hideLoading()
            
            guard let games = data?.results else {
                return
            }
            self.paginationGamesSearch.setDataPagination(listData: games , currentPage: currentPage ?? 0 , totalCount: (data?.count ?? 0) )
            self.view?.fetchGames()
            
        }
    }
    
    func getGamesCount () -> Int {
        if !searchText.isEmpty {
            return paginationGamesSearch.listData.count
        }
        return paginationGames.listData.count
    }
    func getGame(index : Int ) -> ModelGame? {
        
        if !searchText.isEmpty {
            guard paginationGamesSearch.listData.count > index else {
                return nil
            }
            return paginationGamesSearch.listData[index]
        }
        
        guard paginationGames.listData.count > index else {
            return nil
        }
        return paginationGames.listData[index]
    }
    func configurationGame ( cell : CellGameViewConfiguration , index : Int ) {
        guard let game = getGame(index: index) else {
            return
        }
        cell.setTitla(title: game.name)
        cell.setCategory(category: game.genres?.map({$0.name}).compactMap({$0}).joined(separator: ", "))
        cell.setImage(image: game.backgroundImage)
        cell.setMetacritic(metacritic: game.metacritic)
        cell.isOpened(bool: SharedData.instance.gameOpened.contains(game.id ?? 0))
    }
    func callPaginationGames (index : Int) {
        if !searchText.isEmpty {
            if paginationGamesSearch.allowPagination(index: index) {
                getGameSearch(search: searchText)
            }
        }else {
            if paginationGames.allowPagination(index: index) {
                getGames()
            }
        }
        
    }
    
    func refreshGames() {
        if !searchText.isEmpty {
            paginationGamesSearch.refreshValue = true
            paginationGamesSearch.resetData()
            getGameSearch(search: searchText)
            return
        }
        paginationGames.refreshValue = true
        paginationGames.resetData()
        getGames()
    }
    
}
