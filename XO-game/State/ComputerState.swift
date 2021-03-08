//
//  ComputerState.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class ComputerState: GameState {
    
    var isMoveCompleted: Bool = false
    
    public let comp: Player
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(comp: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.comp = comp
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch comp {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at _: GameboardPosition) {
        guard let gameBoardView = gameBoardView else {
            return
        }
        
        let positions: [GameboardPosition] = [
            GameboardPosition.init(column: 1, row: 1),
            GameboardPosition.init(column: 0, row: 0),
            GameboardPosition.init(column: 2, row: 0),
            GameboardPosition.init(column: 0, row: 2),
            GameboardPosition.init(column: 2, row: 2)
        ]
    
        positions.forEach { (position) in
            if !isMoveCompleted {
                if gameBoardView.canPlaceMarkView(at: position) {
                    Log(action: .playerSetMark(player: comp, position: position))
                    gameBoard?.setPlayer(comp, at: position)
                    gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
                    isMoveCompleted = true
                }
            }
        }
    }
}
