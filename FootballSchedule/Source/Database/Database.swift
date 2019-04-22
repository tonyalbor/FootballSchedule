//
//  Database.swift
//  FootballSchedule
//
//  Created by Tony Albor on 2/24/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

final class Database<Record: Codable> {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    
    func save(record: Record, key: String) {
        do {
            let data = try encoder.encode(record)
            defaults.set(data, forKey: key)
            Log.verbose("Database save success for type (\(String(describing: Record.self)))")
        } catch let error {
            Log.warning("Database save error for type (\(String(describing: Record.self)))", error: error)
        }
    }
    
    func get(key: String) -> Record? {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        do {
            let record = try decoder.decode(Record.self, from: data)
            Log.verbose("Database read success for type (\(String(describing: Record.self)))")
            return record
        } catch let error {
            Log.warning("Database read error for type (\(String(describing: Record.self)))", error: error)
            return nil
        }
    }

    func delete(key: String) {
        defaults.removeObject(forKey: key)
    }
}
