//
//  AppDelegate.swift
//  Fang
//
//  Created by mac on 2020/4/21.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window.rootViewController = FangViewController.init()

        self.window = window

        window.makeKeyAndVisible()
        
        configUMeng()
        configUMengShare()
        
        return true
    }
    
    
    func configUMeng(){
        UMConfigure.initWithAppkey("5f34ad13d30932215477be87", channel: "")

        MobClick.setCrashReportEnabled(true)
    }
    func configUMengShare(){
        
        UMSocialGlobal.shareInstance()?.isUsingHttpsWhenShareContent = false
        
        UMSocialGlobal.shareInstance()?.universalLinkDic = [UMSocialPlatformType.wechatSession:"https://www.zhiqian.com.cn/house/",UMSocialPlatformType.wechatTimeLine:"https://www.zhiqian.com.cn/house/"]

        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.wechatSession, appKey: "wx626abb4fd6bac74e", appSecret: "7c738986cf4019dd613e033ece4f0ae2", redirectURL: nil)

        UMSocialManager.default()?.setLauchFrom(UMSocialPlatformType.wechatSession, completion: { (response, error) in
        })
                
        UMSocialManager.default()?.openLog(true)

    }
    
    

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {

        let result = UMSocialManager.default()?.handleUniversalLink(userActivity, options: nil)
        if result != nil{
            return result ?? true
        }
        
        // Get URL components from the incoming user activity
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return false
        }

        // Check for specific URL components that you need
        guard let path = components.path,
        let params = components.queryItems else {
            return false
        }
        print("path = \(path)")
        
        if let type = params.first(where: { $0.name == "type" } )?.value,
            let id = params.first(where: { $0.name == "id" })?.value {
            
            print("album = \(type)")
            print("photoIndex = \(id)")
            return true
            
        } else {
            print("Either album name or photo index missing")
            return false
        }
    }
    
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        
        if result == nil{
            return true
        }
        return result ?? true
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        let result = UMSocialManager.default()?.handleOpen(url, options: options)
     
        if result == nil{
            return true
        }
        return result ?? true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, options: nil)
        
           if result == nil{
               return true
           }
           return result ?? true

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
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

