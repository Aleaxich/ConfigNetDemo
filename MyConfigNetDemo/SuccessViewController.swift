//
//  SuccessViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/11.
//

import UIKit

class SuccessViewController: UIViewController {
    
    lazy var stateMachine = StateMachine.shared


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white
        setupSubviews()
    }
    

    func setupSubviews() {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.text = "配网成功！"
        titleLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 100, width: 200, height: 50)
        view.addSubview(titleLabel)
    }
}
