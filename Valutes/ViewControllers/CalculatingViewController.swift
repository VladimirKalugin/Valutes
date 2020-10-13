//
//  CalculatingViewController.swift
//  Valutes
//
//  Created by Fuhrer_SS on 13.10.2020.
//

import UIKit

class CalculatingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstValuteAmountTextField: UITextField!
    @IBOutlet weak var secondValuteAmountTextField: UITextField!
    
    @IBOutlet weak var firstValuteNameLabel: UILabel!
    @IBOutlet weak var secondValuteNameLabel: UILabel!
    
    // MARK: - Public Properties
    var firstValute: Valute!
    var secondValute: Valute!
    
    var defaultValue = "1"
    
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        firstValuteAmountTextField.text = defaultValue
        countFirstValute()
    }
    
    // MARK: - IBActions
    @IBAction func firstUnwindSegue(_ segue: UIStoryboardSegue) {
        guard let firstTableVC = segue.source as? FirstValuteTableViewController else { return }
        firstValute = firstTableVC.selectValute
        firstValuteNameLabel.text = firstValute.charCode
        countFirstValute()
    }
    
    @IBAction func secondUnwindSegue(_ segue: UIStoryboardSegue) {
        guard let secondTableVC = segue.source as? SecondValuteTableViewController else { return }
        secondValute = secondTableVC.selectValute
        secondValuteNameLabel.text = secondValute.charCode
        countSecondValute()
    }
    
    // MARK: - Private Methods
    private func countFirstValute() {
        if let firstTF = firstValuteAmountTextField.text {
            guard let amount = Double(firstTF) else { return }
            let firstValue = firstValute.value / Double(firstValute.nominal)
            let totalFirstValue = firstValue * amount
            
            let secondValue = secondValute.value / Double(secondValute.nominal)
            let totalSecondValue = totalFirstValue / secondValue
            secondValuteAmountTextField.text = String(format: "%.2f", totalSecondValue)
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

        countFirstValute()
        view.endEditing(true)
    }
}
