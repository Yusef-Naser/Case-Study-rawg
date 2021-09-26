//
//  GameDetailsPresenter.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//VC


protocol ProGameDetailsView : StatusApi {
    func fetchGame ()
}

protocol ProGameDetailsPresetner {

    func getGame ()
    func configurationView (view : GameDetailsViewConfiguration )
    func getModelGame () -> ModelGame?
}


class GameDetailsPresenter : ProGameDetailsPresetner {
    
    weak var view : ProGameDetailsView?
    var interactor = GameDetailsInteractor()
    
    private var gameID = 0
    private var modelGame : ModelGame? = nil
    
    init(view : ProGameDetailsView , gameID : Int ) {
        self.view = view
        self.gameID = gameID
    }
    
    func getGame() {
        self.view?.showLoading()
        interactor.getGame(id: gameID) { data , error , statusCode , _ in
            self.view?.hideLoading()
            guard let game = data else {
                return
            }
            self.modelGame = game
            self.view?.fetchGame()
        }
    }
    
    func configurationView(view: GameDetailsViewConfiguration) {
        guard let game = modelGame else {
            return
        }
        view.setTitle(title: game.name)
        view.setImage(image: game.backgroundImage)
        view.setDescription(desc: game.gameDescription?.html2String)
    }
    
    func getModelGame() -> ModelGame? {
        modelGame
    }
    
}
