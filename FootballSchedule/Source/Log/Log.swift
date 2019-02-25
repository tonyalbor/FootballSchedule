//
//  Log.swift
//  FootballSchedule
//
//  Created by Tony Albor on 2/24/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

enum Log {
    static func debug(_ message: String) {
        print("Debug: \(message)")
    }
    static func verbose(_ message: String) {
        print("Verbose: \(message)")
    }
    static func warning(_ message: String, error: Error? = nil) {
        print("Warning: \(message)")
        if let error = error {
            print(error)
        }
    }
    static func error(_ message: String, error: Error? = nil) {
        print("Error: \(message)")
        if let error = error {
            print(error)
        }
    }
}
