//
//  ResultViewController.swift
//  Rokk3rShop
//
//  Created by Konstantin Efimenko on 3/15/16.
//  Copyright © 2016 Kostiantyn Iefymenko. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewController, SearchControllerDelegate {
    
    var searchString: String?
    let searchController = SearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        searchController.search(searchString!)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return searchController.sectionsNumber()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.rowsNumber(section)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchController.headerForSection(section)
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        cell.textLabel?.text = searchController.titleForRow(inIndexPath: indexPath)
        

        return cell
    }
    

    func onSearchingComplete() {
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
