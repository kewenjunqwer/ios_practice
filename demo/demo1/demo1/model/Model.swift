//
//  Model.swift
//  Created by wps on 2023/12/7.
//

import Foundation

class Model{
  struct userInfo: Codable{
    let userId: String
    let account: String
    let password: String
  }
  
  struct Sing:Codable{
    let id: String
    let name: String
    let singer: String
  }
}
