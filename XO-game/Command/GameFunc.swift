//
//  GameFunc.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

func Turn(gamer: Player, position: GameboardPosition, gameBordView: GameboardView, gameViewController: GameViewController) {
    let command = GameCommand(gamer: gamer, position: position, gameBordView: gameBordView, gameViewController: gameViewController)
    GameInvoker.shared.addGameCommand(command: command)
}

func Run(){
    GameInvoker.shared.execute()
}
