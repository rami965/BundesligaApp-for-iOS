//
//  RealmHelper.swift
//  BundesligaApp
//
//  Created by MACC on 2/3/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper: NSObject {
    func storeTeamsData(_ teamsList: [TeamObject]) {
        
        let list = TeamRealmList()
        
        let realm = try! Realm()
        
        try! realm.write {
            for team in teamsList {
                let tmp = TeamRealmObject()
                tmp.selfLink = team._links?.selfLink?.href
                tmp.fixturesLink = team._links?.fixturesLink?.href
                tmp.playersLink = team._links?.playersLink?.href
                tmp.name = team.name
                tmp.code = team.code
                tmp.shortName = team.shortName
                tmp.squadMarketValue = team.squadMarketValue
                tmp.crestUrl = team.crestUrl
                
                list.teamsList.append(tmp)
            }
            
        }
        
        try! realm.write {
            realm.add(list)
            print("Teams added successfully")
        }

    }
    ///////////////////////////////////////////////////////
    func storePlayersData(_ playersList: [PlayerObject],
                          _ playersURL: String) {
        
        let list = PlayerRealmList()
        
        let realm = try! Realm()
        try! realm.write {
            for player in playersList {
                let tmp = PlayerRealmObject()
                tmp.name = player.name
                tmp.position = player.position
                tmp.jerseyNumber = player.jerseyNumber
                tmp.dateOfBirth = player.dateOfBirth
                tmp.nationality = player.nationality
                tmp.contractUntil = player.contractUntil
                tmp.marketValue = player.marketValue
                
                list.playersList.append(tmp)
            }
            
            //unique for each team
            list.playersURL = playersURL
        }
        
        
        try! realm.write {
            realm.add(list)
            print("Players saved successfully")
        }
        
    }
    ///////////////////////////////////////////////////////
    func loadTeamsList() -> [TeamObject] {
        let realm = try! Realm()
        let list = realm.objects(TeamRealmList.self)
        
        var teamsList: [TeamObject] = []
        
        if list.count > 0 {
            let savedList = list[0]
            
            for team in savedList.teamsList {
                let selfLink = LinkObject(url: team.selfLink)
                let fixturesLink = LinkObject(url: team.fixturesLink)
                let playersLink = LinkObject(url: team.playersLink)
                
                let teamLinks = TeamLinksObject(selfLink: selfLink,
                                                fixturesLink: fixturesLink,
                                                playersLink: playersLink)
                
                let tmp = TeamObject(_links: teamLinks)
                tmp.name = team.name
                tmp.code = team.code
                tmp.shortName = team.shortName
                tmp.squadMarketValue = team.squadMarketValue
                tmp.crestUrl = team.crestUrl
                
                teamsList.append(tmp)
            }
        }
        
        return teamsList
    }
    ///////////////////////////////////////////////////////
    func loadPlayersList(_ playersURL: String) -> [PlayerObject] {
        let realm = try! Realm()
        let list = realm.objects(PlayerRealmList.self).filter("playersURL = %@", playersURL)
        print("Players Found: ", list.count)
        var playersList: [PlayerObject] = []
        
        if list.count > 0 {
            
            let savedList = list[0]
            
            for player in savedList.playersList {
                let tmp = PlayerObject(name: player.name,
                                       position: player.position,
                                       jerseyNumber: player.jerseyNumber,
                                       dateOfBirth: player.dateOfBirth,
                                       nationality: player.nationality,
                                       contractUntil: player.contractUntil,
                                       marketValue: player.marketValue)
                
                playersList.append(tmp)
            }
            
        }
        
        return playersList
    }
}
