//
//  LoadingViewController.swift
//  Valutes
//
//  Created by Fuhrer_SS on 11.10.2020.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var fetchDataActivityIndicator: UIActivityIndicatorView!
    
    var valutes = [String: Valute]()
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataActivityIndicator.startAnimating()
        
        DataManager.shared.fetchData { (valutes) in
            self.valutes = valutes.valute
            self.valutes["RUB"] = Valute(charCode: "RUB", nominal: 1, name: "Российский рубль", value: 1)
            DispatchQueue.main.async {
                self.fetchDataActivityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "showCountVC", sender: nil)
            }
        }
    }

    // MARK: - Navigations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let calculatingVC = segue.destination as? CalculatingViewController else { return }
        let defaultFistValute = "USD"
        let defaultSecondValute = "RUB"
        
        calculatingVC.defaultValue = "1"
        
        calculatingVC.firstValute = valutes[defaultFistValute]
        calculatingVC.secondValute = valutes[defaultSecondValute]
    }

}

