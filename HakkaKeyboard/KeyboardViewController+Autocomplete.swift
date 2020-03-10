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
        var mul:Double = 1.0
        switch word.count {
        case 1:mul = 0.8
        case 2:mul = 0.9
        case 3:mul = 1.5
        case 4:mul = 1.6
        default:
            mul = 1.8
        }
        
        
        return ins.candidateLookup(input: word).count*Int((60*mul))
    }
}
