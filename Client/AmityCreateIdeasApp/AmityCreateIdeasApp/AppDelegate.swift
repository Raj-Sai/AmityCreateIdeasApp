//
//  AppDelegate.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13, *) {
            
        } else {
            self.window = UIWindow()
            let storyboard = UIStoryboard(name: "IdeasViewController", bundle: nil)
            if let ideasViewController = storyboard.instantiateViewController(withIdentifier: "IdeasViewController") as? IdeasViewController {
                self.window?.rootViewController = ideasViewController
                self.window?.makeKeyAndVisible()
            }
        }

        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

