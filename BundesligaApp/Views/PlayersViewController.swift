//
//  PlayersViewController.swift
//  BundesligaApp
//
//  Created by MACC on 2/1/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    
    var playersURL: String?
    var playersList: [PlayerObject] = []
    var firstCharacterArray: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let fetchURL = playersURL {
            
            let savedPlayersList = RealmHelper().loadPlayersList(fetchURL)
            
            if savedPlayersList.count > 0 {
                //there is saved players list for this team
                self.playersList = savedPlayersList
                self.prepareSections(savedPlayersList)
                DispatchQueue.main.async {self.playersTableView.reloadData()}
            } else {
                //no saved players for this team
                fetchTeamPlayers(url: fetchURL)
            }
            
        }
        
        
    }

    /**
     Fetching players list from api for selected team.
     */
    func fetchTeamPlayers(url: String) {
        let teamsURL = URL(string: url)!
        
        //show indicator
        Indicator().showActivityIndicator(uiView: self.view)
        
        Alamofire.request(teamsURL as URLConvertible).responseObject { (response: DataResponse<PlayersResponse>) in
            
            switch response.result {
            case .success(let playersResponse):
                if let playersList = playersResponse.players {
                    if playersList.count > 0 {
                        
                        //sort the array according to players names
                        let sortedPlayesrList = playersList.sorted(by: {$0.name! < $1.name!})
                        
                        //fill players list
                        self.playersList = sortedPlayesrList
                        
                        //devide into sections
                        self.prepareSections(sortedPlayesrList)
                        
                        //render result on table
                        DispatchQueue.main.async {
                            self.playersTableView.reloadData()
                        }

                        //store data
                        self.storePlayersData(playersList: sortedPlayesrList)
                        
                    } else {
                        //no players available for this team
                        
                    }
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
     Save fetched players list.
     */
    func storePlayersData(playersList: [PlayerObject]) {
        DispatchQueue.global(qos: .userInitiated).async {
            RealmHelper().storePlayersData(playersList, self.playersURL!)
        }
    }
    
    /**
     Prepare players list to be devided in the tableView.
     */
    func prepareSections (_ sortedPlayesrList: [PlayerObject]) {
        //fill players first character
        let charactersArray = sortedPlayesrList.map {$0.name!.first!}
        
        //remove repeated values
        let uniqueCharactersArray = Array(Set(charactersArray))
        
        //fill first character array
        self.firstCharacterArray = uniqueCharactersArray.sorted(by: {$0 < $1})
    }
    
    /**
     Goes back to team select view controller.
     */
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//MARK: Players table delegate and data source
extension PlayersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstCharacterArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let playersStartsWithSameLetters = playersList.filter {
            $0.name!.first! == self.firstCharacterArray[section]
        }
        return playersStartsWithSameLetters.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.text = String(firstCharacterArray[section])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "playersCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PlayersCell
        
        let playersStartsWithSameLetters = playersList.filter {
            $0.name!.first! == self.firstCharacterArray[indexPath.section]
        }
        
        cell.playerName.text = playersStartsWithSameLetters[indexPath.row].name!
        cell.playerPosition.text = playersStartsWithSameLetters[indexPath.row].position!
        
        return cell
    }
}

