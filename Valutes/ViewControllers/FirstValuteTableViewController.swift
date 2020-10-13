//
//  FirstValuteTableViewController.swift
//  Valutes
//
//  Created by Fuhrer_SS on 13.10.2020.
//

import UIKit

class FirstValuteTableViewController: UITableViewController {

    // MARK: - Private Properties
    private var valutes = [String: Valute]()
    private var keys = [String]()
    private var lastCell: UITableViewCell?
    
    // MARK: - Public Properties
    var selectValute: Valute?
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.shared.fetchData { (valutes) in
            self.valutes = valutes.valute
            self.keys = Array(valutes.valute.keys).sorted(by: <)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - IBActions
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valutes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstValuteCell", for: indexPath)

        let key = keys[indexPath.row]
        let valute = valutes[key]
        cell.textLabel?.text = valute?.name
        cell.detailTextLabel?.text = valute?.charCode

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.isSelected == true {
            cell?.accessoryType = .checkmark
            lastCell?.accessoryType = .none
            selectValute = valutes[cell?.detailTextLabel?.text ?? "USD"]
            lastCell = cell
        } else {
            lastCell?.accessoryType = .none
            cell?.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
}
