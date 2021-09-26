//
//  FavoritePresenter.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//VC

import CoreData

protocol ProFavoriteView : StatusApi {
    func setDelegateResultController () -> FavoriteVC?
}

protocol ProFavoritePresetner {

    func setupFetchedResultsController()
    func setNULLFetchResultController ()
    func returnFetchResultController () -> NSFetchedResultsController<Favorite>?
    func configurationGame ( cell : CellGameViewConfiguration , index : Int )
    func deleteGame (index : Int)
    func getGameID (index : Int) -> Int?
}


class FavoritePresenter : ProFavoritePresetner {
    
    weak var view : ProFavoriteView?  
    var fetchedResultsController:NSFetchedResultsController<Favorite>?
    var dataController : DataController = DataController.instance
    
    init(view : ProFavoriteView  ) {
        self.view = view
    }
    
    func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "favorite")
        fetchedResultsController?.delegate = self.view?.setDelegateResultController()

        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func setNULLFetchResultController() {
        fetchedResultsController = nil
    }
    
    func returnFetchResultController() -> NSFetchedResultsController<Favorite>? {
        fetchedResultsController
    }
    
    func configurationGame ( cell : CellGameViewConfiguration , index : Int ) {
        guard let game = fetchedResultsController?.object(at: IndexPath(row: index , section: 0)) else {
            return
        }
        cell.setTitla(title: game.name)
        cell.setCategory(category: game.genres)
        cell.setImage(image: game.backgroundImage)
        cell.setMetacritic(metacritic: Int(game.metacritic))
    }
    
    func deleteGame(index: Int) {
        guard let game = fetchedResultsController?.object(at: IndexPath(row: index , section: 0)) else {
            return
        }
        dataController.viewContext.delete(game)
        try? dataController.viewContext.save()
    }
    
    func getGameID(index: Int) -> Int? {
        guard let game = fetchedResultsController?.object(at: IndexPath(row: index , section: 0)) else {
            return nil
        }
        return Int(game.id)
    }
    
}
