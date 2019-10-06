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
}
