
import Foundation
import CoreData

class List: NSManagedObject
{

    class func createInManagedObjectContext(moc: NSManagedObjectContext, item: String, location: Int, amount: Int) -> List
    {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: moc) as! List
    
        newItem.item = item
        newItem.location = location
        newItem.amount = amount
    
        return newItem
    
    }

}
