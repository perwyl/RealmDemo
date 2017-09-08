//
//  DBColor.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct DBColorField: Mappable {
    var red: Int?
    var blue: Int?
    var green: Int?
    var id = 1

    init?(map: Map) {}

    init(red: Int?, blue: Int?, green: Int?) {
        self.red = red
        self.blue = blue
        self.green = green
    }

    // use to generate JSON objects
    mutating func mapping(map: Map) {
        red <- map["red"]
        blue <- map["blue"]
        green <- map["green"]
        id <- map["id"]
    }
}

class DBColor: Object {
    dynamic var red = 0
    dynamic var blue = 0
    dynamic var green = 0

    dynamic var id = 1

    override static func primaryKey() -> String? {
        return "id"
    }
}

