//
//  AlgorithmManager+WildcardMatching.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/16.
//  Copyright © 2019 Easer. All rights reserved.
//
enum MatchType : Int {
    case Single=0
    case RangePlus=1
    case Range=2
    case Split=3
}
extension AlgorithmManager {
    func wildcardMatchingChecker(_ s: String, p: String) -> Bool {
        let sArr = s.map({$0})
        let pArr = p.map({$0})
        //Single,RangePlus,Range   *,?,letter
        let status = [
            [MatchType.Range, MatchType.Single, MatchType.Single],
            [MatchType.Range, MatchType.RangePlus, MatchType.Split],
            [MatchType.Range, MatchType.RangePlus, MatchType.Split]
        ]
        var container = [[0,0,MatchType.Single]]
        while container.count != 0 {
            let el = container.first!
            //            print(el)
            var sInd : Int = el[0] as! Int
            let pInd : Int = el[1] as! Int
            var cType : MatchType = el[2] as! MatchType
            var unmatch = false
            for pElInd in pInd ..< pArr.count {
                let  pEl = pArr[pElInd]
                if sInd >= sArr.count {
                    if pEl == "*" {
                        continue
                    }else{
                        unmatch = true
                        break
                    }
                }
                cType = status[cType.rawValue][self.charType(pEl)]
                
                switch cType {
                case .Single:
                    //                    print("Single")
                    if pEl == Character("?"){
                        sInd+=1
                    }else if pEl.isLetter{
                        if pEl == sArr[sInd]  {
                            sInd+=1
                        }else{
                            unmatch = true
                        }
                    }
                case .Range: break
                //                    print("range")
                case .Split:
                    //                    print("Split")
                    for index in sInd ..< sArr.count {
                        
                        //                        print("Split", pEl == sArr[index], pEl , sArr[index])
                        if pEl == sArr[index] {
                            container.append([index,pElInd,MatchType.Single])
                        }
                    }
                case .RangePlus:
                    //                    print("RangePlus")
                    sInd+=1
                }
                if cType == MatchType.Split || unmatch {
                    cType = MatchType.Single
                    break
                }
            }
            if !unmatch {
                if sInd == s.count {
                    return true
                }else if (sInd <= s.count && (cType == .Range || cType == .RangePlus)){
                    return true
                }
            }
            container.removeFirst()
        }
        return false
    }
    func charType(_ ch:Character) -> Int {
        
        if ch == Character("*"){
            return 0
        }else if ch == Character("?"){
            return 1
        }else if ch.isLetter{
            return 2
        }
        return -1
    }
    
    
    func wildcardMatchingChecker1(_ s: String, p: String) -> Bool {
        //将字符串转为字符数组
        let sArr = s.map({$0})
        let pArr = p.map({$0})
        //声明*和？
        let star = Character("*")
        let qMark = Character("?")
        //i记录s中字符位置，j记录p中字符位置，waitingMatchI记录*匹配后s中待匹配字符位置，starJ记录*在p中位置
        var i = 0
        var j = 0
        var waitingMatchI = -1
        var starJ = -1
        //开始循环
        while i < sArr.count {
            //如果j有效，且s、p对应字符相同，或者p对应字符为？，则匹配成功，i、j均+1
            if (j < pArr.count && (sArr[i] == pArr[j] || pArr[j] == qMark)) {
                i += 1
                j += 1
            //匹配失败，如果j有效，并且p对应字符为*，starJ记录*位置j，j+=1,waitingMatchI记录s中待*匹配字符位置i
            }else if(j < pArr.count && pArr[j] == star){
                starJ = j
                j += 1
                waitingMatchI = i
            //匹配失败且p对应字符不为*，若starJ != -1，表明之前有*匹配
            //将j重置回starJ + 1，waitingMatchI字符视为被*匹配，将waitingMatchI+1，i重置为waitingMatchI
            }else if (starJ != -1){
                j = starJ + 1
                waitingMatchI += 1
                i = waitingMatchI
            //匹配失败，p对应字符不为*，之前没有*匹配，则匹配彻底失败
            }else{
                return false
            }
        }
        //s匹配结束后，如果p仍有剩余字符，遍历是否均为*
        while (j < pArr.count && pArr[j] == star) {
            j += 1
        }
        //若j走到了p的最后，则匹配成功，否则匹配失败
        return j == pArr.count
    }
}
