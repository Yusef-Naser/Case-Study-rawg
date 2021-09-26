//
//  GamesView.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 23/09/2021.
//VC

import UIKit


class GamesView : UIView {
    
    let searchBar : UISearchBar = {
        let l = UISearchBar()
        l.showsCancelButton = true 
        return l
    }()
    
    let collectionView : UICollectionView = {
        let layout = ResizingFlowLayout(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8 ))
        if UIDevice.current.model.contains("iPhone") {
            layout.cellsPerRow = 1
        }else if UIDevice.current.model.contains("iPad") {
            layout.cellsPerRow = 2
        }
        layout.height = 150 
        let l = UICollectionView(frame: .zero , collectionViewLayout: layout)
        l.register(CellGameCollection.self , forCellWithReuseIdentifier: CellGameCollection.getIdentifier())
        l.backgroundColor = .white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        addSubview(searchBar)
        addSubview(collectionView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor , constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -8).isActive = true
        
    }
    
    func setDelegate (delegate : GamesVC?) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        searchBar.delegate = delegate
    }
    
    func reloadTable () {
        collectionView.reloadData()
    }
    
}
