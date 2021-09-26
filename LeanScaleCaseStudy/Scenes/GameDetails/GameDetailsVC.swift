//
//  GameDetailsVC.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

import UIKit
import CoreData

class GameDetailsVC : BaseVC<GameDetailsView> {
    
    private var presenter : ProGameDetailsPresetner?
    private var dataController : DataController = DataController.instance
    
    private var favoriteButton : UIBarButtonItem?
    
    private var idGame = 0
    
    init(idGame : Int) {
        super.init(nibName: nil , bundle: nil)
        self.idGame = idGame
        SharedData.instance.addNewOpenedGame(id: idGame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        presenter = GameDetailsPresenter(view : self , gameID: idGame )
        favoriteButton = UIBarButtonItem(image: nil , style: .plain , target: self , action: #selector(actionFavorite) )
        favoriteButton?.title = SString.favorite
        self.navigationItem.rightBarButtonItem = favoriteButton
        
        presenter?.getGame()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func actionFavorite () {
        if favoriteButton?.title == SString.favorite {
            guard let game = presenter?.getModelGame() else {
                return
            }
            let f = Favorite(context: dataController.viewContext)
            f.name = game.name
            f.slug = game.slug
            f.backgroundImage = game.backgroundImage
            f.gameDescription = game.gameDescription
            f.genres = game.genres?.map({$0.name}).compactMap({$0}).joined(separator: " ,")
            f.metacritic = Int16(game.metacritic ?? 0)
            f.released = game.released
            f.id = Int64(game.id ?? 0)

            do {
                try? dataController.viewContext.save()
                favoriteButton?.title = SString.favorited
            }
            catch {
                print(error.localizedDescription)
            }
        }else {
            guard let game = presenter?.getModelGame() else {
                return
            }
            let fetchRequest:NSFetchRequest<Favorite> = Favorite.fetchRequest()
            let predicate = NSPredicate(format: "id == %@", "\(game.id ?? 0)"  )
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = []
            guard let fetched = try? dataController.viewContext.fetch(fetchRequest).first else {
                return
            }
            do {
                dataController.viewContext.delete(fetched)
                favoriteButton?.title = SString.favorite
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}

extension GameDetailsVC : ProGameDetailsView {
    func fetchGame() {
        presenter?.configurationView(view: mainView)
        
        guard let game = presenter?.getModelGame() else {
            return
        }
        let fetchRequest:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", "\(game.id ?? 0)"  )
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []
        guard let fetched = try? dataController.viewContext.fetch(fetchRequest).first else {
            return
        }
  
        favoriteButton?.title = SString.favorited
        
        
    }
}


extension GameDetailsVC : NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            
            break
        case .delete:
            
            break
        default : break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
}
