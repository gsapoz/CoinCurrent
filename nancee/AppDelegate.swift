//
//  AppDelegate.swift
//  nancee
//
//  Created by Gary Sapozhnikov on 12/3/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "currency") == nil){
            defaults.set("USD", forKey: "currency")
            defaults.synchronize()
            //print(defaults.object(forKey: "currency"))
        }
        
        if(defaults.object(forKey: "exchange") == nil){
            defaults.set("Coinbase", forKey: "exchange")
            defaults.synchronize()
            //print(defaults.object(forKey: "exchange"))
        }
        
        if(defaults.object(forKey: "BTCAlertStatus") == nil){
            defaults.set(0, forKey: "BTCAlertStatus") //on(1) or off(0)
            defaults.synchronize()
            //print(defaults.object(forKey: "alertStatus"))
        }
        
        if(defaults.object(forKey: "ETHAlertStatus") == nil){
            defaults.set(0, forKey: "ETHAlertStatus") //on(1) or off(0)
            defaults.synchronize()
            //print(defaults.object(forKey: "alertStatus"))
        }
        
        if(defaults.object(forKey: "LTCAlertStatus") == nil){
            defaults.set(0, forKey: "LTCAlertStatus") //on(1) or off(0)
            defaults.synchronize()
            //print(defaults.object(forKey: "alertStatus"))
        }

        //setCoinPrices()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //setCoinPrices()
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//        if(defaults.object(forKey: "CoinPricesTest") == nil){
//            let prices : [String] = ["0", "1", "2"]
//            defaults.set(prices, forKey: "CoinPricesTest")
//            defaults.synchronize()
//            print(defaults.object(forKey: "CoinPricesTest"))
//        }
//        let myarray = defaults.stringArray(forKey: "CoinPricesTest") ?? [String]()
//
//        print(myarray[0])
//        print(myarray[1])
//        print(myarray[2])
//

//print(defaults.object(forKey: "currency"))



//defaults.set("Coding Explorer", forKey: "userNameKey")
//        userDefaults.set(arrayOfImage, forKey:"tableViewDataImage")
//        userDefaults.set(arrayOfText, forKey:"tableViewDataText")
//        userDefaults.synchronize()
//
//        var arrayOfImages = userDefaults.object(forKey: "tableViewDataImage")
//        var arrayOfText = userDefaults.object(forKey: "tableViewDataText")

