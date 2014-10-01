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
    
    var places: [[String:String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = [["name" : "Peter B", "address" : "1401 Park Ave"]]
        
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.rowHeight = 107
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as PlaceCell
        
        var place = places[indexPath.row]
        cell.nameLabel.text = place["name"]
        cell.address.text = place["address"]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

