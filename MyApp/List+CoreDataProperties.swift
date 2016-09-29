//
//  List+CoreDataProperties.swift
//  MyApp
//
//  Created by apcsp on 9/26/16.
//  Copyright © 2016 apcsp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension List {

    @NSManaged var item: String?
    @NSManaged var location: NSNumber?
    @NSManaged var amount: NSNumber?

}
