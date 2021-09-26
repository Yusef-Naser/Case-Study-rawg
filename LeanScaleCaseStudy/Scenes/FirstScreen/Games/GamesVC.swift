//
//  GamesVC.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 23/09/2021.
//

import UIKit

class GamesVC : BaseVC<GamesView> {
    
    var presenter : ProGamesPresetner?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = GamesPresenter(view : self )
        mainView.setDelegate(delegate: self )
        presenter?.getGames()
        refreshController = mainView.collectionView.addRefreshController()
        refreshController?.addTarget(self , action: #selector(actionRefresh), for: .valueChanged )
    }
    
    @objc private func actionRefresh () {
        presenter?.refreshGames()
    }
    
}

extension GamesVC : ProGamesView {
    func fetchGames() {
        mainView.reloadTable()
    }
}

extension GamesVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.callPaginationGames(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getGamesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellGameCollection.getIdentifier() , for: indexPath ) as! CellGameCollection
        presenter?.configurationGame(cell: cell , index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CellGameCollection else {
            return
        }
        cell.isOpened(bool: true)
        navigationController?.pushViewController(GameDetailsVC(idGame: presenter?.getGame(index: indexPath.row)?.id ?? 0 ), animated: true )
    }
    
}


extension GamesVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            Debouncer.instance.call().callback = { [weak self] in
                self?.presenter?.getGameSearch(search: searchText.lowercased())
            }
            return
        }else if searchText.count == 0 {
            self.presenter?.getGames()
            mainView.endEditing(true )
        }
    }
    
    func searchBarCancelButtonClicked (_ searchBar: UISearchBar ) {
        searchBar.text = ""
        mainView.endEditing(true )
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.endEditing(true)
    }
    
}
