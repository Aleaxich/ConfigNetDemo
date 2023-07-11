//
//  ConfigViewController.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/11.
//

import UIKit

class ConfigViewController: UIViewController {
    
    var jumpToWrongInfoVC:(()->())?
    
    var jumpTpSuccseeVC:(()->())?
    
    var jumpToFailureVC:(()->())?
    
    lazy var progress = UIProgressView(progressViewStyle: .default)
    
    var count:Double = 0
    
    override func viewWillAppear(_ animated: Bool) {
        count = 0
        startConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        view.backgroundColor = UIColor.white
        setupSubviews()
        startConfig()
    }
    
    func setupSubviews() {
        progress.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 30)
        progress.progressTintColor = .red
        view.addSubview(progress)
        
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.text = "配网中。。。"
        titleLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 100, width: 200, height: 50)
        view.addSubview(titleLabel)
    }
    
    func startConfig() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] timer in
            if self!.count > 0.5 && self!.count < 0.6 {
                if  UserDefaults.standard.value(forKey: "wifiName") as! String != "123" && UserDefaults.standard.value(forKey: "password") as! String  != "123" {
                    timer.invalidate()
                    guard let action = self?.jumpToWrongInfoVC else { return }
                    action()
                }
                self!.count += 0.01
                self!.progress.progress = Float(self!.count)
            } else if self!.count  >= 1.0{
                let num = Int(arc4random_uniform(100))
                if (num % 2 == 0) {
                    guard let action = self?.jumpTpSuccseeVC else { return }
                    action()
                } else {
                    guard let action = self?.jumpToFailureVC else { return }
                    action()
                }
                timer.invalidate()
            } else {
                self!.count += 0.01
                self!.progress.progress = Float(self!.count)
            }
        }

    }
    



}
