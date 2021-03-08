//
//  GameCommand.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameCommand {
    
    let gamer: Player
    let position: GameboardPosition
    let gameBordView: GameboardView
    let gameViewController: GameViewController
    
    init(gamer: Player, position: GameboardPosition, gameBordView: GameboardView, gameViewController: GameViewController) {
        self.gamer = gamer
        self.position = position
        self.gameBordView = gameBordView
        self.gameViewController = gameViewController
    }
    
    func execite(){
        if (!gameBordView.canPlaceMarkView(at: position)) {
            gameBordView.removeMarkView(at: position)
        }
        gameBordView.placeMarkView(gamer.markViewPrototype, at: position)
        Log(action: .playerSetMark(player: gamer, position: position))
    }
    
    func stop(){
        _ = gameViewController.checkingForWin()
    }
    
}
