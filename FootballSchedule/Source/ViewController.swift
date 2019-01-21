//
//  ViewController.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/13/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let client = APIClient<EPLStandingsResponse>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client.request(EPLStandingsRequest()) { (result) in
            switch result {
            case let .success(standings):
                print(standings)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
