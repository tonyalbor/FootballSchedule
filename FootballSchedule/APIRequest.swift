//
//  APIRequest.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

protocol APIRequest {
    var baseUrlString: String { get }
    var urlString: String { get }
    var headers: [String: String] { get }
}

extension APIRequest {
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: baseUrlString + urlString)!)
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
