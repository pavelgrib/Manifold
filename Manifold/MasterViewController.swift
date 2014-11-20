
import UIKit
import CoreLocation
import MapKit


class MasterViewController: UITableViewController, CLLocationManagerDelegate {

  var locationMgr : CLLocationManager?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .Authorized:
        initLocationMgr(startImmediately: true)
      case .AuthorizedWhenInUse:
        initLocationMgr(startImmediately: true)
      case .Denied:
        displayAlert("not determined", msg: "location services not enabled in app")
      case .NotDetermined:
        initLocationMgr(startImmediately: false)
        if let manager = self.locationMgr {
          manager.requestWhenInUseAuthorization()
        }
      case .Restricted:
        displayAlert("Restricted", msg: "location services not enabled in app")
      }
    } else {
      println("location services not enabled")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func insertNewObject(sender: AnyObject) {
    
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow() {
//        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
//        (segue.destinationViewController as DetailViewController).detailItem = object
        }
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return self.fetchedResultsController.sections?.count ?? 0
    return 0
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
//    return sectionInfo.numberOfObjects
    return 0
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
//        let context = self.fetchedResultsController.managedObjectContext
//        context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
      
//        var error: NSError? = nil
//        if !context.save(&error) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //println("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
    }
  }

  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
//    let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
//    cell.textLabel.text = object.valueForKey("timeStamp")!.description
  }
  
  // MARK: - Location
  
  func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
    println("lat \(newLocation.coordinate.latitude) and lon \(newLocation.coordinate.longitude)")
  }
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    switch CLLocationManager.authorizationStatus() {
    case .Authorized:
      println("authorized")
    case .AuthorizedWhenInUse:
      println("authorize when used")
    case .NotDetermined:
      println("not determined")
    case .Restricted:
      println("Restricted")
    default:
      println("unhandled")
    }
  }
  
  func displayAlert(title: String, msg: String) {
    let controller = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
    controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
  }
  
  func initLocationMgr(#startImmediately: Bool) {
    locationMgr = CLLocationManager()
    if let manager = locationMgr {
      println("created location mgr")
      manager.delegate = self
      if startImmediately {
        manager.startUpdatingLocation()
      }
    }
  }

}

