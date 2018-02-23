//
//  NetworkManager.swift
//  BundesligaApp
//
//  Created by MACC on 2/1/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var manager: SessionManager!
    
    init(requestTimeout : Double) {
        manager = self.getAlamofireManager(timeout: requestTimeout)
    }
    
    func getAlamofireManager(timeout : Double) -> SessionManager  {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = timeout
        configuration.timeoutIntervalForRequest = timeout
        let alamofireManager = Alamofire.SessionManager(configuration: configuration)
        return alamofireManager
    }
    
}
