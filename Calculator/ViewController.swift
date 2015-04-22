//
//  ViewController.swift
//  Calculator
//
//  Created by Michael Nipper on 4/15/15.
//  Copyright (c) 2015 Michael Nipper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userHasPressedButton = false
    var brain = CalculatorBrain()
    
    @IBAction func enter() {
        userHasPressedButton = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func numberButton(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userHasPressedButton {
            display.text = display.text! + digit
        } else {
             display.text = digit
             userHasPressedButton = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userHasPressedButton {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userHasPressedButton = false
        }
    }
}

