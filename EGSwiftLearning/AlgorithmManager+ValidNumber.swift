//
//  ValidNumber.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/22.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager {
    
    class func ValidNumberSolution(_ s: String) -> Bool {
//        枚举输入的六类情况
        enum InputType : Int {
           case INVALID = 0    // 0 Include: Alphas, '(', '&' ans so on
           case BLANK = 1  // 1 " "
           case SIGN = 2   // 2 '+','-'
           case DIGIT = 3  // 3 numbers
           case DOT = 4    // 4 '.'
           case EXPONENT = 5   // 5 'e' 'E'
       }
//        将不同状态下输遇到不同输入时得到的状态以二位数组的形式列出来，-1代表非法状态
        let transTable : [[Int]] = [
                //0INVA,1SPA,2SIG,3DI,4DO,5E
                    [-1,  0,  3,  1,  2, -1],//0初始无输入或者只有BLANK的状态
                    [-1,  8, -1,  1,  4,  5],//1输入了数字之后的状态
                    [-1, -1, -1,  4, -1, -1],//2前面无数字，只输入了Dot的状态
                    [-1, -1, -1,  1,  2, -1],//3输入了符号状态
                    [-1,  8, -1,  4, -1,  5],//4前面有数字和有dot的状态
                    [-1, -1,  6,  7, -1, -1],//5'e' or 'E'输入后的状态
                    [-1, -1, -1,  7, -1, -1],//6输入e之后输入Sign的状态
                    [-1,  8, -1,  7, -1, -1],//7输入e后输入数字的状态
                    [-1,  8, -1, -1, -1, -1],//8前面有有效数输入之后，输入BLANK的状态
                ];
//        创造数字数组，用以判断输入的是否为数字
        var numPool = [Character]()
        for i in 0 ... 9 {
            numPool.append(Character(String(i)))
        }
//        创造各合法字符常量，用以比对
        let blank = Character(" ")
        let plus =  Character("+")
        let sub =  Character("-")
        let dot =  Character(".")
        let eEX =  Character("e")
        let EEX =  Character("E")
//        初始状态为无输入或者只有BLANK的状态
        var state = 0;
//        遍历字符串
        for ch in s {
            var input = InputType.INVALID;
            if(ch == blank){
                input = .BLANK
            }else if(ch == plus || ch == sub){
                input = .SIGN
            }else if(numPool.contains(ch)){
                input = .DIGIT
            }else if(ch == dot){
                input = .DOT
            }else if(ch == eEX || ch == EEX){
                input = .EXPONENT
            }
//            将当前当前状态和当前输入作为序号找到目标状态
            state = (transTable[state])[input.rawValue];
//            非法状态，即为非法字符串
            if (state == -1){ return false};
        }
//        最终状态只有为第1、4、7、8l种状态时，才是有效数字
        return state == 1 || state == 4 || state == 7 || state == 8;
    }
}
