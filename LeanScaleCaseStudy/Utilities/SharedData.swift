//
//  SharedData.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 25/09/2021.
//

import UIKit

class SharedData {
    
    static public var instance = SharedData ()
    public var userDefaults = UserDefaults.standard
    
    private let gameOpenedKEY = "gameOpenedKEY"
    
    var gameOpened : [Int]
    {
        get {
            if let l = userDefaults.object(forKey: gameOpenedKEY) as? [Int] {
                return l
            }else {
                return []
            }
        }
        set {
            userDefaults.set( newValue , forKey: gameOpenedKEY )
        }
    }
    
    func addNewOpenedGame (id : Int ) {
        if !gameOpened.contains(id) {
            var s = gameOpened
            s.append(id)
            gameOpened = s
        }
    }
    
}
