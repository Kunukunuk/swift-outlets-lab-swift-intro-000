//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func greenButton(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        finishedClicking()
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        finishedClicking()
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        finishedClicking()
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        finishedClicking()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    func finishedClicking(){
        if (buttonsClicked == simonSaysGame.numberOfColorsToMatch) {
            winLabel.isHidden = false
            if (simonSaysGame.chosenColors == simonSaysGame.patternToMatch) {
                winLabel.text = "You Won!"
            } else {
                winLabel.text = "You Lost!"
            }
        }

    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
