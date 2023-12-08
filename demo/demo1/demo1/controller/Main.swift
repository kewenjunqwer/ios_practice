//
//  Main.swift 首页
//  demo1
//
//  Created by wps on 2023/12/7.
//

import UIKit

class Main: UITabBarController {
  
  let singsVC = UINavigationController(rootViewController: (Sings()))
  let likesVC = UINavigationController(rootViewController: (Likes()))
  let userVC = UINavigationController(rootViewController: (User()))
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
//    LoginStatus.setlogin(false)
    
    singsVC.tabBarItem = UITabBarItem(title: "歌曲",image:nil,tag: 0)
    likesVC.tabBarItem = UITabBarItem(title: "喜欢", image: nil,tag: 1)
    userVC.tabBarItem = UITabBarItem(title: "我的", image: nil,tag: 2)
    self.viewControllers = [singsVC,likesVC,userVC]
    self.selectedIndex = 0
    view.backgroundColor = .white
    
    print(UserInfo.shared.account)
  }
}

