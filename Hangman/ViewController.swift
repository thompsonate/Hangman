//
//  ViewController.swift
//  Hangman
//
//  Created by Nate Thompson on 1/2/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


@IBDesignable
class CornerRadiusView : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = -1
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
}
