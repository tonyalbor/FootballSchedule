//
//  APIClient.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/13/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

struct APIClient<Response: Decodable> {
    
    let session = URLSession.shared
    
    func request(_ request: APIRequest, completion: @escaping (Result<Response>) -> Void) {
        let task = session.dataTask(with: request.asURLRequest()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(NSError(domain: "server error", code: 0, userInfo: nil)))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NSError(domain: "error response", code: 0, userInfo: nil)))
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}
