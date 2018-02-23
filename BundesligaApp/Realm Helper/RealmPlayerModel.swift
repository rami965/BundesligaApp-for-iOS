//
//  RealmPlayerModel.swift
//  BundesligaApp
//
//  Created by MACC on 2/3/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerRealmObject: Object {
    @objc dynamic var name: String?
    @objc dynamic var position: String?
    @objc dynamic var jerseyNumber: String?
    @objc dynamic var dateOfBirth: String?
    @objc dynamic var nationality: String?
    @objc dynamic var contractUntil: String?
    var marketValue: Double?
}

class PlayerRealmList: Object {
    @objc dynamic var playersURL: String?
    var playersList = List<PlayerRealmObject>()
}
