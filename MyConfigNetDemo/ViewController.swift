//
//  ViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/10.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var stateMachine = StateMachine.shared

    
     lazy var deviceList = ["跑步机","单车","椭圆机","划船机"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white
        configStateMachine()
        setupSubviews()
    }
    
    func setupSubviews() {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        let index = arc4random_uniform(3)
        titleLabel.text = deviceList[Int(index)]
        titleLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 100, width: 200, height: 50)
        view.addSubview(titleLabel)
        
        let button = UIButton.init()
        button.setTitle("进入账号密码页面", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
    }
    
    @objc func clickButton() {
        stateMachine.trigger(event: ConfigEvent.jumpToInputPasswordView)
    }
    
    func configStateMachine() {
        // 从搜索设备页面进入输入页面
        stateMachine.add(event: ConfigEvent.jumpToInputPasswordView, originalState: ConfigState.searchState, targetState: ConfigState.passwordState) { _ in
            let passwordVC = InputPasswordViewController()
            self.navigationController?.pushViewController(passwordVC, animated: true)
        }
    /*
     目前的疑问
     1.是否需要写一个页面管理模块控制页面间的切换
     2.状态机是如何在页面间传递
     */
        // 从输入密码页面回退
        stateMachine.add(event: ConfigEvent.jumpToSearchResultView, originalState: ConfigState.passwordState, targetState: ConfigState.searchState) { _ in
            let vc = self.navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(vc!, animated: true)
        }
        
        stateMachine.add(event: .jumpToConfigView, originalState: .passwordState, targetState: .configState) { _ in
            let configVC = ConfigViewController()
            self.navigationController?.pushViewController(configVC, animated: true)
        }
        
        // 密码重试
        stateMachine.add(event: .jumpToInputPasswordView, originalState: .illegalPasswordState, targetState: .passwordState) { _ in
            let vc = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(vc!, animated: true)
        }
        
        // 配网重试
        stateMachine.add(event: .jumpToConfigView, originalState: .ConfigFailureState, targetState: .configState) { _ in
            let vc = self.navigationController?.viewControllers[2]
            self.navigationController?.popToViewController(vc!, animated: true)
        }
        
        // 配网成功
        stateMachine.add(event: .jumpToConfigSuccessView, originalState: .configState, targetState: .ConfigSuccessState) { _ in
            let successVC = SuccessViewController()
            self.navigationController?.pushViewController(successVC, animated: true)
        }
        
        // 密码错误
        stateMachine.add(event: .jumpToIllegalPasswordView, originalState: .configState, targetState: .illegalPasswordState) { _ in
            let wrongInfoVC = WrongWifiInfoViewController()
            self.navigationController?.pushViewController(wrongInfoVC, animated: true)
        }
        
        
        // 配网失败
        stateMachine.add(event: .jumpToConfigFailureView, originalState: .configState, targetState: .ConfigFailureState) { _ in
            let failureVC = FailureViewController()
            self.navigationController?.pushViewController(failureVC, animated: true)

        }
        
               
       
    }

}



