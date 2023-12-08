////
////  homeViewController.swift
////
////  Created by wps on 2023/12/5.
////
//
//import UIKit
//import Foundation
//import SnapKit
//
//// 首页
//class homeViewController: UIViewController{
//  
//  var selectedIndexPath: IndexPath?
//  let table: UITableView = {
//    let table = UITableView()
//    return table
//  }()
//  
//  
//  struct listData{
//    var
//  }
//  // 数据列表
//  var _data: [listData] = []
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    // 设置代理
//    table.delegate = self
//    table.dataSource = self
//    table.backgroundColor = .gray
//    view.backgroundColor = .white
//    view.addSubview(table)
//    table.register(ListCell.self, forCellReuseIdentifier: "CustomCell")
//    frameSetUp()
//    
//    getData(url: "http://127.0.0.1:3000/", completion: { res in
//      switch res {
//        case .success( let data ):
//          self._data = data
//          // 在主线程进行更新
//          DispatchQueue.main.async {
//            self.table.reloadData()
//          }
//        case .failure(let  error):
//          print("error",error)
//      }
//    })
//  }
//  
//  func frameSetUp(){
//    table.snp.makeConstraints { make in
//      make.left.equalTo(view.snp.left).offset(0)
//      make.right.equalTo(view.snp.right).offset(0)
//      make.top.equalTo(view.snp.top).offset(0)
//      make.bottom.equalTo(view.snp.bottom).offset(0)
//    }
//  }
//}
//
//extension homeViewController{
//  
//  func getData(url:String,completion: @escaping(Result<[listData],Error>) -> Void){
//    guard let url = URL(string: url) else{
//      print("无效的的服务器地址")
//      return
//    }
//    
//    let session = URLSession.shared
//    let task = session.dataTask(with: url){ (data,res,error) in
//      if let error = error {
//        completion(.failure(error))
//      }
//      
//      guard let data = data else {
//        completion(.failure(NSError(domain: "没有数据", code: 0)))
//        return
//      }
//      
//      do {
//        let listData = try JSONDecoder().decode([listData].self, from: data)
//        completion(.success(listData))
//        print("listdata",listData)
//      }catch let decodeerror{
//        completion(.failure(decodeerror))
//      }
//    }
//    task.resume()
//  }
//}
//
//// 对homeviewcontroller进行拓展
//extension homeViewController: UITableViewDelegate,UITableViewDataSource{
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return self._data.count
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let item = self._data[indexPath.row]
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? ListCell else {
//      fatalError("Failed to dequeue a cell with identifier CustomCell.")
//    }
//    cell.setConfigure(data: item)
//    // 添加长按手势
//    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//    cell.addGestureRecognizer(longPressGesture)
//    return cell
//  }
//  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let item = self._data[indexPath.row]
//    print(item)
//  }
//  
//  @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
//    if gestureRecognizer.state == .began {
//      // 长按开始时获取所在cell的indexPath
//      let touchPoint = gestureRecognizer.location(in: table)
//      if let indexPath = table.indexPathForRow(at: touchPoint) {
//        selectedIndexPath = indexPath
//        
//        // 获取长按的cell
//        if let cell = table.cellForRow(at: indexPath) {
//          let interaction = UIContextMenuInteraction(delegate: self)
//          cell.addInteraction(interaction)
//        }
//      }
//    }
//  }
//  
//  @objc func handleOption1(indexpath:IndexPath){
//        if let index = self.selectedIndexPath?.row{
//      print(self._data[index])
//    }}
//  
//  @objc func handleOption2() {
//    // 处理 Option 2 的逻辑
//    print("Option 2 selected")
//  }
//  
//}
//
//extension homeViewController: UIContextMenuInteractionDelegate {
//  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//    guard let indexPath = table.indexPathForRow(at: location) else {
//      return nil
//    }
//    let identifier = NSUUID()
//    
//    let option1Command = UICommand(title: "Option 1", action: #selector(handleOption1))
//    let option2Command = UICommand(title: "Option 2", action: #selector(handleOption2))
//    
//    // Create UIContextMenuConfiguration
//    let configuration = UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _ in
//      UIMenu(title: "", image: nil, identifier: nil, options: [], children: [option1Command,option2Command])
//    }
//    
//    return configuration
//  }
//  
//  // Implement UIContextMenuInteractionDelegate methods if needed
//}
