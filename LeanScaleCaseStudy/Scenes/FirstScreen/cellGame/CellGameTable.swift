//
//  CellGame.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 23/09/2021.
//

import UIKit


class CellGameTable : UITableViewCell {
    
    private let cellView : CellGameView = {
        let l = CellGameView()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
        self.selectionStyle = .none
    }
    
    private func addViews () {
        contentView.addSubview(cellView)
       
        cellView.anchor(top: contentView.topAnchor , leading: contentView.leadingAnchor , bottom: contentView.bottomAnchor , trailing: contentView.trailingAnchor , paddingTop: 8, paddingLeft: 8, paddingBottom: 8 , paddingRight: 8 )

        
    }
    
}

extension CellGameTable : CellGameViewConfiguration {
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
