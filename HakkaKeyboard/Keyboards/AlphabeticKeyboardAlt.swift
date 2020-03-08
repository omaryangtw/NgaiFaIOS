//
//  AlphabeticKeyboardAlt.swift
//  HakkaKeyboard
//
//  Created by Yang Omar on 2020/3/8.
//  Copyright © 2020 Yang Omar. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks an English alphabetic keyboard.
 */
struct AlphabeticKeyboardAlt: DemoKeyboard {
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = AlphabeticKeyboardAlt.actions(
            uppercased: uppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension AlphabeticKeyboardAlt {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows
            .from(characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static let characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ṳ"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    static func characters(uppercased: Bool) -> [[String]] {
        uppercased ? characters.uppercased() : characters
    }
    
    static var switchAction: KeyboardAction {
        .switchToKeyboard(.numeric)
    }
    
    static var switchInput: KeyboardAction {
        .switchToKeyboard(.alphabetic(uppercased: false))
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(uppercased ? .shiftDown : .shift, at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
}
