//
//  Constants.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

class Constants {
    
    static var BaseURL : String {
        #if DEBUG
            return "https://api.rawg.io/api"
        #elseif RELEASE
            return "https://api.rawg.io/api"
        #endif
        
    }
    
}
