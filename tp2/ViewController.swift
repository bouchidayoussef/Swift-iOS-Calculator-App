//
//  ViewController.swift
//  tp2
//
//  Created by Youssef Bouchida on 07/02/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myInputDisplayLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!

    var myStack = StackRPN()

    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var line4: UILabel!
    @IBOutlet weak var line5: UILabel!


    func displayStack() {
        line1.text = myStack.getElementWith(aShift: 0)?.stringValue ?? ""
        line2.text = myStack.getElementWith(aShift: 1)?.stringValue ?? ""
        line3.text = myStack.getElementWith(aShift: 2)?.stringValue ?? ""
        line4.text = myStack.getElementWith(aShift: 3)?.stringValue ?? ""
        line5.text = myStack.getElementWith(aShift: 4)?.stringValue ?? ""
        
    }

    
    @IBAction func clickPoint(sender: AnyObject) {
        if let currentText = myInputDisplayLabel.text, !currentText.contains(".") {
            myInputDisplayLabel.text = "\(currentText)."
        }
    }

    @IBAction func clickMul(sender: UIButton) {
        performOperation { $0 * $1 }
    }

    @IBAction func clickDiv(sender: UIButton) {
        performOperation { $1 / $0 }
    }

    @IBAction func clickMinus(sender: UIButton) {
        performOperation { $1 - $0 }
    }

    @IBAction func clickAdd(sender: UIButton) {
        print("Add button pressed")
        performOperation { $0 + $1 }
        
    }

    @IBAction func clickDrop(sender: UIButton) {
        _ = myStack.pop()
        displayStack()
        
    }
    
    @IBAction func clickSqrt(sender: UIButton) {
        pushInputToStack()  // Make sure this is the first line in the method
        
        guard let operand = myStack.pop()?.doubleValue else {
            displayError("Not enough operands for square root.")
            return
        }
        
        // Now operand should be 81.0 if that's what was pushed onto the stack
        print("Operand for sqrt: \(operand)") // Debug print
        
        if operand < 0 {
            displayError("Cannot take square root of a negative number.")
            return
        }
        
        let result = sqrt(operand)
        myStack.push(aNumber: NSNumber(value: result))
        displayStack()
        clearError()
}

    @IBAction func clickCos(sender: UIButton) {
        pushInputToStack()
        
        guard let operand = myStack.pop()?.doubleValue else {
            displayError("Not enough operands for cosine.")
            return
        }
        
        let result = cos(operand)
        myStack.push(aNumber: NSNumber(value: result))
        displayStack()
        clearError()
    }

    @IBAction func clickSin(sender: UIButton) {
        pushInputToStack()
        
        guard let operand = myStack.pop()?.doubleValue else {
            displayError("Not enough operands for sine.")
            return
        }
        
        let result = sin(operand)
        myStack.push(aNumber: NSNumber(value: result))
        displayStack()
        clearError()
    }

    @IBAction func clickPower(sender: UIButton) {
        pushInputToStack()
        
        guard let exponent = myStack.pop()?.doubleValue,
              let base = myStack.pop()?.doubleValue else {
            displayError("Not enough operands for power.")
            return
        }
        
        let result = pow(base, exponent)
        myStack.push(aNumber: NSNumber(value: result))
        displayStack()
        clearError()
    }

    private func pushInputToStack() {
        if let text = myInputDisplayLabel.text, !text.isEmpty, let number = NumberFormatter().number(from: text) {
            myStack.push(aNumber: number)
            myInputDisplayLabel.text = ""
        }
    }


    @IBAction func clickEnter(sender: AnyObject) {
        if let text = myInputDisplayLabel.text, !text.isEmpty, text != "inputLabel5", let number = NumberFormatter().number(from: text) {
            myStack.push(aNumber: number)
            print("Pushed \(number) onto the stack")
            myInputDisplayLabel.text = ""  // Clear the input label after pushing the number onto the stack
            displayStack()
        } else {
            print("Failed to convert \(myInputDisplayLabel.text ?? "") to a number")
        }
    }

    @IBAction func clickDigit(sender: AnyObject) {
        if let button = sender as? UIButton {
            // If the current display is just a result of an operation, start a new entry.
            if myInputDisplayLabel.text == "0" || myInputDisplayLabel.text == "" {
                myInputDisplayLabel.text = "\(button.tag)"
            } else {
                myInputDisplayLabel.text = "\(myInputDisplayLabel.text ?? "")\(button.tag)"
            }
        }
    }

    @IBAction func clickSwap(sender: UIButton) {
        guard let firstOperand = myStack.pop(),
              let secondOperand = myStack.pop() else {
            displayError("Not enough operands to swap.")
            return
        }
        
        myStack.push(aNumber: firstOperand)
        myStack.push(aNumber: secondOperand)
        displayStack()
        clearError()
    }

    
    private func performOperation(_ operation: (Double, Double) -> Double) {
        guard let firstOperand = myStack.pop()?.doubleValue,
              let secondOperand = myStack.pop()?.doubleValue else {
            showAlert(message: "Not enough operands.")
            return
        }
        
        let result = operation(firstOperand, secondOperand)
        myStack.push(aNumber: NSNumber(value: result))
        displayStack()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func clearError() {
        errorLabel.isHidden = true
    }

    // Call `clearError()` in each of your IBAction methods to ensure the error message is cleared when the user takes the next action.



}

