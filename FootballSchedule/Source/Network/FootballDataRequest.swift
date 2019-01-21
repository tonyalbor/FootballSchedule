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
    
    var headers: [String : String] {
        return ["X-Auth-Token": FootballDataAuthToken.app]
    }
}
