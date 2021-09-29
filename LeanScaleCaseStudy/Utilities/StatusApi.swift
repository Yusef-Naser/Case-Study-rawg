//
//  StatusApi.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//

protocol StatusApi : AnyObject {
    func showMessage (_ message : String )
    func onError(_ message : String , error : Error? , userInfo : [String : Any] )
    func onFailure (_ message : String , error : Error? , userInfo : [String : Any] )
    func showLoading ()
    func hideLoading ()
    func showProgress()
}
