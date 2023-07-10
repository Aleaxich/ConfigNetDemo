//
//  InputPassWordViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/10.
//

import Foundation
import UIKit

public class InputPasswordViewController: UIViewController {
    
    lazy var stateMachine = StateMachine.shared
    
    lazy var wifiNameTextFiled = UITextField.init()
    
    lazy var passwordTextFiled = UITextField.init()


    public override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true;
        view.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    func setupSubviews() {
        
        wifiNameTextFiled.borderStyle = .line
        wifiNameTextFiled.placeholder = "请输入wifi名称  123"
        wifiNameTextFiled.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 100, width: 200, height: 50)
        view.addSubview(wifiNameTextFiled)
        
        passwordTextFiled.borderStyle = .line
        passwordTextFiled.placeholder = "请输入密码 123"
        passwordTextFiled.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 180, width: 200, height: 50)
        view.addSubview(passwordTextFiled)
        
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        closeButton.frame = CGRect(x: 10, y: 30, width: 30, height: 30)
        view.addSubview(closeButton)
        
        let button = UIButton.init()
        button.setTitle("确认", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 250, y: 300, width: 500, height: 50)
        view.addSubview(button)
    }
    
    @objc func clickCloseButton() {
        stateMachine.trigger(event: .jumpToSearchResultView)
    }
    
    @objc func clickButton() {
        UserDefaults.standard.set(wifiNameTextFiled.text, forKey: "wifiName")
        UserDefaults.standard.set(passwordTextFiled.text, forKey: "password")
        stateMachine.trigger(event: .jumpToConfigView)
    }
}
