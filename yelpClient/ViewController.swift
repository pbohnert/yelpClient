//
//  ViewController.swift
//  yelpClient
//
//  Created by Peter Bohnert on 10/1/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var client: YelpClient!
    
    //var places: [[String:String]]!
     var places: [NSDictionary] = []
    
    // my Yelp keys
    let yelpConsumerKey = "WxM1ynG7wdd032qyipfagQ"
    let yelpConsumerSecret = "8lrED6F1gWOb1XSwr3FfkSbeNX8"
    let yelpToken = "J89lj9umCgqWyfByF6E6QsoTEZA01ejv"
    let yelpTokenSecret = "Q82qHm43iwDe-2ECP6du7NplfRk"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            println(response.count)
            self.places = response["businesses"] as! [NSDictionary]
            //println(self.places)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        

  //      places = [["name" : "Peter B", "address" : "1401 Park Ave"]]
        
          tableView.delegate = self
          tableView.dataSource = self
       // tableView.rowHeight = 107
            self.tableView.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("places.count = \(places.count)")
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell")as! PlaceCell
        
        self.client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            println(response.count)
            self.places = response["businesses"] as! [NSDictionary]
            println(self.places)
            
            //name, address, ratings (count),
            var place = self.places[indexPath.row]
            println("am I even getting here?")
            
            var location = place["location"] as! NSDictionary
            cell.address.text = location["display_address"] as? String
            cell.nameLabel.text = place["name"] as? String
            var reviewCount = place["review_count"] as! Int
            cell.reviews.text = "\(reviewCount)"
            
            tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        //set image here as well, for placeImage.
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

