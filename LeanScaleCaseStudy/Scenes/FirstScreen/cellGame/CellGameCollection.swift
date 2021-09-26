//
//  CellGameCollection.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 25/09/2021.
//

import UIKit

class CellGameCollection : UICollectionViewCell {
    
    private let cellView : CellGameView = {
        let l = CellGameView()
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
        contentView.addSubview(cellView)
        cellView.anchor(top: contentView.topAnchor  , leading: contentView.leadingAnchor , bottom: contentView.bottomAnchor , trailing: contentView.trailingAnchor )
    }
}

extension CellGameCollection : CellGameViewConfiguration {
    func setTitla(title: String?) {
        cellView.setTitla(title: title)
    }
    
    func setImage(image: String?) {
        cellView.setImage(image: image)
    }
    
    func setMetacritic(metacritic: Int?) {
        cellView.setMetacritic(metacritic: metacritic)
    }
    
    func setCategory(category: String?) {
        cellView.setCategory(category: category)
    }
    
    func isOpened(bool: Bool) {
        cellView.isOpened(bool: bool)
    }
    
    
    
    
}
