
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
 
    var list = [List]()
    var a = "a"
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "Grocery List"
        
        if let moc: NSManagedObjectContext = self.managedObjectContext
        {
            
            let items: [(String, Int, Int)] = []
            
            for (item, location, amount) in items
            {

                List.createInManagedObjectContext(moc, item: item, location: location, amount: amount)
            
            }
            
        }
        
        fetchList()
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return list.count
    
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")
        
        cell?.textLabel?.text = list[indexPath.row].item
        cell!.textLabel?.font = UIFont(name: "Times New Roman", size: 30)
        cell!.detailTextLabel?.font = UIFont(name: "Times New Roman", size: 20)
        
        return cell!
        
    
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        
        return true
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if(editingStyle == .Delete )
        {
            
            let listItemToDelete = list[indexPath.row]
            
            managedObjectContext.deleteObject(listItemToDelete)
            
            self.fetchList()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            save()
            
        }
        
    }
    
    func fetchList()
    {
        
        let fetchRequest = NSFetchRequest(entityName: "List")
        let sortDescriptor = NSSortDescriptor(key: "item", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do
        {
            
            if let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [List]
            {
                
                list = fetchResults
            
            }
        
        }
        catch
        {
        
        }
        
    }
    
    func saveNewItem(item : String, amount: Int!)
    {

        let newItem = List.createInManagedObjectContext(self.managedObjectContext, item: item, location: 1, amount: amount)

        self.fetchList()

        if let newItemIndex: Int! = list.indexOf(newItem)
        {

            let newItemIndexPath = NSIndexPath(forRow: newItemIndex!, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([newItemIndexPath], withRowAnimation: .Automatic)
            
            save()
        
        }
    
    }
    
    func save()
    {
 
        do
        {
            
            try managedObjectContext.save()
            
        }
        catch
        {
            
        }
        
    }
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
   
        let alert = UIAlertController(title: "Add an Item", message: nil, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.placeholder = "Item"})
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.placeholder = "Amount"})
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action) -> Void in
            
            let textField = alert.textFields![0]
            let textFieldTwo = alert.textFields![1]

            self.saveNewItem(textField.text!, amount: Int(textFieldTwo.text!)!)
            
            self.tableView.reloadData()
            
        }))
        
        tableView.reloadData()
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}
