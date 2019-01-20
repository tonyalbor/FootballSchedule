//
//  FootballDataRequest.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

protocol FootballDataRequest: APIRequest {}

extension FootballDataRequest {
    var baseUrlString: String { return "http://api.football-data.org/v2/" }
}

struct EPLScheduleRequest: FootballDataRequest {

    let matchday: Int

    var urlString: String { return "competitions/PL/matches/?matchday=\(matchday)" }

    let headers: [String : String] = ["X-Auth-Token": FootballDataAuthToken.app]
}
