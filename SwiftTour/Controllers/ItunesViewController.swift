//
//  ItunesViewController.swift
//  SwiftTour
//
//  Created by Fatih Nayebi on 2014-06-08.
//  Copyright (c) 2014 Fatih Nayebi. All rights reserved.
//

import UIKit

class ItunesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoreProtocol {
  
  @IBOutlet var appsTableView : UITableView?
  var tableData: NSArray = NSArray()
  var itunesStore:ItunesStore = ItunesStore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    itunesStore.delegate = self
    itunesStore.searchItunesFor("Sherpa Solutions");
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
  // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
    
    let rowData: NSDictionary = self.tableData[indexPath.row] as! NSDictionary
    
    cell.textLabel?.text = rowData["trackName"] as? String
    
    // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
    let urlString: NSString = rowData["artworkUrl60"] as! NSString
    let imgURL: NSURL = NSURL(string: urlString as String)!
    
    // Download an NSData representation of the image at the URL
    let imgData: NSData = NSData(contentsOfURL: imgURL)!
    cell.imageView?.image = UIImage(data: imgData)
    
    // Get the formatted price string for display in the subtitle
    let formattedPrice: NSString = rowData["formattedPrice"] as! NSString
    
    cell.detailTextLabel?.text = formattedPrice as String
    
    return cell
  }
  
  func storePreparedData(results: NSDictionary) {
    // Store the results in our table data array
    if results.count>0 {
      self.tableData = results["results"] as! NSArray
      self.appsTableView?.reloadData()
    }
  }
  
}