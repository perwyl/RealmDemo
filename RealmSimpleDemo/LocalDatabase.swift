//
//  Database.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import RealmSwift

class LocalDatabase {

    static let sharedInstance: LocalDatabase = {
        return LocalDatabase()
    }()

    func setDefaultRealm(for user: String) {
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\(user).realm")

        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config

        print("Realm Path: \(config.fileURL?.absoluteString)")
    }
}
