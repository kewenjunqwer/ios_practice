//
//  list.swift
//  Created by wps on 2023/12/5.
//

import UIKit

// 自定义cell
class ListCell: UITableViewCell {
  

  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = UIFont.systemFont(ofSize: 15, weight: .light)
    label.textColor = UIColor.black
    return label
  }()
  
  let singerLabel: UILabel = {
    let lable = UILabel()
    lable.font = UIFont.systemFont(ofSize: 10,weight: .light)
    lable.textColor = .gray
    return lable
  }()
  
  let hstck: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 2
    return stack
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
//    viewSetUp()
//    
    // Initialization code
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    viewSetUp()
    frameSetUp()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func viewSetUp(){
    hstck.addArrangedSubview(titleLabel)
    hstck.addArrangedSubview(singerLabel)
    contentView.addSubview(hstck)
  }
  
  func frameSetUp(){
    hstck.snp.makeConstraints { make in
      make.left.equalTo(contentView.snp.left).offset(16)
      make.centerY.equalTo(contentView)
    }
    
  }
  
  func setConfigure(data: Model.Sing){
    titleLabel.text = data.name
    singerLabel.text = data.singer
  }
  
}
