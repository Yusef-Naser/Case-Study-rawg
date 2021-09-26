//
//  ApiRouter.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

import Foundation


public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

enum ApiRouter : URLRequestConvertible {
    
    case getGames(page : Int, search : String? )
    case getGame (id : Int)
    
    
    private var Methods : String {
        switch self {
        case .getGames , .getGame :
            return "GET"
        }
    }
    
    private var Headers : [String : String] {
        switch self {
        case .getGames , .getGame :
            return [
                "content-type" : "application/json;charset=utf-8",
            ]
        }
    }
    
    private var Paths : String {
        switch self {
        case .getGames(let page ,let search):
            if let s = search {
                return "/games?page_size=20&amp;page=\(page)&key=3be8af6ebf124ffe81d90f514e59856c&search=\(s)"
            }
            return "/games?page_size=20&amp;page=\(page)&key=3be8af6ebf124ffe81d90f514e59856c"
        case .getGame(let id) :
            return "/games/\(id)?key=3be8af6ebf124ffe81d90f514e59856c"
        }
    }
    
    func asURLRequest() -> URLRequest {
        let url = "\(Constants.BaseURL)\(Paths)"
        let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var urlRequest = URLRequest(url: URL(string: safeUrl!)!)
        urlRequest.allHTTPHeaderFields = Headers
        return urlRequest
    }
    
}
