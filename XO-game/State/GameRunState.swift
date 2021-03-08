//
//  GameRunState.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameRunState: GameState {
    
    
    var isMoveCompleted = false
    
    private weak var gameViewController: GameViewController?
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    func begin() {
        gameViewController?.winnerLabel.text = "Идет игра!"
        gameViewController?.winnerLabel.isHidden = false
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        Run()
    }

    func addMark(at position: GameboardPosition) {}
    
}
