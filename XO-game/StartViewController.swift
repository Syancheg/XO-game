//
//  StartViewController.swift
//  XO-game
//
//  Created by Константин Кузнецов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

enum TypeGame: Int {
    case comp
    case man
    case game5
}

@available(iOS 13.0, *)
class StartViewController: UIViewController {

    @IBOutlet var startButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    private func setupButtons(){
        startButtons.forEach { (button) in
            button.backgroundColor = UIColor(red: 0.15, green: 0.87, blue: 0.51, alpha: 1.00)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        }
    }
    
    @objc private func startGame(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "GameViewController") as GameViewController
        controller.typeGame = TypeGame(rawValue: sender.tag)!
        self.present(controller, animated: true, completion: nil)
    }
}
