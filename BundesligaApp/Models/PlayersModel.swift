//
//  PlayersModel.swift
//  BundesligaApp
//
//  Created by MACC on 2/2/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import ObjectMapper

class PlayersResponse: NSObject, Mappable {
    
    var _links: PlayersResponseLinksObject?
    var count: Int?
    var players: [PlayerObject]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        _links      <- map["_links"]
        count       <- map["count"]
        players     <- map["players"]
    }
    
}
///////////////////////////////////////////////////////
class PlayersResponseLinksObject: NSObject, Mappable {
    var selfLink: LinkObject?
    var teamLink: LinkObject?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        selfLink                <- map["self"]
        teamLink                <- map["team"]
    }
    
}
///////////////////////////////////////////////////////
class PlayerObject: NSObject, Mappable {
    var name: String?
    var position: String?
    var jerseyNumber: String?
    var dateOfBirth: String?
    var nationality: String?
    var contractUntil: String?
    var marketValue: Double?
    
    init(name: String?,
         position: String?,
         jerseyNumber: String?,
         dateOfBirth: String?,
         nationality: String?,
         contractUntil: String?,
         marketValue: Double?) {
        
        self.name = name
        self.position = position
        self.jerseyNumber = jerseyNumber
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.contractUntil = contractUntil
        self.marketValue = marketValue
    }
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        name                <- map["name"]
        position            <- map["position"]
        jerseyNumber        <- map["jerseyNumber"]
        dateOfBirth         <- map["dateOfBirth"]
        nationality         <- map["nationality"]
        contractUntil       <- map["contractUntil"]
        marketValue         <- map["marketValue"]
    }
    
}
///////////////////////////////////////////////////////
