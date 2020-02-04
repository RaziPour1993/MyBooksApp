//
//  AppDelegate.swift
//  Digipay
//
//  Created by Mohammad Razipour on 12/24/19.
//  Copyright © 2019 Mohammad Razipour. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var applicationCoordinator: Coordinator!
    private var coordinatorFactory: CoordinatorFactory!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        config()
        start()
        return true
    }
    
    func config() {
        
    }
    
    private func start(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let screenFactory = MainScreenFactoryIMP()
        let router = MainRouterIMP(window: self.window)
        self.coordinatorFactory = MainCoordinatorFactorIMP(screenFactory: screenFactory, router: router)
        
        applicationCoordinator = coordinatorFactory.makeMainCoordinator()
        applicationCoordinator.start()
    }
    
}

