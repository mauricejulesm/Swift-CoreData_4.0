//
//  Category+CoreDataProperties.swift
//  CategoricalExpenses
//
//  Created by falcon on 10/6/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawExpenses: NSOrderedSet?

}

// MARK: Generated accessors for expenses
extension Category {

    @objc(insertObject:inExpensesAtIndex:)
    @NSManaged public func insertIntoExpenses(_ value: Expense, at idx: Int)

    @objc(removeObjectFromExpensesAtIndex:)
    @NSManaged public func removeFromExpenses(at idx: Int)

    @objc(insertExpenses:atIndexes:)
    @NSManaged public func insertIntoExpenses(_ values: [Expense], at indexes: NSIndexSet)

    @objc(removeExpensesAtIndexes:)
    @NSManaged public func removeFromExpenses(at indexes: NSIndexSet)

    @objc(replaceObjectInExpensesAtIndex:withObject:)
    @NSManaged public func replaceExpenses(at idx: Int, with value: Expense)

    @objc(replaceExpensesAtIndexes:withExpenses:)
    @NSManaged public func replaceExpenses(at indexes: NSIndexSet, with values: [Expense])

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSOrderedSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSOrderedSet)

}
