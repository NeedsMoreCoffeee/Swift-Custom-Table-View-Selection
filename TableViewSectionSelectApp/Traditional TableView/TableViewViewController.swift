//
//  ViewController.swift
//  TableViewSectionSelectApp
//
//  Created by  NeedsMoreCoffee
//

import UIKit


// this is a reference to our apps.
class ListApp{
    var name: String
    var isActive = false
    var appImageName = ""
    
    init(name: String, appImageName: String){
        self.name = name
        self.appImageName = appImageName
    }
    
}


// creates a table view with custom headers.
class TableViewViewController: UIViewController {


    // our table view that holds our menu items
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
 
    
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
  
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // arrange our apps alphabetically
        sortAppsArrayAlphabetically()
        
        // set up our table view
        setUpViews()
     
    }

    // returns a sorted tuple of our active apps and inactive
    private func activeApps() -> (active: [ListApp], inactive: [ListApp]){
        return (apps.filter{ $0.isActive}.sorted{$0.name.lowercased() < $1.name.lowercased()}, apps.filter{ !$0.isActive}.sorted{$0.name.lowercased() < $1.name.lowercased()} )
    }

    // sorts the array alphabetically while keeping the apps that are active at the front of the array
    private func sortAppsArrayAlphabetically(){
        apps.sort{ $0.name.lowercased() < $1.name.lowercased()}
        
    }
}


// MARK: Delegates and Protocols
extension TableViewViewController:  UITableViewDelegate, UITableViewDataSource{
  
    // how many cells our table should have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the amount in our apps list + 2 for our 2 headerviews
        return section == 0 ? activeApps().active.count : activeApps().inactive.count
    }
    
    // the height for our cells. Can be used to custom set our headers height at index.row 0 and at indexPath.row == inactiveSplitIndex
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "ACTIVE" : "APPS"
    }

    // populate our tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
               // else all other cells is our menuTable cell that holds our app information
        let appsCell =  tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseIdentifier, for: indexPath) as! MenuTableCell
               
               // remove higlighting on cell tap
               appsCell.selectionStyle = .none
               
               let index =  indexPath.row
        
               let apps = indexPath.section == 0 ? activeApps().active : activeApps().inactive
               
               // set our apps labels
               appsCell.setLabels(title: "\(apps[index].name)", image: apps[index].appImageName)
               
               // set cell as active or not based on app
               appsCell.setAppAsActive(isActive: apps[index].isActive)
               
               return appsCell
           
        
      
    }
    
    // what to do when tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // if the indexPath is greater than our splitIndex, we grab from our apps array list accordingly
        let index =  indexPath.row
        
        let apps = indexPath.section == 0 ? activeApps().active : activeApps().inactive

        
        // toggle our app as active or inactive
        apps[index].isActive.toggle()
 

        // reload our table view
        tableView.reloadData()
        
    }
    
    
}


// MARK: SetUpView and layouts
extension TableViewViewController{
    
    
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
        tableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.reuseIdentifier)

        
    }
    
}

