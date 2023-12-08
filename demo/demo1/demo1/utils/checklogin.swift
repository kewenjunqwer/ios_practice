//
//  checklogin.swift
//  demo1
//
//  Created by wps on 2023/12/7.
//

import Foundation
class LoginStatus{
  // 设置用户的登陆状态为true
  static func setlogin(_ islogin: Bool){
    UserDefaults.standard.set(islogin, forKey: USER_LOGIN)
  }
  
  // 检查用户是否登陆
  static func islogin()->Bool{
    return UserDefaults.standard.bool(forKey: USER_LOGIN)
  }
  // 设置过期时间
  static func setExpiration(_ expirationTime: Double) {
    UserDefaults.standard.set( Date().addingTimeInterval(expirationTime), forKey: LOGIN_EXPIRATION)
  }
  // 检查登陆是否过期
  static func hasExpired() -> Bool {
    if let expiration = UserDefaults.standard.object(forKey: LOGIN_EXPIRATION) as? Date {
      return expiration < Date()
    }
    return true
  }
  
  private static let USER_LOGIN = "USER_LOGIN"
  
  private static let LOGIN_EXPIRATION = "LOGIN_EXPIRATION"
}

// 用于存贮用户信息
class UserInfo{
  static let shared = UserInfo(account: nil, userId: nil)
  
  var account: String?
  var userId: String?
  
  init(account: String?, userId: String?) {
    self.account = account
    self.userId = userId
  }
}
