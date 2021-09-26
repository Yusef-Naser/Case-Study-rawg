//
//  CellGameView.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 25/09/2021.
//

import UIKit

protocol CellGameViewConfiguration {
    func setTitla (title : String?)
    func setImage (image : String?)
    func setMetacritic (metacritic : Int?)
    func setCategory (category : String?)
    func isOpened (bool : Bool)
}

class CellGameView : UIView {
    
    private let imageViewGame : UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        return l
    }()
    
    private let labelTitle : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20 , weight: UIFont.Weight.bold)
        l.numberOfLines = 0
        return l
    }()
    
    private let labelMetacritic : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.text = SString.metacritic
        return l
    }()
    
    private let labelMetacriticValue : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20)
        l.textColor = .red
        return l
    }()
    
    private let labelCategory : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = .gray
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
        self.addSubview(imageViewGame)
        self.addSubview(labelTitle)
        self.addSubview(labelMetacritic)
        self.addSubview(labelMetacriticValue)
        self.addSubview(labelCategory)
        
        
        imageViewGame.anchor(top: self.topAnchor , leading: self.leadingAnchor , bottom: self.bottomAnchor , paddingTop: 8 , paddingLeft: 8 , paddingBottom: 8 , height: 100 )
        imageViewGame.widthAnchor.constraint(equalTo: imageViewGame.heightAnchor , multiplier: 1 ).isActive = true
        
        labelTitle.anchor(top: self.topAnchor , leading: imageViewGame.trailingAnchor , trailing: self.trailingAnchor , paddingTop: 8 , paddingLeft: 8 , paddingRight: 8 )
        
        
        labelCategory.anchor( leading: imageViewGame.trailingAnchor , bottom: self.bottomAnchor , trailing: self.trailingAnchor , paddingLeft: 8, paddingBottom: 8 , paddingRight: 8 )
        labelMetacritic.anchor( leading: imageViewGame.trailingAnchor , bottom: labelCategory.topAnchor , paddingLeft: 8 , paddingBottom: 8 , paddingRight: 8 )
        labelMetacriticValue.anchor( leading: labelMetacritic.trailingAnchor , centerY: labelMetacritic.centerYAnchor , paddingLeft: 8 )
        
        
        
    }
    
}

extension CellGameView : CellGameViewConfiguration {
    func setTitla(title: String?) {
        labelTitle.text = title
    }
    
    func setImage(image: String?) {
        imageViewGame.imageFromServerURL(urlString: image ?? "" )
    }
    
    func setMetacritic(metacritic: Int?) {
        labelMetacriticValue.text = "\(metacritic ?? 0)"
    }
    
    func setCategory(category: String?) {
        labelCategory.text = category
    }
    
    func isOpened(bool: Bool) {
        if bool {
            self.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        }else {
            self.backgroundColor = .white
        }
    }
    
    
}
