//
//  RealmDatabaseLoader.swift
//  HakkaKeyboard
//
//  Created by Yang Omar on 2020/3/6.
//  Copyright © 2020 Yang Omar. All rights reserved.
//


import Foundation
import RealmSwift

public class RealmDatabaseLoader {
    
    public static func getBundledRealm() -> Realm {
        
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "ime_dict_8", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
        
        return realm
    }
}
