//
//  InterfaceController.swift
//  FootballScheduleWatch Extension
//
//  Created by Tony Albor on 3/17/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation
import WatchKit

class InterfaceController: WKInterfaceController {

    @IBOutlet private weak var table: WKInterfaceTable!
    
    private let standingsAPI = StandingsAPI()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        standingsAPI.getTable { [weak self] result in
            switch result {
            case let .success(standings):
                DispatchQueue.main.async { [weak self] in
                    self?.loadData(standings: standings)
                }
            case .failure:
                break
            }
        }
    }
    
    private func loadData(standings: [Standing]) {
        table.setNumberOfRows(standings.count, withRowType: "StandingRowController")
        for i in 0..<table.numberOfRows {
            if let row = table.rowController(at: i) as? StandingRowController {
                let standing = standings[i]
                // TOOD: add assets to watch app
//                row.logo.setImage(teamLogos[standing.team.id]?.asUIImage())
                row.team.setText(shortTeamNames[standing.team.id])
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
