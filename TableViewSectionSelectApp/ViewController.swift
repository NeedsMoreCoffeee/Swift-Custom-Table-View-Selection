//
//  ViewController.swift
//  TableViewSectionSelectApp
//
//  Created by  NeedsMoreCoffee 
//

import UIKit


// this is a reference to our apps.
struct ListApp{
    var name: String
    var isActive = false
    
}


// creates a table view with custom headers.
class ViewController: UIViewController {


    // our table view that holds our menu items
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    // the id for our menu cell
    private let cellID = "menuViewCellID"
    
    // the id for our menu titel cell
    private let headerViewCellID = "headerViewCellID"

    // the list of apps we want on our menu
    var apps: [ListApp] = [ ListApp(name: "Instagram"),
                            ListApp(name: "FaceBook"),
                            ListApp(name: "Twitter"),
                            ListApp(name: "YouTube"),
                            ListApp(name: "Snapchat"),
                            ListApp(name: "TikTok"),
                            ListApp(name: "WhatsApp"),
                            ListApp(name: "Twitch"),
                            ListApp(name: "Reddit"),
                            ListApp(name: "Mail")]
  
    
    // used to calculate where our split in the table view should go (acitve apps list) -> splitTitleView -> (inactive apps)
    private var inactiveSplitIndex = 1 // must be set to 1 by default.


    override func viewDidLoad() {
        super.viewDidLoad()
        // set up our table view
        setUpViews()
        

     
    }

    // this function sorts our apps list into those that are active first, then figures out where to split our list.
    private func sortAppsList(){
        
        // sorts by which apps are active
        apps.sort{ $0.isActive && !$1.isActive}
        
        // determin where our split is by finding our first instance of a false app
        for (index, app) in apps.enumerated() {
            if app.isActive == false{
                inactiveSplitIndex = index + 1 // +1 because we take our headerView at index 0 into account
                return
            }
            
            // if none of our apps are false, set our inactive apps split title view to the end of our table view
            inactiveSplitIndex = apps.count + 1
        }
    }

}


// MARK: Delegates and Protocols
extension ViewController:  UITableViewDelegate, UITableViewDataSource{
  
    // how many cells our table should have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the amount in our apps list + 2 for our 2 headerviews
        return apps.count + 2
    }
    
    // the height for our cells. Can be used to custom set our headers height at index.row 0 and at indexPath.row == inactiveSplitIndex
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if the beginning of our list, or split, set the cell to our header cell
        if indexPath.row == 0 || indexPath.row ==  inactiveSplitIndex {
            let customHeaderCell = tableView.dequeueReusableCell(withIdentifier: headerViewCellID, for: indexPath) as! CustomHeaderCell
            // remove higlighting on cell tap
            customHeaderCell.selectionStyle = .none
            
            // determine the title
            let title = indexPath.row == 0 ? "ACTIVE" : "APPS"
            
            // set the title name
            customHeaderCell.setTitle(title: title)
            
            // return our custom header cell
            return customHeaderCell
           }
           else {
               // else all other cells is our menuTable cell that holds our app information
               let appsCell =  tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MenuTableCell
               
               // remove higlighting on cell tap
               appsCell.selectionStyle = .none
               
               // if the indexPath is greater than our splitIndex, we grab from our apps array list accordingly.
               let index =  indexPath.row > inactiveSplitIndex ? indexPath.row - 2 : indexPath.row - 1
               
               // set our apps labels
               appsCell.setLabels(title: "\(apps[index].name)")
               
               return appsCell
           }
        
      
    }
    
    // what to do when tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if we're not tapping an app cell, do nothing
        if indexPath.row == 0 || indexPath.row == inactiveSplitIndex { return }
        
        // if the indexPath is greater than our splitIndex, we grab from our apps array list accordingly
        let index =  indexPath.row > inactiveSplitIndex ? indexPath.row - 2 : indexPath.row - 1

        // toggle our app as active or inactive
        apps[index].isActive.toggle()
        
        // sort our app list
        sortAppsList()
        
        // reload our table view
        tableView.reloadData()
        
    }
    
    
}


// MARK: SetUpView and layouts
extension ViewController{
    
    
    private func setUpViews(){
        // hide our navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        // add our table view
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // register table view cells
        tableView.register(MenuTableCell.self, forCellReuseIdentifier: cellID)
        tableView.register(CustomHeaderCell.self, forCellReuseIdentifier: headerViewCellID)

        
    }
    
}

