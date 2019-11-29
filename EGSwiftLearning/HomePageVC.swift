//
//  HomePageVC.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/17.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class HomePageVC: UIViewController {
    
    var resultView = UITextView()
    var algo = AlgorithmManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIConfig()
        // Do any additional setup after loading the view.
    }
    func UIConfig(){
        self.view.backgroundColor = UIColor.white
        let bn = UIButton.init()
        bn.setTitle("测试", for: .normal)
        bn.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        bn.addTarget(self, action: #selector(test), for: .touchUpInside)
        bn.backgroundColor = UIColor.init(red: 0/255.0, green: 144/255.0, blue: 238/255.0, alpha: 1)
        self.view.addSubview(bn)
        resultView.frame = CGRect(x: bn.frame.origin.x, y: bn.frame.origin.y + bn.frame.size.height + 20, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.3)
        resultView.backgroundColor = UIColor.lightGray
        self.view.addSubview(resultView)
    }
    @objc func test(){
        var result = ""
//        result = self.checkCryptopangrams()
//        result = self.checkValidNum()
//        result = self.checkOnceInTripleArray()
//        result = self.checkMaxPointOnLine()
//        result = self.checkLongestDuplicateSubstring()
//        result = self.checkNearestPalindromic()
result = self.checkWordLadder2()
//result = self.checkStayInSamePlace()
//        result = self.checkWordLadder2()
        
        var map = Map()
        
        resultView.text = result
    }
    func checkWordLadder2() -> String{
        var result = "checkWordLadder2 result is :"
        let items = DataBuilder.WordLadder2Data()
        let keys = DataBuilder.WordLadder2Keys
        for item in items {
            let begin = item[keys[0]] as! String
            let end = item[keys[1]] as! String
            let list = item[keys[2]]  as! [String]
            let resultArr = AlgorithmManager.WordLadder2Solution(begin, end, list)
            result += "\n" + keys[0] + " = " + begin
            result += "\n" + keys[1] + " = " + end
            result += "\n" + keys[2] + " = [ "
            for e in list {
                result += e + ", "
            }
            result += "]"
            result += "\nLadder : "
            for Es in resultArr {
                result += "\n[ "
                for e in Es {
                    result += e + ", "
                }
                result += "]"
            }
            result += "\n"
        }
        return result
    }
    func checkNearestPalindromic() -> String{
        var result = "checkNearestPalindromic result is :"
        let items = DataBuilder.NearestPalindromicData()
        for item in items {
            let str = AlgorithmManager.NearestPalindromicSolution(item)
            result += "\n\""+item+"\" => "+str
        }
        return result
    }
    func checkMaxPointOnLine() -> String{
        print("checkMaxPointOnLine result is ")
        var result = "checkMaxPointOnLine result is \nOutput: "
        let datas = DataBuilder.MaxPointOnLineData()
        for points in datas {
            let num = AlgorithmManager.MaxPointOnLineSolution(points: points)
            result += " " + String(num)
        }
        return result
    }
    func checkValidNum() -> String{
        var result = "checkValidNum result is "
        for e in DataBuilder.ValidNumberData(){
            let isNum = AlgorithmManager.ValidNumberSolution(e)
            result += "\n\""+e+"\" => "+String(isNum)
        }
        return result
    }
    
    func checkCryptopangrams() -> String{
        //获取输入数据
        let data = DataBuilder.cryptopangramsData()
        //获取解密字符串
        let str = AlgorithmManager.cryptopangrams(N: data["N"] as! NSInteger, L: data["L"] as! NSInteger, ARR: data["ARR"] as! [NSInteger])
        //打印字符串
        let result = "checkCryptopangrams result is "+(str as! String)
        return result
    }
    
    func checkOnceInTripleArray()  -> String{
        let data = DataBuilder.OnceInTripleData()
        let num = AlgorithmManager.OnceInTripleArray(numArr: data)
        let result = "checkOnceInTripleArray result is "+String(num)
        return result
    }

    func checkLongestDuplicateSubstring() -> String {
        var result = "checkLongestDuplicateSubstring is: \n"
        let data = DataBuilder.LongestDuplicateSubstringData()
        for str in data {
            result += "\"" + str + "\"=>\"" + AlgorithmManager.LongestDuplicateSubstringSolution(str) + "\"\n"
        }
        return result
    }
    func checkStayInSamePlace() -> String {
        var result = "checkStayInSamePlace is: \n"
        let datas = DataBuilder.StayInSamePlaceData()
        for data in datas {
            result += "steps = " + String(data["steps"]!) + " arrLen = " + String(data["arrLen"]!) + "\n"
            result += "output : " + String(self.algo.numWays(data["steps"]!, data["arrLen"]!)) + "\n"
        }
        return result
    }
}
