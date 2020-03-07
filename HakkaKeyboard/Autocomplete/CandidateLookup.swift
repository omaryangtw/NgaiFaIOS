//
//  CandidateLookup.swift
//  HakkaKeyboard
//
//  Created by Yang Omar on 2020/3/6.
//  Copyright © 2020 Yang Omar. All rights reserved.
//

import Foundation
import RealmSwift

class CandidateLookup{
    
    let input:String=""
    
     func candidateLookup(input : String)-> [String] {
        //let unicodeCandidate:String
        
        //unicodeCandidate = convert(input:input)
        
        let suggestions = query(input: input)
        var candidates:[String] = Array<String>()
        for i in suggestions.indices{
            candidates.append(suggestions[i].hanji)
        }

        return candidates
    }

    fileprivate func convert(input:String)->String{
        return input
    }
    
    fileprivate func query(input:String)->[ImeDict]{
        
        let inputFix = input.replacingOccurrences(of: "1", with: "")
        let predicate: NSPredicate?
        if inputFix.containsNumbers(){
            predicate = NSPredicate(format: "pojInputWithNumberTone BEGINSWITH[c] %@", inputFix)

        } else {
            predicate = NSPredicate(format: "pojInputWithoutTone BEGINSWITH[c] %@ OR pojShortInput BEGINSWITH[c] %@", inputFix, inputFix)

        }
        
        let realmResults = RealmDatabaseLoader.getBundledRealm().objects(ImeDict.self).filter(predicate!).sorted(byKeyPath: "lomajiCharLength", ascending: true)
        var unmanagedResults = [ImeDict]()
        
        for result in realmResults{
            unmanagedResults.append(result.detached())
        }
        let limitedSizeResults = Array(unmanagedResults.prefix(25))
        
        return checkShiftedInput(inputFix, limitedSizeResults)

    }
    
    fileprivate func checkShiftedInput(_ input: String, _ results: [ImeDict]) -> [ImeDict] {
        // handle caps with shiftStatus
        let firstCharString = input.prefix(1)
        if firstCharString.uppercased() != firstCharString {
            return results
        }
        
        for result: ImeDict in results {
            if input.uppercased() == input {
                    result.poj = result.poj.uppercased()
                continue
            }
            if firstCharString.uppercased() == firstCharString {
                    result.poj = result.poj.prefix(1).uppercased() + result.poj.suffix(result.poj.count - 1)
            }
        }
        
        return results
    }
}
