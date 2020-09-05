//
//  KeyboardViewController+Autocomplete.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func requestAutocompleteSuggestions() {
        let word = textDocumentProxy.currentWord ?? ""
        autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] in
            self?.handleAutocompleteSuggestionsResult($0)
        }
    }
    
    func resetAutocompleteSuggestions() {
        autocompleteToolbar.reset()
    }
}

private extension KeyboardViewController {
    
    func handleAutocompleteSuggestionsResult(_ result: AutocompleteResult) {
        autocompleteToolbar.enableScrolling()
  autocompleteToolbar.stackView.removeConstraints(autocompleteToolbar.stackView.constraints)
        let a = autocompleteToolbar.stackView.widthAnchor.constraint(equalToConstant: CGFloat(width()))
        NSLayoutConstraint.activate([a])
        switch result {
        case .failure(let error): print(error.localizedDescription)
        case .success(let result): autocompleteToolbar.update(with: result)
        }
    }
    func width() -> Int {
        let word = textDocumentProxy.currentWord ?? ""
        let ins = CandidateLookup()
        var mul:Int = 0
        if(userDefaults!.bool(forKey: "Hant")==false){
            mul = 15
        }else{
            mul = 50
        }
        
        var len = 0
        let can = ins.candidateLookup(input: word)
        can.forEach{ (str) in
            len += str.count
        }
        return len * mul
    }
}
