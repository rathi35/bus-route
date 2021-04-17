//
//  AppDelegate.swift
//  BusRoute
//
//  Created by Rathi on 3/31/21.
//

import UIKit
#if DEBUG
import OHHTTPStubsSwift
import OHHTTPStubs
#endif
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if UIDevice.isiPhone() {
            return .portrait
        }
        return .all
    }
    
    func configure() {
        window?.tintColor = .black
        #if DEBUG
        configureForUITesting()
        #endif
    }
    #if DEBUG
    func configureForUITesting() {
        if CommandLine.arguments.contains("--uitesting") {
            func setStub(_ urlPath: String, jsonName: String) {
                stub(condition: pathStartsWith(urlPath)) { _ in
                    let stubPath = OHPathForFile(jsonName, type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                }
            }
            setStub("/data", jsonName: "SRPdummyresponse.json")
            
        }
    }
    #endif
}
