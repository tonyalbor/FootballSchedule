//
//  ScheduleAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

class ScheduleAPI {
    
    private let api = APIClient<EPLScheduleResponse>()
    private(set) var matches = [Match]()
    
    func getMatches(completion: @escaping (Result<[Match]>) -> Void) {
        let request = EPLScheduleRequest(matchday: 23) // todo: paginate; matchday param
        api.request(request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.matches = response.matches
                completion(.success(response.matches))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
