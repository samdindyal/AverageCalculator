//
//  AverageCalculatorViewController.swift
//  AverageCalculator
//
//  Created by Sam Dindyal on 2018-07-25.
//  Copyright © 2018 Sam Dindyal. All rights reserved.
//

import UIKit

class AverageCalculatorViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var numberOfItemsLabel: UILabel!
    
    @IBAction func addNumber(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Number", message: "Enter a number:", preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) -> Void in
            textField.placeholder = "Number"
            textField.keyboardType = .decimalPad
            textField.delegate = self
        }
        
        let addNumberAction = UIAlertAction(title: "Add", style: .default) {
            (action) in
            if let text = alertController.textFields?.first?.text!,
                let number = Float(text),
                !number.isNaN {
                self.numbers.append(number)
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                self.updateLabels()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addNumberAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    var numbers:[Float] = []
    var average:Float = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func calculateAverage() {
        if numbers.isEmpty {
            self.average = 0.0
        } else {
            let sum = numbers.reduce(0,{$0 + $1})
            self.average = sum / Float(numbers.count)
        }
    }
    
    func updateLabels() {
        calculateAverage()
        if self.average.isNaN{
            averageLabel.text = "???"
            numberOfItemsLabel.text = "??? ITEMS"
        } else {
            averageLabel.text = "\(self.average)"
            numberOfItemsLabel.text = "\(numbers.count) ITEM\(numbers.count == 1 ? "" : "S")"
        }
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        let number = numbers[indexPath.row]
        
        cell.textLabel?.text = "\(number)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numbers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            updateLabels()
            
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let existingTextHasSeparator = textField.text?.range(of: ".")
        let replacementTextHasSeparator = string.range(of: ".")
        
        return existingTextHasSeparator == nil || replacementTextHasSeparator == nil
    }
}
