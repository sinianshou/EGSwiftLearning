//
//  HomePageVC.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/17.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        let bn = UIButton.init()
        bn.setTitle("测试", for: .normal)
        bn.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        bn.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(bn)
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func test(){
//        self.checkCryptopangrams()
//        self.checkValidNum()
//        self.checkOnceInTripleArray()
        self.checkMaxPointOnLine()
    }
    func checkMaxPointOnLine(){
        print("checkMaxPointOnLine result is ")
        var result = "Output: "
        let datas = DataBuilder.maxPointOnLineData()
        for points in datas {
            let num = AlgorithmManager.MaxPointOnLineSolution(points: points)
            result += " " + String(num)
        }
        print(result)
    }
    func checkValidNum(){
        print("checkValidNum result is ")
        for e in DataBuilder.ValidNumberData(){
            let isNum = AlgorithmManager.ValidNumberSolution(e)
            print(e+" => "+String(isNum))
        }
    }
    
    func checkCryptopangrams(){
        //获取输入数据
        let data = DataBuilder.cryptopangramsData()
        //获取解密字符串
        let result = AlgorithmManager.cryptopangrams(N: data["N"] as! NSInteger, L: data["L"] as! NSInteger, ARR: data["ARR"] as! [NSInteger])
        //打印字符串
        print("checkCryptopangrams result is "+(result as! String))
    }
    
    func checkOnceInTripleArray() {
        let data = DataBuilder.OnceInTripleData()
        let result = AlgorithmManager.OnceInTripleArray(numArr: data)
        print("checkOnceInTripleArray result is "+String(result))
    }

}
