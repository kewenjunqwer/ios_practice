//
//  Login.swift
//  demo1

import UIKit
import SnapKit

class Login: UIViewController,UITextFieldDelegate {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "登录"
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  let usernameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "用户名"
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
    return textField
  }()
  
  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "密码"
    textField.isSecureTextEntry = true
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
    return textField
  }()
  
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("登录", for: .normal)
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 5
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    view.addGestureRecognizer(tapGesture)
    viewSetUp()
    frameSetup()
    bindEvent()
  }
  
  // 利用snapkit进行布局
  func viewSetUp(){
    view.addSubview(titleLabel)
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
  }
  
  func frameSetup() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
    }
    // 创建 usernameTextField 并设置约束
    usernameTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(100)
      make.leading.equalTo(view).offset(20)
      make.trailing.equalTo(view).offset(-20)
    }
    
    // 创建 passwordTextField 并设置约束
    passwordTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(usernameTextField.snp.bottom).offset(20)
      make.leading.equalTo(view).offset(20)
      make.trailing.equalTo(view).offset(-20)
    }
    
    loginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(passwordTextField.snp_bottomMargin).offset(100)
      make.width.equalTo(200)
      make.height.equalTo(40)
    }
  }
  // 搬定事件
  func bindEvent(){
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
  }
  // 开始输入账户民或者密码
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == usernameTextField {
      usernameTextField.becomeFirstResponder()
    }else{
      passwordTextField.becomeFirstResponder()
    }
  }
  
  @objc func viewTapped(_ textField: UITextField) {
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }
  
  // 进行登陆
  @objc func loginButtonTapped() {

    if let account = usernameTextField.text,!account.isEmpty,
       let password = passwordTextField.text,!password.isEmpty{
      let parameters: [String: Any] = [
          "account": account,
          "password": password
      ]
      
      // 将参数转换为 JSON 格式的 Data
      guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters,options: []) else {
          print("Failed to convert parameters to JSON data")
          return
      }
      
      // 进行登陆
      do{
        NetWorkManager.shared.toLogin(body: jsonData) { result in
          switch result {
            case .success(let res):
              if res.code == 0 {
                LoginStatus.setlogin(true)
                LoginStatus.setExpiration(3600 * 24)
                UserInfo.shared.account = res.data.user.account
                UserInfo.shared.userId = res.data.user.userId
                DispatchQueue.main.async {
                  let mainVC = Main()
                  self.navigationController?.pushViewController(mainVC, animated: true)
                }
              }else{
                self.showAlert(message: res.message)
              }
            case .failure(let error):
              print("Login failed with error: \(error)")
          }
        }
      }catch {
        print("Error converting dictionary to Data: \(error)")
      }
    }
  }
    
  
  // 提示错误信息
  func showAlert(message: String) {
    let alert = UIAlertController(title: "登录结果", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
