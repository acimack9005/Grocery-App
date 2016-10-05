//
//  Directory+CoreDataProperties.swift
//  MyApp
//
//  Created by apcsp on 9/30/16.
//  Copyright © 2016 apcsp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Directory {

    @NSManaged var categories: String?
    @NSManaged var aisle: NSNumber?

}
