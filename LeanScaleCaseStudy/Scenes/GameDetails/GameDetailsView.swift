//
//  GameDetailsView.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//VC

import UIKit

protocol GameDetailsViewConfiguration {
    func setImage (image : String?)
    func setTitle (title : String?)
    func setDescription(desc : String?)
    
}

class GameDetailsView : UIView {
    
    private lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.addSubview(parentView)
        parentView.anchor(top: s.topAnchor , leading: s.leadingAnchor , bottom: s.bottomAnchor , trailing: s.trailingAnchor )
        parentView.widthAnchor.constraint(equalTo: s.widthAnchor , multiplier: 1).isActive = true
        return s
    }()
    
    private let parentView = UIView ()
    
    private let imageView : ImageViewMask = {
        let l = ImageViewMask()
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        return l
    }()
    
    private let labelTitle : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 25)
        l.numberOfLines = 0
        return l
    }()
    
    private let labelGameDescription : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20)
        l.text = SString.gamesDescription
        return l
    }()
    
    private let labelDescriptionValue : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.numberOfLines = 4
        return l
    }()
    
    private let buttonSeeMore : UIButton = {
        let l = UIButton()
        l.setTitle(SString.seeMore, for: .normal)
        l.setTitleColor(.blue , for: .normal)
        return l
    }()
    
    private let viewLine_1 : UIView = {
        let l = UIView()
        l.backgroundColor = .gray
        return l
    }()
    
    private let buttonVisitReddit : UIButton = {
        let l = UIButton()
        l.setTitle(SString.visitReddit , for: .normal)
        l.setTitleColor(.black , for: .normal)
        return l
    }()
    
    private let viewLine_2 : UIView = {
        let l = UIView()
        l.backgroundColor = .gray
        return l
    }()
    
    private let buttonVisitWebsite : UIButton = {
        let l = UIButton()
        l.setTitle(SString.visitwebsite , for: .normal)
        l.setTitleColor(.black , for: .normal)
        return l
    }()
    
    private let viewLine_3 : UIView = {
        let l = UIView()
        l.backgroundColor = .gray
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
        buttonSeeMore.addTarget(self , action: #selector(actionSeeMore), for: .touchUpInside)
        buttonVisitReddit.addTarget(self , action: #selector(actionOpenReddit), for: .touchUpInside)
        buttonVisitWebsite.addTarget(self , action: #selector(actionOpenWebsite), for: .touchUpInside)
    }
    
    private func addViews () {
        
        addSubview(scrollView)
        parentView.addSubview(imageView)
        parentView.addSubview(labelTitle)
        parentView.addSubview(labelGameDescription)
        parentView.addSubview(labelDescriptionValue)
        parentView.addSubview(buttonSeeMore)
        parentView.addSubview(viewLine_1)
        parentView.addSubview(buttonVisitReddit)
        parentView.addSubview(viewLine_2)
        parentView.addSubview(buttonVisitWebsite)
        parentView.addSubview(viewLine_3)
        
        scrollView.anchor(top: topAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor )
        imageView.anchor(top: parentView.topAnchor , leading: parentView.leadingAnchor , trailing: parentView.trailingAnchor , height: 200 )
        labelTitle.anchor( leading: imageView.leadingAnchor , bottom: imageView.bottomAnchor , trailing: imageView.trailingAnchor , paddingLeft: 8  , paddingBottom: 8 )
        
        labelGameDescription.anchor(top: imageView.bottomAnchor , leading: parentView.leadingAnchor , paddingTop: 8, paddingLeft: 8 )
        labelDescriptionValue.anchor(top: labelGameDescription.bottomAnchor , leading: parentView.leadingAnchor , trailing: parentView.trailingAnchor , paddingTop: 8, paddingLeft: 8 , paddingRight: 8 )
        buttonSeeMore.anchor(top: labelDescriptionValue.bottomAnchor, trailing: parentView.trailingAnchor , paddingTop: 8 , paddingRight: 8 )
        viewLine_1.anchor(top: buttonSeeMore.bottomAnchor , leading: parentView.leadingAnchor , trailing: parentView.trailingAnchor , paddingTop: 8 , height: 1 )
        buttonVisitReddit.anchor(top: viewLine_1.bottomAnchor , leading: parentView.leadingAnchor  , paddingTop: 8, paddingLeft: 8 , paddingRight: 8 , height: 50 )
        
        viewLine_2.anchor(top: buttonVisitReddit.bottomAnchor , leading: parentView.leadingAnchor , trailing: parentView.trailingAnchor , paddingTop: 8 , height: 1 )
        buttonVisitWebsite.anchor(top: viewLine_2.bottomAnchor , leading: parentView.leadingAnchor , paddingTop: 8, paddingLeft: 8 , paddingRight: 8 , height: 50 )
        
        viewLine_3.anchor(top: buttonVisitWebsite.bottomAnchor , leading: parentView.leadingAnchor , trailing: parentView.trailingAnchor , paddingTop: 8 , height: 1 )
        
        viewLine_3.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -16).isActive = true
        
    }
    
    
    @objc private func actionSeeMore () {
        if labelDescriptionValue.numberOfLines == 4 {
            labelDescriptionValue.numberOfLines = 0
            buttonSeeMore.setTitle(SString.seeLess , for: .normal)
        }else if labelDescriptionValue.numberOfLines == 0 {
            labelDescriptionValue.numberOfLines = 4
            buttonSeeMore.setTitle(SString.seeMore , for: .normal)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
    }
    
    
    @objc private func actionOpenReddit () {
        if let url = URL(string: "https://www.leanscale.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func actionOpenWebsite () {
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url)
        }
    }
    
}


extension GameDetailsView : GameDetailsViewConfiguration {
    func setImage(image: String?) {
        imageView.imageFromServerURL(urlString: image ?? "" )
    }
    func setTitle(title: String?) {
        labelTitle.text = title
    }
    func setDescription(desc: String?) {
        labelDescriptionValue.text = desc
    }
}
