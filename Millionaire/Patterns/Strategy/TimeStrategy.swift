//
//  TimeStrategy.swift
//  Millionaire
//
//  Created by Maksim Romanov on 02.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class TimeStrategy {
    func getCountdownDuration() -> Int {
        guard let difficulty = Game.shared.gameSession?.difficulty else { return 1 }
        switch difficulty {
        case .easy:
            return 60
        case .medium:
            return 30
        case .hard:
            return 20
        case .insane:
            return 10
        }
        
    }
}
