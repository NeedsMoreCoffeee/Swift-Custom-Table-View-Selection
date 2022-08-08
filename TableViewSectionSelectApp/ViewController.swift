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
    var appImageName = ""
    
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
    var apps: [ListApp] = [ ListApp(name: "Photos", appImageName: "photos_icon"),
                            ListApp(name: "App Store", appImageName: "app_store_icon"),
                            ListApp(name: "Calender", appImageName: "app_store_icon"),
                            ListApp(name: "iBooks", appImageName: "ibooks_icon"),
                            ListApp(name: "iTunes", appImageName: "iTunes_icon"),
                            ListApp(name: "Mail", appImageName: "mail_icon"),
                            ListApp(name: "Maps", appImageName: "maps_icon"),
                            ListApp(name: "Messages", appImageName: "messages_icon"),
                            ListApp(name: "Music", appImageName: "music_icon"),
                            ListApp(name: "Notes", appImageName: "notes_icon")]
  
    
    // used to calculate where our split in the table view should go (acitve apps list) -> splitTitleView -> (inactive apps)
    private var inactiveSplitIndex = 1 // must be set to 1 by default.


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // arrange our apps alphabetically
        sortAppsArrayAlphabetically(index: 1)
        
        
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

        }
        
        // if none of our apps are false, set our inactive apps split title view to the end of our table view
        inactiveSplitIndex = apps.count + 1
        
    }

    // sorts the array alphabetically while keeping the apps that are active at the front of the array
    private func sortAppsArrayAlphabetically(index: Int){
 
        // if there are no active apps, sort the whole array
        if inactiveSplitIndex <= 1 { apps.sort{ $0.name.lowercased() < $1.name.lowercased() }; return}
        
        // sort the active half of the array
        apps[0...inactiveSplitIndex - 2].sort{ $0.name.lowercased() < $1.name.lowercased() }
        
        // sort the inactive half of the array
        apps[(inactiveSplitIndex - 1)...].sort{ $0.name.lowercased() < $1.name.lowercased() }
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
        return 55
    }
    

    // populate our tableview
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
               appsCell.setLabels(title: "\(apps[index].name)", image: apps[index].appImageName)
               
               // set cell as active or not based on app
               appsCell.setAppAsActive(isActive: apps[index].isActive)
               
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
        
        // sort the two halves of our array alphabetically
        sortAppsArrayAlphabetically(index: index)

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

