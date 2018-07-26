//
//  AverageCalculatorViewController.swift
//  AverageCalculator
//
//  Created by Sam Dindyal on 2018-07-25.
//  Copyright © 2018 Sam Dindyal. All rights reserved.
//

import UIKit

class AverageCalculatorViewController: UITableViewController {
    
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var numberOfItemsLabel: UILabel!
    
    @IBAction func addNumber(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Number", message: "Enter a number.", preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) -> Void in
            textField.placeholder = "Number"
            textField.keyboardType = .decimalPad
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
    
    func calculateAverage() -> Bool {
        if numbers.isEmpty {
            return false
        } else {
            let sum = numbers.reduce(0,{$0 + $1})
            self.average = sum / Float(numbers.count)
            return true
        }
    }
    
    func updateLabels() {
        if calculateAverage() {
            averageLabel.text = "\(self.average)"
            numberOfItemsLabel.text = "\(numbers.count) ITEM\(numbers.count == 1 ? "" : "S")"
        } else {
            averageLabel.text = "???"
            numberOfItemsLabel.text = "??? ITEMS"
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
}
