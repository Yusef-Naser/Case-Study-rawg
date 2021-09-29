//
//  FavoriteVC.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//

import UIKit
import CoreData

class FavoriteVC : BaseVC<FavoriteView> {
    
    private var presenter : ProFavoritePresetner?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = FavoritePresenter(view : self )
        mainView.setDelegate(delegate: self )

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.setupFetchedResultsController()
        mainView.tableView.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.setNULLFetchResultController()
    }
    
}

extension FavoriteVC : ProFavoriteView {
    func setDelegateResultController() -> FavoriteVC? {
        return self
    }
  
}

extension FavoriteVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.returnFetchResultController()?.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.returnFetchResultController()?.sections?[0].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellGameTable.getIdentifier() , for: indexPath ) as! CellGameTable
        presenter?.configurationGame(cell: cell , index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(GameDetailsVC(idGame: presenter?.getGameID(index: indexPath.row ) ?? 0), animated: true )
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            createAlert(title: nil , message: SString.areYouSureYouWantToDeleteThisGame) { [weak self] in
                self?.presenter?.deleteGame(index: indexPath.row)
            } present: { vc in
                self.present(vc , animated: true )
            }

            
        default: () // Unsupported
        }
    }
    
}

extension FavoriteVC :NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            mainView.tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            mainView.tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            mainView.tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            mainView.tableView.moveRow(at: indexPath!, to: newIndexPath!)
         default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: mainView.tableView.insertSections(indexSet, with: .fade)
        case .delete: mainView.tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        default:
            break
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.endUpdates()
    }
    
}
