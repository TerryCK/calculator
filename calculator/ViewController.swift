//
//  ViewController.swift
//  calculator
//
//  Created by 陳 冠禎 on 2017/5/25.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleTyping = false
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set { display.text = String(newValue)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleTyping = false
        }
        
        if let mathematicalSymobol = sender.currentTitle {
            
            brain.performOperation(mathematicalSymobol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction func buttonPress(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleTyping {
            let textCurrenttlyInDisplay = display!.text!
            display.text = textCurrenttlyInDisplay + digit
            print("\(digit) be touched")
            
        } else {
            display.text = digit
            userIsInTheMiddleTyping = true
        }
        
    }
    
}

