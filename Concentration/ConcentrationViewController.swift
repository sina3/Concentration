//
//  ViewController.swift
//  Concentration
//
//  Created by Sina on 2021-03-05.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    
    // Initialize Game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return visibleCardButtons.count / 2
    }
    
    // Flips Counter
    private var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ?  "Flips\n\(flipCount)" : "Flips: \(flipCount)",
            attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    // Load Emoji array with Emojis from the theme
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    // IB Outlets & Actions
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter{ !$0.superview!.isHidden }
            
    }
    
    @IBAction private func resetGame(_ sender: UIButton) {
        resetGame()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
            flipCount += 1
        if let cardNumber = visibleCardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else {
            print("Chosen Card was not in visibleCardButtons")
        }
            
    }
    
    private func resetGame() {
        game.cards = game.reshuffle(unshuffledCards: game.cards)
        for index in visibleCardButtons.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            emoji[game.cards[index]] = nil
            
        }
        emojiChoices = theme ?? ""
                        
        flipCount = 0
        
    }
    
    private func updateViewFromModel() {
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var emojiChoices = "👻👿🎃💀🙀🧙‍♂️🧛‍♀️"

    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil , emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))

        }

        return emoji[card] ?? "?"
    }

}


extension Int {
    var arc4random: Int {
        var randNum: Int
        if self > 0 {
            randNum = Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            randNum = -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            randNum = 0
        }

        return randNum
    }
}
