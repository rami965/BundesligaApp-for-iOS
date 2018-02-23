//
//  RealmTeamModel.swift
//  BundesligaApp
//
//  Created by MACC on 2/3/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import RealmSwift

class TeamRealmObject: Object {
    //@objc dynamic var _links: RealmTeamLinksObject?
    @objc dynamic var selfLink: String?
    @objc dynamic var fixturesLink: String?
    @objc dynamic var playersLink: String?
    @objc dynamic var name: String?
    @objc dynamic var code: String?
    @objc dynamic var shortName: String?
    @objc dynamic var squadMarketValue: String?
    @objc dynamic var crestUrl: String?
}

class TeamRealmList: Object {
    var teamsList = List<TeamRealmObject>()
}
///////////////////////////////////////////////////////

