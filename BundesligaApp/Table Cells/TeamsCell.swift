//
//  TeamsCell.swift
//  BundesligaApp
//
//  Created by MACC on 2/3/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import UIKit
import SwiftSVG

class TeamsCell: UITableViewCell {
    @IBOutlet weak var teamLogo: UIView!
    @IBOutlet weak var teamName: UILabel!
    
    func downloadImage(withURL url: String?) {
        if let imageURLString = url, let imageURL = URL(string: imageURLString) {
            DispatchQueue.global(qos: .userInitiated).async {
                let _ = UIView.init(SVGURL: imageURL) {(svgLayer) in
                    svgLayer.resizeToFit(self.teamLogo.bounds)
                    
                    DispatchQueue.main.async {
                        self.teamLogo.layer.sublayers = nil
                        self.teamLogo.layer.addSublayer(svgLayer)
                    }
                }
            }
        }
    }
}
