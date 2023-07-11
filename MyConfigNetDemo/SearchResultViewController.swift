//
//  SearchResultViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/11.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    lazy var deviceList = ["跑步机","单车","椭圆机","划船机"]
    
    // 点击下一步
    var clickAction:(()->())?
    
    // 退出
    var closeAction:(()->())?


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
        let index = arc4random_uniform(3)
        titleLabel.text = deviceList[Int(index)]
        titleLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 100, width: 200, height: 50)
        view.addSubview(titleLabel)
        
        let button = UIButton.init()
        button.setTitle("进入账号密码页面", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 300, width: 200, height: 50)
        view.addSubview(closeButton)
    }
    
    @objc func click() {
        guard let click = self.clickAction else { return }
        click()
    }
    
    @objc func close() {
        guard let close = self.closeAction else { return }
        close()
    }
}
