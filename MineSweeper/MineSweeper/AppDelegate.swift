//
//  AppDelegate.swift
//  MineSweeper
//
//  Created by Mimosa on 2021/8/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MSHomeVieController()
        vc.view.backgroundColor = .white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

