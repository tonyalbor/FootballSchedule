//
//  Result.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
