//
//  FirstViewModel.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import RealmSwift

class FirstViewModel {

    func updateColor(with colorField: DBColorField) {
        // Get the default Realm
        let realm = try! Realm()

        try! realm.write {
            realm.create(DBColor.self , value: colorField.toJSON(), update: true)
        }
    }

    func updateColor(with color: DBColor) {
        // Get the default Realm
        let realm = try! Realm()

        try! realm.write {
            realm.add(color, update: true)
        }
    }

    func getColor() -> DBColor? {
        let realm = try! Realm()

        let results = realm.object(ofType: DBColor.self, forPrimaryKey: 1)

        return results
    }

    func updateColor(with JSON: [String: Any]) {

    }
}
