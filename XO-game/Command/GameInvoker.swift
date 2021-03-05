//
//  GameInvoker.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameInvoker {
    
    static let shared = GameInvoker()
    private init() {}
    
    private weak var gameBoard: Gameboard?
    
    private var commands = [GameCommand]()
    
    func addGameCommand(command: GameCommand) {
        commands.append(command)
    }
    
    func execute() {
        var commandNumber = 0
        var countX = 0
        var countO = commands.count / 2
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if commandNumber % 2 == 0 {
                self.commands[countX].execite()
                countX += 1
            } else {
                self.commands[countO].execite()
                countO += 1
            }
            commandNumber += 1
            if commandNumber >= self.commands.count {
                timer.invalidate()
                self.commands[countO - 1].stop()
                self.commands.removeAll()
            }
        }
        timer.fire()
    }
    
}
