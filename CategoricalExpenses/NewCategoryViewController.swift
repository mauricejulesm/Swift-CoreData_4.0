//
//  NewCategoryViewController.swift
//  ExpensesCoreData
//
//  Created by Shawn Moore on 11/9/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func saveCategory(_ sender: Any) {
		let title = titleTextField.text
		
		if title == "" {
			print("Category title can't be empty! Try again.")
			return
		}
		
		let newCategory = Category(title: title ?? "No Category")
		
		do {
			try newCategory?.managedObjectContext?.save()
			print("Saved category: \(title!) successfully")
			self.navigationController?.popViewController(animated: true)
		} catch {
			print("Unable to save the new category \(title!)")
		}
    }
}

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
