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
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userHasPressedButton = false
        operandStack.append(displayValue)
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
        let operation = sender.currentTitle!
        if userHasPressedButton {
            enter()
        }
        switch operation {
        case "x": performOperation { $0 * $1 }
        case "/": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "sq": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
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

