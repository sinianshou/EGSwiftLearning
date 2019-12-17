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
                        print(el)
            var sInd : Int = el[0] as! Int
            let pInd : Int = el[1] as! Int
            var cType : MatchType = el[2] as! MatchType
            var unfinished = false
            for pElInd in pInd ..< pArr.count {
                if sInd > sArr.count {
                    unfinished = true
                    break
                }
                let  pEl = pArr[pElInd]
                cType = status[cType.rawValue][self.charType(pEl)]
                
                switch cType {
                case .Single:
                    //                    print("Single")
                    if pEl == Character("?"){
                        sInd+=1
                    }else if pEl.isLetter{
                        if sInd >= sArr.count || pEl != sArr[sInd]  {
                            unfinished = true
                        }else{
                            sInd+=1
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
                if cType == MatchType.Split || unfinished {
                    cType = MatchType.Single
                    break
                }
            }
            if !unfinished {
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
}
