//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import Foundation
/**
 This demo autocomplete suggestion provider just returns the
 current word suffixed with "ly", "er" and "ter".
 */
class DemoAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {

    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        let suffixes = ["ly", "er", "ter"]
        let suggestions = suffixes.map { text + $0 }
        //let ins = CandidateLookup()
        //let suggestions = ins.candidateLookup(input: text)
        completion(.success(suggestions))
    }
    
    @available(*, deprecated, renamed: "autocompleteSuggestions(for:completion:)")
    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        autocompleteSuggestions(for: text, completion: completion)
    }
}
