//
//  DBUser.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import RealmSwift

class DBUser: Object {
    dynamic var name: String? = nil
    //dynamic var age = 0
    let age = RealmOptional<Int>()
    let favouriteRestaurants = List<DBRestaurant>()
}

class DBRestaurant: Object {
    dynamic var name: String? = nil
    dynamic var cuisineType: String? = nil
    let cost = RealmOptional<Int>()
    dynamic var aboutUs: String? = nil

    let listOfReviewers = List<Reviewer>()
}

class Reviewer: Object {
    dynamic var baseUser: DBUser? = nil
    let numOfReviews = RealmOptional<Int>()
}
