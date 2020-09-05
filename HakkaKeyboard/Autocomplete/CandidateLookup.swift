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
            if( userDefaults!.bool(forKey: "Hant")==true){
            candidates.append(suggestions[i].hanji)
            }else{
                if( userDefaults!.bool(forKey: "POJ") == true){
                    candidates.append(suggestions[i].poj + " ")
                }else{
                    candidates.append(suggestions[i].tailo + " ")
                }
            }
        }
        candidates = Array(Set(candidates))
        candidates=candidates.sorted { (a, b) -> Bool in
            return a.count < b.count
        }
        return candidates
    }

    fileprivate func convert(input:String)->String{
        return input
    }
    
    fileprivate func query(input:String)->[ImeDict8]{
        
        let inputFix = input
        let predicate: NSPredicate?
        if inputFix.containsNumbers(){
            if( userDefaults!.bool(forKey: "POJ") == true){
                predicate = NSPredicate(format: "pojInputWithNumberTone BEGINSWITH[c] %@", inputFix)
            }else{
                predicate = NSPredicate(format: "tailoInputWithNumberTone BEGINSWITH[c] %@", inputFix)
            }

        } else {
            if( userDefaults!.bool(forKey: "POJ") == true){
            predicate = NSPredicate(format: "pojInputWithoutTone BEGINSWITH[c] %@ OR pojShortInput BEGINSWITH[c] %@", inputFix, inputFix)
            }else{
            predicate = NSPredicate(format: "tailoInputWithNumberTone BEGINSWITH[c] %@", inputFix)
            }

        }
        
        let realmResults = RealmDatabaseLoader.getBundledRealm().objects(ImeDict8.self).filter(predicate!).sorted(byKeyPath: "wordLength", ascending: true)
        var unmanagedResults = [ImeDict8]()
        
        for result in realmResults{
            unmanagedResults.append(result.detached())
        }
        let limitedSizeResults = Array(unmanagedResults.prefix(25))
        
        return checkShiftedInput(inputFix, limitedSizeResults)

    }
    
    fileprivate func checkShiftedInput(_ input: String, _ results: [ImeDict8]) -> [ImeDict8] {
        // handle caps with shiftStatus
        let firstCharString = input.prefix(1)
        if firstCharString.uppercased() != firstCharString {
            return results
        }
        
        for result: ImeDict8 in results {
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
