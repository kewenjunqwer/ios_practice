//
//  request.swift
//  demo1
//
//  Created by wps on 2023/12/7.
//

import Foundation

let baseUrl = "http://localhost:3000"
//
func httpRequest<T: Codable>(api: String, method: String = "GET", body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
  // Validate the URL
  guard let url = URL(string: baseUrl + api) else {
    completion(.failure(NSError(domain: "Invalid API endpoint", code: -1)))
    return
  }
  
  // Create the URLRequest
  var request = URLRequest(url: url)
  request.httpMethod = method
  
  // Add body data for POST requests
  if method == "POST" {
    request.httpBody = body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  }
  
  // Start the data task
  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    // Check for errors
    if let error = error {
      completion(.failure(error))
      return
    }
    
    // Check for returned data
    guard let data = data else {
      completion(.failure(NSError(domain: "No data received", code: -1)))
      return
    }
    
    // Parse the data
    do {
      let decoder = JSONDecoder()
      let decodedData = try decoder.decode(Response.self, from: data)
      if decodedData.code == 0{
        let sucessData = try decoder.decode(T.self, from: data)
        completion(.success(sucessData))
      }else{
        print(decodedData.message)
      }
    } catch {
      completion(.failure(error))
    }
  }
  task.resume()
}


struct Response: Codable {
  let code: Int
  let message: String
}

struct Res<T:Codable>: Codable{
  let code: Int
  let data: T
  let message: String
}

struct UserData: Codable {
  let user: Model.userInfo
}
struct SingsData: Codable {
  let sings: [Model.Sing]
}
class NetWorkManager{
  static let shared = NetWorkManager()
  // 去登陆
  func toLogin( body: Data? = nil, completion: @escaping (Result<Res<UserData>, Error>) -> Void){
    httpRequest(api: "/api/login", method: "POST", body: body, completion: completion)
  }
  // 获取所有的歌曲呀
  func getAllsings( completion: @escaping (Result<Res<SingsData>, Error>) -> Void){
    httpRequest(api: "/api/sings", completion: completion)
  }
}
