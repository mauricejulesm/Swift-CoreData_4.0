//
//  ExpensesViewController.swift
//  Expenses
//
//  Created by Shawn Moore on 11/6/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {

    @IBOutlet weak var expensesTableView: UITableView!
    
    let dateFormatter = DateFormatter()
	
	var currentCategory : Category?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long

    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.expensesTableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewExpense(_ sender: Any) {
        performSegue(withIdentifier: "showExpense", sender: self)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destinationVC = segue.destination as? NewExpenseViewController else {
			return
		}
		destinationVC.category = currentCategory
	}
	
	
	func deleteExpense(at indexPath: IndexPath) {
		guard let expense = currentCategory?.expenses?[indexPath.row],
			let context = expense.managedObjectContext else {
			return
		}
		
		context.delete(expense)
		
		do {
			try context.save()
			//categories.remove(at: indexPath.row)
			expensesTableView.deleteRows(at: [indexPath], with: .automatic)
		} catch  {
			print("Unable to delete the category")
			expensesTableView.reloadRows(at: [indexPath], with: .automatic)
		}
		
	}
}

extension ExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCategory?.expenses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
		
		if let expense = currentCategory?.expenses?[indexPath.row]{
			cell.textLabel?.text = expense.name
			if let date = expense.date {
				cell.detailTextLabel?.text = dateFormatter.string(from: date)
			}
		}
		
        return cell
    }
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			deleteExpense(at: indexPath)
		}
	}
	
}

extension ExpensesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showExpense", sender: self)
    }
}


