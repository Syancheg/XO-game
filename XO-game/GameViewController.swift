//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    var typeGame: TypeGame = .man
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    private let steps = 5
    private var countStep = 1
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                if self.typeGame != .game5 {
                    self.counter += 1
                }
                self.setNextState(by: position)
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(action: .restartGame)
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
    }

    private func setFirstState() {
        counter = 0
        let player = Player.first
        if typeGame == .game5 {
            currentState = PlayerTurnState(player: player, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        } else {
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        }
        
    }
    
    func checkingForWin() -> Bool{
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self)
            return true
        }
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self)
            return true
        }
        return false
    }
    
    private func setNextState(by position: GameboardPosition? = nil) {
        switch typeGame {
        case .comp:
            if !checkingForWin(){
                if let compInputState = currentState as? ComputerState{
                    let player = compInputState.comp.next
                    currentState = PlayerState(player: player, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
                } else if let playerInputState = currentState as? PlayerState {
                    let comp = playerInputState.player.next
                    currentState = ComputerState(comp: comp, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: comp.markViewPrototype)
                    counter += 1
                    currentState.addMark(at: GameboardPosition(column: 0, row: 0))
                    setNextState()
                }
            }
        case .man:
            if !checkingForWin() {
                if let compInputState = currentState as? PlayerState {
                    let player = compInputState.player.next
                    currentState = PlayerState(player: player, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
                }
            }
        case .game5:
            if let playerInputState = self.currentState as? PlayerTurnState,
                  let position = position {
                let player = playerInputState.player
                Turn(gamer: player, position: position, gameBordView: self.gameboardView, gameViewController: self)
            }
            if countStep == steps {
                guard let playerInputState = self.currentState as? PlayerTurnState else {
                    return
                }
                let player = playerInputState.player.next
                currentState = PlayerTurnState(player: player, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
            }
            if countStep >= steps * 2 {
                currentState = GameRunState(gameViewController: self)
                countStep = 1
            } else {
                countStep += 1
            }
            
        }
        
    }
    
}
