//
//  Loading.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 26/09/2021.
//

import UIKit

class Loading {
    
    static let instance = Loading()
    
    private var progress = LoadingView()
    
    private init(){
        
    }
    
    func showLoading(view : UIView) {
        view.addSubview(progress)
        progress.anchor(top: view.topAnchor , leading: view.leadingAnchor , bottom: view.bottomAnchor , trailing: view.trailingAnchor )
        progress.startAnimating()
    }
    
    func hideLoading () {
        progress.removeFromSuperview()
        progress.stopAnimating()
    }
    
    
    
}

class LoadingView : UIView {
    
    private let indicator : UIActivityIndicatorView = {
        let l = UIActivityIndicatorView()
        l.color = .gray
        l.style = .whiteLarge
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
        addSubview(indicator)
        indicator.anchor(centerX : self.centerXAnchor , centerY: self.centerYAnchor)
    }
    
    func startAnimating () {
        indicator.startAnimating()
    }
    
    func stopAnimating () {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
    
}
