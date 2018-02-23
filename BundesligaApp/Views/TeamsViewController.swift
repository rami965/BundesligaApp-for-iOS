//
//  TeamsViewController.swift
//  BundesligaApp
//
//  Created by MACC on 2/1/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftSVG
import RealmSwift

class TeamsViewController: UIViewController {
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    let token = "65256eb3d7214b85aa8be8475e55eebe"
    let competitionNumber = "457"
    
    var teamsList: [TeamObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //load saved teams list
        let savedTeamsList = RealmHelper().loadTeamsList()
        
        //check if there is saved teams list
        if  savedTeamsList.count > 0 {
            teamsList = savedTeamsList
            DispatchQueue.main.async {self.teamsTableView.reloadData()}
        } else {
            fetchTeamsList()
        }

    }
    
    /**
     Fetching teams list from api.
     */
    func fetchTeamsList() {
        let teamsURL = URL(string: "\(BASE_URL)\(API_VERSION)\(COMPETITION_ROUTE)\(competitionNumber)/\(TEAMS_ROUTE)")!
        
        //show indicator
        Indicator().showActivityIndicator(uiView: self.view)
        
        Alamofire.request(teamsURL as URLConvertible, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-Auth-Token": token]).responseObject { (response: DataResponse<TeamsResponse>) in
            
            switch response.result {
            case .success(let teamsResponse):
                if let teamsList = teamsResponse.teams, teamsList.count > 0 {
                    self.teamsList = teamsList
                    
                    //render result on table
                    DispatchQueue.main.async {
                        self.teamsTableView.reloadData()
                    }
                    
                    //store data
                    self.storeTeamsData(teamsList: teamsList)
                }
            case .failure(let error):
                print("Error:", error.localizedDescription)
                Utils.showAlert(title: "Error", message: error.localizedDescription, vc: self)
            }
            
            //hide indicator
            Indicator().hideActivityIndicator(uiView: self.view)
            
        }
    }
    
    /**
     Save fetched teams list.
     */
    func storeTeamsData(teamsList: [TeamObject]) {
        DispatchQueue.global(qos: .userInitiated).async {
            RealmHelper().storeTeamsData(teamsList)
        }
    }
    
}
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//MARK: Teams table delegate and data source
extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teamsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: 320, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "teamsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TeamsCell
        
        cell.teamName.text = teamsList[indexPath.section].name!
        
        cell.downloadImage(withURL: teamsList[indexPath.section].crestUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playersViewController = storyboard.instantiateViewController(withIdentifier: "playersViewController") as! PlayersViewController
        playersViewController.playersURL = teamsList[indexPath.section]._links?.playersLink?.href
        self.present(playersViewController, animated: true)
    }
}
