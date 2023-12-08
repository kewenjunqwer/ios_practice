//
//  Sings.swift
//  demo1
//  Created by wps on 2023/12/7.
//

import UIKit
import SnapKit

class Sings: UIViewController {
  
  private let refreshControl = UIRefreshControl()
  
  var selectedIndexPath: IndexPath?
  
  var delegate: MakeSwipaction?
  
  let table: UITableView = {
    let table = UITableView()
    return table
  }()
  
  var sings: [Model.Sing]? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(table)
    table.delegate = self
    table.dataSource = self
    table.register(ListCell.self, forCellReuseIdentifier: "singCell")
    frameSetUp()
    getSings()
    delegate = self
    
    // 添加下拉刷新控件的动作
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    
    // 将下拉刷新控件添加到UITableView
    table.refreshControl = refreshControl
  }
  
  @objc private func refreshData(_ sender: Any) {
    // 在这里执行刷新数据的操作
    getSings()
    // 刷新完成后结束刷新
    refreshControl.endRefreshing()
  }
  
  // 设置布局
  func frameSetUp(){
    table.snp.makeConstraints { make in
      make.left.equalTo(view.snp.left).offset(0)
      make.right.equalTo(view.snp.right).offset(0)
      make.top.equalTo(view.snp_topMargin).offset(0)
      make.bottom.equalTo(view.snp.bottom).offset(0)
    }
  }
  
  // 获取所有的歌曲
  func getSings(){
    NetWorkManager.shared.getAllsings{ result in
      switch result{
        case.success(let res):
          self.sings = res.data.sings
          DispatchQueue.main.async {
            self.table.reloadData()
          }
        case .failure(let error):
          print(error)
      }
    }
  }
}

extension Sings:UITableViewDelegate,UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sings?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "singCell", for: indexPath) as! ListCell
    if let sing = self.sings?[indexPath.row]{
      cell.setConfigure(data: sing)
      // 设置字体
      if self.selectedIndexPath == indexPath{
        cell.titleLabel.textColor = UIColor.green
      }else{
        cell.titleLabel.textColor = UIColor.black
      }
      return cell
    }
    return cell
  }
  
  // 点击选中的cell
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedIndexPath = indexPath
    let visibleIndexPaths = tableView.indexPathsForVisibleRows
    tableView.reloadRows(at: visibleIndexPaths ?? [], with: .automatic)
  }
  
  // cell配置左滑服务
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    guard let curSing = self.sings?[indexPath.row] else { return nil}
    guard let  swipActionItems = delegate?.makeSwipItems(currentSing: curSing, indexPath: indexPath) else {return nil}
    
    let configuration = delegate?.makeConfiguration(currentSing: curSing, indexPath: indexPath, items: swipActionItems)
    return configuration
  }
}

// 定义左滑的相关服务
protocol MakeSwipaction{
  func makeSwipItems(currentSing:Model.Sing,indexPath:IndexPath) -> [swipActionItem]
  func makeConfiguration(currentSing:Model.Sing,indexPath:IndexPath,items:[swipActionItem]) -> UISwipeActionsConfiguration
}

// 配置左滑服务等相关
enum Operation: String{
  case DELETE = "delete"
  case COLLECT = "colletc"
  case DOWNLOAD = "download"
  static var allCases: [Operation] {
    return [.DELETE, .COLLECT, .DOWNLOAD]
  }
}
 
class swipActionItem{
  var title: String = ""
  var image: UIImage?
  var swipAction: ()->Void
  init(title: String, image: UIImage? = nil, swipAction: @escaping () -> Void) {
    self.title = title
    self.image = image
    self.swipAction = swipAction
  }
}

// 生成默认的左滑服务
func generateDefaultSwipActionItem(currentSing:Model.Sing, indexPath: IndexPath) -> [swipActionItem]{
  var swipActionItems:[swipActionItem] = []
  for operation in Operation.allCases{
    let action = swipActionItem(title: operation.rawValue, image: nil, swipAction: { print("hello") } )
    swipActionItems.append(action)
  }
  for var item in swipActionItems{
    switch item.title{
      case Operation.DELETE.rawValue:
        item.swipAction = { () in print("删除") }
      case Operation.COLLECT.rawValue:
        item.swipAction = {  print("收藏") }
      case Operation.DOWNLOAD.rawValue:
        item.swipAction = { () in print("下载") }
      default:
        print("22")
    }
  }
  return swipActionItems
}

// 继承左滑服务协议
extension Sings:MakeSwipaction{
  func makeSwipItems(currentSing: Model.Sing, indexPath: IndexPath) -> [swipActionItem] {
    let def = generateDefaultSwipActionItem(currentSing: currentSing, indexPath: indexPath)
    return def
  }
  func makeConfiguration(currentSing: Model.Sing, indexPath: IndexPath,items:[swipActionItem]) -> UISwipeActionsConfiguration {
    var  ContextualActions: [UIContextualAction] = []
    for item in items{
      let contextualAction = UIContextualAction(style: .destructive, title: item.title) { (action, view, completionHandler) in
        // 执行删除操作，可以在这里处理删除逻辑
        item.swipAction()
        completionHandler(true)
      }
      ContextualActions.append(contextualAction)
    }
    let swipeConfiguration = UISwipeActionsConfiguration(actions: ContextualActions)
    
    return swipeConfiguration
    
  }
}
