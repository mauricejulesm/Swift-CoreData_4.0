//
//  CategoriesViewController.swift
//  ExpensesCoreData
//
//  Created by Shawn Moore on 11/9/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
	
	var categories : [Category] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()


		applicationDocumentsDirectory()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
			else { return }
		
		let context = appDelegate.persistentContainer.viewContext

		let fetchRequest : NSFetchRequest<Category> = Category.fetchRequest()
		
		// fetching
		do {
			categories = try context.fetch(fetchRequest)
			categoriesTableView.reloadData()
		} catch  {
			print("Unable to fetch categories")
		}
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destinationVC = segue.destination as? ExpensesViewController,
			let selectedRow = self.categoriesTableView.indexPathForSelectedRow?.row else{
				return
		}
		destinationVC.currentCategory = categories[selectedRow]
	}
	
	func deleteCategory(at indexPath: IndexPath) {
		let category = categories[indexPath.row]
		
		guard let context = category.managedObjectContext else {
			return
		}
		
		context.delete(category)
		
		do {
			try context.save()
			categories.remove(at: indexPath.row)
			categoriesTableView.deleteRows(at: [indexPath], with: .automatic)
		} catch  {
			print("Unable to delete the category")
			categoriesTableView.reloadRows(at: [indexPath], with: .automatic)
		}
		
	}

	
	// getting the file path of the sqlite file
	func applicationDocumentsDirectory() {
		if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
			print(url.absoluteString)
		}
	}

}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
		let category = categories[indexPath.row]
		cell.textLabel?.text = category.title
		
        return cell
    }
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			deleteCategory(at: indexPath)
		}
	}
}
