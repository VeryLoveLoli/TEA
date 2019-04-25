//
//  ViewController.swift
//  TEATest
//
//  Created by 韦烽传 on 2019/4/25.
//  Copyright © 2019 韦烽传. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tea = TEA.init(5, key: (arc4random(), arc4random(), arc4random(), arc4random()))
        
        if let data = "1234567890".data(using: .utf8) {
            
            let enData = tea.encrypt(data)
            print("加密:")
            print((String.init(data: enData, encoding: .utf8) ?? ""))
            print(data.base64EncodedString())
            let deData = tea.decrypt(enData)
            print("解密:")
            print(String.init(data: deData, encoding: .utf8) ?? "")
        }
        
        if let url = URL.init(string: "http://baidu.com") {
            
            do {
                let data = try Data.init(contentsOf: url)
                let path = NSHomeDirectory() + "/Documents/test"
                try data.write(to: URL.init(fileURLWithPath: path))
                print("原数据:")
                print(String.init(data: data, encoding: .utf8) ?? "")
                print("加密:")
                tea.encrypt(path, outFilePath: path + "EN")
                let enData = try Data.init(contentsOf: URL.init(fileURLWithPath: path + "EN"))
                print((String.init(data: enData, encoding: .utf8) ?? ""))
                print(enData.base64EncodedString())
                print("解密:")
                tea.decrypt(path + "EN", outFilePath: path + "DE")
                let deString = try String.init(contentsOfFile: path + "DE")
                print(deString)
            } catch {
                print(error)
            }
        }
    }


}

