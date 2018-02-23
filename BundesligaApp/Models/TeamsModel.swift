//
//  TeamsModel.swift
//  BundesligaApp
//
//  Created by MACC on 2/1/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import ObjectMapper

class TeamsResponse: NSObject, Mappable {
    
    var _links: ResponseLinksObject?
    var count: Int?
    var teams: [TeamObject]?

    required init?(map: Map){}
    
    func mapping(map: Map) {
        _links      <- map["_links"]
        count       <- map["count"]
        teams       <- map["teams"]
    }
    
}
///////////////////////////////////////////////////////
class ResponseLinksObject: NSObject, Mappable {
    var selfLink: LinkObject?
    var competitionLink: LinkObject?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        selfLink                <- map["self"]
        competitionLink         <- map["competition"]
    }
    
}
///////////////////////////////////////////////////////
class TeamObject: NSObject, Mappable {
    var _links: TeamLinksObject?
    var name: String?
    var code: String?
    var shortName: String?
    var squadMarketValue: String?
    var crestUrl: String?
    
    required init?(map: Map){}
    
    init(_links: TeamLinksObject?) {
        self._links = _links
    }
    
    func mapping(map: Map) {
        _links              <- map["_links"]
        name                <- map["name"]
        code                <- map["code"]
        shortName           <- map["shortName"]
        squadMarketValue    <- map["squadMarketValue"]
        crestUrl            <- map["crestUrl"]
    }
    
}
///////////////////////////////////////////////////////
class TeamLinksObject: NSObject, Mappable {
    var selfLink: LinkObject?
    var fixturesLink: LinkObject?
    var playersLink: LinkObject?
    
    init(selfLink: LinkObject?, fixturesLink: LinkObject?, playersLink: LinkObject?) {
        self.selfLink = selfLink
        self.fixturesLink = fixturesLink
        self.playersLink = playersLink
    }
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        selfLink            <- map["self"]
        fixturesLink        <- map["fixtures"]
        playersLink         <- map["players"]
    }
    
}
///////////////////////////////////////////////////////
class LinkObject: NSObject, Mappable {
    var href: String?
    
    init(url: String?) {
        self.href = url
    }
    
    required init?(map: Map){}

    func mapping(map: Map) {
        href      <- map["href"]
    }
    
}
