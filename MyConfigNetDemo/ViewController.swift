//
//  ViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/10.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var stateMachine = StateMachine.shared
    
    // 初始化所有控制器
    lazy var searchResultVC = SearchResultViewController()
    lazy var passWordVC = InputPasswordViewController()
    lazy var configVC = ConfigViewController()
    lazy var wrongInfoVC = WrongWifiInfoViewController()
    lazy var successVC = SuccessViewController()
    lazy var failureVC = FailureViewController()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white
        configStateMachine()
        setupSubviews()
        config()
    }
    
    func setupSubviews() {
        let button = UIButton.init()
        button.setTitle("进入配网流程", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
    }
    
    func config() {
        searchResultVC.clickAction = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToInputPasswordView)
        }
        searchResultVC.closeAction = {[weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        passWordVC.clickAction = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToConfigView)
        }
        
        passWordVC.closeAction = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToSearchResultView)
        }
        
        configVC.jumpToWrongInfoVC = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToIllegalPasswordView)
        }
        configVC.jumpTpSuccseeVC = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToConfigSuccessView)
        }
        configVC.jumpToFailureVC = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToConfigFailureView)
        }
        
        wrongInfoVC.retry = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToInputPasswordView)
        }
        
        successVC.close = {[weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        failureVC.retry = {[weak self] in
            self?.stateMachine.trigger(event: .jumpToConfigView)
        }
        
    }
    
    @objc func clickButton() {
        self.navigationController!.pushViewController(searchResultVC, animated: true)
    }
    
    
    func configStateMachine() {
        // 从搜索设备页面进入输入页面
        stateMachine.add(event: .jumpToInputPasswordView, originalState: .searchState, targetState: .passwordState) {[weak self] (_) in
            self!.navigationController!.pushViewController(self!.passWordVC, animated: true)
        }
    /*
     目前的疑问
     1.是否需要写一个页面管理模块控制页面间的切换
     2.状态机是如何在页面间传递
     */
        // 从输入密码页面回退
        stateMachine.add(event: .jumpToSearchResultView, originalState: .passwordState, targetState: .searchState) {[weak self] (_) in
            self!.navigationController!.popToViewController(self!.searchResultVC, animated: true)
        }
        
        stateMachine.add(event: .jumpToConfigView, originalState: .passwordState, targetState: .configState) {[weak self] (_) in
            self!.navigationController!.pushViewController(self!.configVC, animated: true)
        }
        
        // 密码重试
        stateMachine.add(event: .jumpToInputPasswordView, originalState: .illegalPasswordState, targetState: .passwordState) {[weak self] (_) in
            self!.navigationController!.popToViewController(self!.passWordVC, animated: true)
        }
        
        // 配网重试
        stateMachine.add(event: .jumpToConfigView, originalState: .ConfigFailureState, targetState: .configState) {[weak self] (_) in
            self!.navigationController!.popToViewController(self!.configVC, animated: true)
        }
        
        // 配网成功
        stateMachine.add(event: .jumpToConfigSuccessView, originalState: .configState, targetState: .ConfigSuccessState) {[weak self] (_) in
            self!.navigationController!.pushViewController(self!.successVC, animated: true)
        }
        
        // 密码错误
        stateMachine.add(event: .jumpToIllegalPasswordView, originalState: .configState, targetState: .illegalPasswordState) {[weak self] (_) in
            self!.navigationController!.pushViewController(self!.wrongInfoVC, animated: true)
        }
        
        
        // 配网失败
        stateMachine.add(event: .jumpToConfigFailureView, originalState: .configState, targetState: .ConfigFailureState) {[weak self] (_) in
            self!.navigationController!.pushViewController(self!.failureVC, animated: true)

        }
        
               
       
    }

}



