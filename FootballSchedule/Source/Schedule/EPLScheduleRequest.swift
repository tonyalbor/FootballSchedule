//
//  EPLScheduleRequest.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

struct EPLScheduleRequest: FootballDataRequest {
    
    let matchday: Int
    
    var urlString: String { return "competitions/PL/matches/?matchday=\(matchday)" }
    
    let headers: [String : String] = ["X-Auth-Token": FootballDataAuthToken.app]
}
