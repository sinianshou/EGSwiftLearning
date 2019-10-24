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

        enum InputType : Int {
           case INVALID = 0    // 0 Include: Alphas, '(', '&' ans so on
           case SPACE = 1  // 1 " "
           case SIGN = 2   // 2 '+','-'
           case DIGIT = 3  // 3 numbers
           case DOT = 4    // 4 '.'
           case EXPONENT = 5   // 5 'e' 'E'
       }
        
        let transTable : [[Int]] = [
                //0INVA,1SPA,2SIG,3DI,4DO,5E
                    [-1,  0,  3,  1,  2, -1],//0初始无输入或者只有space的状态
                    [-1,  8, -1,  1,  4,  5],//1输入了数字之后的状态
                    [-1, -1, -1,  4, -1, -1],//2前面无数字，只输入了Dot的状态
                    [-1, -1, -1,  1,  2, -1],//3输入了符号状态
                    [-1,  8, -1,  4, -1,  5],//4前面有数字和有dot的状态
                    [-1, -1,  6,  7, -1, -1],//5'e' or 'E'输入后的状态
                    [-1, -1, -1,  7, -1, -1],//6输入e之后输入Sign的状态
                    [-1,  8, -1,  7, -1, -1],//7输入e后输入数字的状态
                    [-1,  8, -1, -1, -1, -1],//8前面有有效数输入之后，输入space的状态
                ];
        var numPool = [Character]()
        for i in 0 ... 9 {
            numPool.append(Character(String(i)))
        }
        let blank = Character(" ")
        let plus =  Character("+")
        let sub =  Character("-")
        let dot =  Character(".")
        let eSym =  Character("e")
        let ESym =  Character("E")
        
        var state = 0;
        for ch in s {
            var input = InputType.INVALID;
            if(ch == blank){
                input = .SPACE
            }else if(ch == plus || ch == sub){
                input = .SIGN
            }else if(numPool.contains(ch)){
                input = .DIGIT
            }else if(ch == dot){
                input = .DOT
            }else if(ch == eSym || ch == ESym){
                input = .EXPONENT
            }
            state = (transTable[state])[input.rawValue];
            if (state == -1){ return false};
        }
        return state == 1 || state == 4 || state == 7 || state == 8;
    }
}
