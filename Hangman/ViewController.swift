//
//  ViewController.swift
//  Hangman
//
//  Created by Nate Thompson on 1/2/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBOutlet var letterButtons: [CornerRadiusView]!
    
    override func viewWillAppear(_ animated: Bool) {
        updateWord()
    }
    
    @IBAction func letterButtonPressed(_ button: UIButton) {
        if button != lastButtonPressed {
            button.backgroundColor = .darkGray
        
            if lastButtonPressed != nil {
                lastButtonPressed?.backgroundColor = #colorLiteral(red: 0.7803230882, green: 0.7804364562, blue: 0.7802982926, alpha: 1)
            }
        
            lastButtonPressed = button
        }
    }
    
    func visibleCheck() -> Bool {
        for subview in wordStackView.arrangedSubviews {
            if let label = subview as? UILabel {
                if label.alpha == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    var lastButtonPressed: UIButton?
    
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        lastButtonPressed?.backgroundColor = #colorLiteral(red: 0.7803230882, green: 0.7804364562, blue: 0.7802982926, alpha: 1)
        var correct = false
        if let guess = lastButtonPressed?.titleLabel?.text {
            for subview in wordStackView.arrangedSubviews {
                if let label = subview as? UILabel {
                    if label.text == guess {
                        label.alpha = 1
                        correct = true
                    }
                }
            }
            if correct == false {
                wrongGuess()
            } else {
                lastButtonPressed?.backgroundColor = .black
                lastButtonPressed?.isEnabled = false
                lastButtonPressed = nil
            }
        }
        if visibleCheck() {
            win()
        } else {
            if imageNumber == 8 {
                lose()
            }
        }
    }
    
    
    func win() {
        updateWord()
        hangmanImage.image = #imageLiteral(resourceName: "hangman-1")
        imageNumber = 1
        for button in letterButtons {
            button.isEnabled = true
            button.backgroundColor = #colorLiteral(red: 0.7803230882, green: 0.7804364562, blue: 0.7802982926, alpha: 1)
        }
    }

    func lose() {
        updateWord()
        hangmanImage.image = #imageLiteral(resourceName: "hangman-1")
        imageNumber = 1
        for button in letterButtons {
            button.isEnabled = true
            button.backgroundColor = #colorLiteral(red: 0.7803230882, green: 0.7804364562, blue: 0.7802982926, alpha: 1)
        }
    }
    
    var imageNumber = 1
    
    func wrongGuess() {
        lastButtonPressed?.backgroundColor = .black
        lastButtonPressed?.isEnabled = false
        lastButtonPressed = nil
        
        imageNumber += 1
        hangmanImage.image = UIImage(named: "hangman-\(imageNumber)")
    }
    
    func updateWord() {
        let wordList = ["hangman", "apps", "carl"]
        
        let randomIndex = Int(arc4random_uniform(UInt32(wordList.count)))
        var word = (wordList[randomIndex])
        
        //remove existing labels
        for label in wordStackView.arrangedSubviews {
            label.removeFromSuperview()
        }
        
        for underline in underlineStackView.arrangedSubviews {
            underline.removeFromSuperview()
        }
        
        let characters = Array(word.characters)
        for character in characters {
            let label = UILabel()
            label.text = String(character)
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = .center
            label.alpha  = 0
            wordStackView.addArrangedSubview(label)
            
            label.widthAnchor.constraint(equalToConstant: 24).isActive = true
            label.layoutIfNeeded()
            
            let underline = UILabel()
            underline.text = "_"
            underline.font = UIFont.systemFont(ofSize: 45)
            underline.textAlignment = .center
            underlineStackView.addArrangedSubview(underline)
            
            underline.widthAnchor.constraint(equalToConstant: 24).isActive = true
            underline.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var wordStackView: UIStackView!
 
    @IBOutlet weak var underlineStackView: UIStackView!
    

}


@IBDesignable
class CornerRadiusView : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = -1
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
}
