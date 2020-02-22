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
        self.view.backgroundColor = UIColor.brown
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
//        result = self.checkStayInSamePlace()
//        result = self.checkPalindromePartition()
//        result = self.checkWordLadder2()
//        result = self.checkStrongPasswordCheckerData()
//        result = self.checkWildcardMatching()
//        result = self.checkTextJustification()
//        result = self.checkWildcardMatching()
//        result = self.checkreversePairs()
//        result = self.checkShortestSubarray()
//        result = self.checkNumberToWordsData()
//        result = self.checkSplitArraySameAverageData()
        result = self.checkDecodeWays2Data()
        
//        let map = Map()
//        map.testMap()
//        map.testCompactMap()
//        map.testCompactMapValues()
//        map.testFlatMap()
        
        resultView.text = result
        
//        var rp = Bundle.main.path(forResource: "123", ofType: "txt")
////        rp = Bundle.main.path(forResource: "DataBuilder", ofType: "swift")
//        do {
//            let con = try String(contentsOfFile: rp!, encoding: .utf8)
//            print("con is ",con)
//        } catch let err {
//            print("error:\(err)")//捕捉到错误，处理错误
//        }
        
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
    func checkPalindromePartition() -> String {
        var result = "checkPalindromePartition is: \n"
        let datas = DataBuilder.palindromePartitionData()
        for data in datas {
            
            result += "s = " + (data["s"]as! String) + " k = " + String(data["k"] as! Int) + "\n"
            result += "output : " + String(self.algo.palindromePartition(data["s"] as! String, data["k"] as! Int)) + "\n"
        }
        
        return result
    }
    func checkStrongPasswordCheckerData() -> String {
        var result = "checkStrongPasswordCheckerData is: \n"
        let datas = DataBuilder.StrongPasswordCheckerData()
        for data in datas {
            result += "str = " + data + "\n"
            result += "output : " + String(self.algo.strongPasswordChecker(data)) + "\n"
        }
        return result
    }
    func checkWildcardMatching() -> String {
        var result = "checkWildcardMatching is: \n"
        let datas = DataBuilder.WildcardMatchingData()
        for data in datas {
            result += "s = " + data[0] +  " p = " + data[1] + "\n"
            result += "output : " + String(self.algo.wildcardMatchingChecker1(data[0], p: data[1])) + "\n"
//            result += "output : " + String(self.algo.wildcardMatchingChecker(data[0], p: data[1])) + "\n"
        }
        return result
    }
    func checkTextJustification() -> String {
        var result = "checkTextJustification is: \n"
        let datas = DataBuilder.TextJustificationData()
        for data in datas {
            result += "[ "
            let words = data["words"] as! [String];
            let maxWid = data["maxWidth"] as! Int
            for word in words {
                result += word + ", "
            }
            result += "], \nmaxWidth = " + String(maxWid) +  "\n"
            result += "output : \n["
            let res = self.algo.fullJustify(words, maxWid)
            for re in res {
                result += re + "\n"
            }
            result += "]\n"
        }
        return result
    }
    
    
        func checkreversePairs() -> String {
            var result = "checkreversePairs is: \n"
            let datas = DataBuilder.reversePairsData()
            for data in datas {
                
                result += "[ " + data.map(String.init).joined(separator: ",") + "]\n"
                result += "output : " + String(self.algo.reversePairs(data)) + "\n"
    //            result += "output : " + String(self.algo.wildcardMatchingChecker(data[0], p: data[1])) + "\n"
            }
            return result
        }
    
        func checkShortestSubarray() -> String {
            var result = "checkShortestSubarray is: \n"
            let datas = DataBuilder.shortestSubarrayData()
            for data in datas {
                result += "[ "
                for d in data["A"] as! [Int]{
                    result += String(d) + ", "
                }
                result += "], K is " + String(data["K"] as! Int) + " \n"
                result += "output : " + String(self.algo.shortestSubarray(data["A"] as! [Int],data["K"] as! Int)) + "\n"
            }
            return result
        }
    
    func checkNumberToWordsData() -> String {
        var result = "checkNumberToWordsData is: \n"
        let datas = DataBuilder.NumberToWordsData()
        for num in datas {
            result += "num is : " + String(num) + "\n"
            result += "output : " + self.algo.numberToWords(num) + "\n"
        }
        return result
    }
    func checkSplitArraySameAverageData() -> String {
        var result = "checkSplitArraySameAverageData is: \n"
        let datas = DataBuilder.SplitArraySameAverageData()
        for nums in datas {
            result += "arr is : [ "
            for d in nums {
                result += String(d) + ", "
            }
            result += "]  \n"
            result += "output : " + String(self.algo.splitArraySameAverage(nums)) + "\n"
        }
        return result
    }
    func checkDecodeWays2Data() -> String {
        var result = "checkDecodeWays2Data is: \n"
        let datas = DataBuilder.DecodeWays2Data()
        for str in datas {
            result += "str is :  " + str +  "  \n"
            result += "output : " + String(self.algo.numDecodings(str)) + "\n"
        }
        return result
    }
}
