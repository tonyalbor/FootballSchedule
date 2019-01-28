//
//  ScorersViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScorersViewController: UIViewController {
    
    let scorers: ScorersAPI
    
    init(scorers: ScorersAPI) {
        self.scorers = scorers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scorers.getScorers(competitionCode: "PL") { (result) in
            switch result {
            case let .success(noice):
                print(noice)
            case let .failure(error):
                print(error)
            }
        }
    }
}
