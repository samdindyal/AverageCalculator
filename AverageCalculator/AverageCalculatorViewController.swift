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
        // Dialog for entering a new number
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
