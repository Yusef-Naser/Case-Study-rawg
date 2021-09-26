//
//  BaseVC.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//

import UIKit

class BaseVC <T : UIView > : UIViewController , StatusApi {
    
    
    func showMessage(_ message: String) {
        
    }
    
    func onError(_ message: String, error: Error?, userInfo: [String : Any]) {
        
    }
    
    func onFailure(_ message: String, error: Error?, userInfo: [String : Any]) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        refreshController?.endRefreshing()
    }
    
    func showProgress() {
        
    }
    
    
    var refreshController : UIRefreshControl?
    
    override func loadView() {
        let t  = T()
        t.backgroundColor = .white
        self.view = t
    }
    
    var mainView : T {
        if let view = self.view as? T {
            return view
        }else {
         let view = T()
         self.view = view
         return view
        }
    }
    
}
