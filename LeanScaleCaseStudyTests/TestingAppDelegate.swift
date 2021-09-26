//
//  TestingAppDelegate.swift
//  LeanScaleCaseStudyTests
//
//  Created by Yusef Naser on 25/09/2021.
//

import Foundation
import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate : UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print(">> Launching with Test app delegate")
        
        return true
    }
    
}
