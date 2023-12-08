//
//  SceneDelegate.swift
//  demo1
//
//  Created by wps on 2023/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return } //UIWindow 是一个在 iOS 应用中用于展示界面内容的顶层容器视图。每个应用通常有一个主窗口，用于承载应用的用户界面。
       let window = UIWindow(windowScene: windowScene) // 与window.scene相关连
       let loginVC = Login()
       let mainVC = Main()
       if LoginStatus.islogin() && !LoginStatus.hasExpired(){
         window.rootViewController = mainVC
       }else{
         window.rootViewController = UINavigationController(rootViewController: loginVC)
       }
       self.window = window
       window.makeKeyAndVisible() // 窗口显示成为主窗口，并告诉程序代码应用程序可见
     }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }

}

