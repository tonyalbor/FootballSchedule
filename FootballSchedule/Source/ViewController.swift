//
//  ViewController.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/13/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let client = APIClient<EPLScheduleResponse>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client.request(EPLScheduleRequest(matchday: 23)) { (result) in
            switch result {
            case let .success(schedule):
                print(schedule)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
