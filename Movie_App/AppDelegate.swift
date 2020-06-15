//
//  AppDelegate.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
            
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                let frame = UIScreen.main.bounds
                window = UIWindow(frame: frame)
                let rootViewController = MoviesListViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                window?.rootViewController = navigationController
                window?.makeKeyAndVisible()
                return true
            }

    }


