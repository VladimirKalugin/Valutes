//
//  CalculatingViewController.swift
//  Valutes
//
//  Created by Fuhrer_SS on 13.10.2020.
//

import UIKit

class CalculatingViewController: UIViewController {
    
    
    
    @IBOutlet weak var firstValuteAmountTextField: UITextField!
    @IBOutlet weak var secondValuteAmountTextField: UITextField!
    
    @IBOutlet weak var firstValuteNameLabel: UILabel!
    @IBOutlet weak var secondValuteNameLabel: UILabel!
    
    var firstValute: Valute!
    var secondValute: Valute!
    
    var defaultValue = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstValuteAmountTextField.text = defaultValue
        countFirstValute()
    }
    
    @IBAction func firstUnwindSegue(_ segue: UIStoryboard) {
        
    }
    
    @IBAction func secondUnwindSegue(_ segue: UIStoryboard) {
//        guard let secondTableVC
//        secondValute =
    }
    
    
    private func countFirstValute() {
        if let firstTF = firstValuteAmountTextField.text {
            guard let amount = Double(firstTF) else { return }
            let firstValue = firstValute.value / Double(firstValute.nominal)
            let totalFirstValue = firstValue * amount
            
            let secondValue = secondValute.value / Double(secondValute.nominal)
            let totalSecondValue = totalFirstValue / secondValue
            secondValuteAmountTextField.text = String(format: "%.2f", totalSecondValue)
//                "\(totalSecondValue)"
        }
    }
    
    private func countSecondValute() {
        if let secondTF = secondValuteAmountTextField.text {
            guard let amount = Double(secondTF) else { return }
            let secondValue = secondValute.value / Double(secondValute.nominal)
            let totalSecondValue = secondValue * amount
            
            let firstValue = firstValute.value / Double(firstValute.nominal)
            let totalFirstValue = totalSecondValue / firstValue
            firstValuteAmountTextField.text = String(format: "%.2f", totalFirstValue)
        }
    }
    
    
}

// MARK: - TextFieldDelegate
extension CalculatingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstValuteAmountTextField:
            textField.resignFirstResponder()
            countFirstValute()
        case secondValuteAmountTextField:
            textField.resignFirstResponder()
            countSecondValute()
        default:
            break
        }
  
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
       
        // ДОРАБОТАТЬ ИНТЕРФЕЙС!!!
        
        if firstValuteAmountTextField.isSelected == false {
            countFirstValute()
        } else if secondValuteAmountTextField.isSelected == false {
            countSecondValute()
        }
    }
}
