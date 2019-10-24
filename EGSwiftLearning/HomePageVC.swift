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

//        self.checkCryptopangrams()
//        self.checkValidNum()
        self.checkOnceInTripleArray()
        
        
        // Do any additional setup after loading the view.
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
