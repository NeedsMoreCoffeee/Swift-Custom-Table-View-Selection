//
//  ViewController.swift
//  TableViewSectionSelectApp
//
//  Created by  NeedsMoreCoffee
//

import UIKit


// creates a table view with custom headers.
class DiffableTableViewController: UIViewController {


    enum Section: CaseIterable{
        case main, second
    }
    
    // our table view that holds our menu items
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.separatorColor = .clear
        tv.delegate = self
        return tv
    }()
    
    private var dataSource: DataSource!
    
    let appsController = AppsController()


    override func viewDidLoad() {
        super.viewDidLoad()
    
        // set up our table view
        setUpViews()
        configureDataSource()
        updateTableViewDiffable()
    }

}


// MARK: Delegates and Protocols
extension DiffableTableViewController: UITableViewDelegate{


    func configureDataSource(){
        dataSource = DataSource(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, app: AppsController.App) -> UITableViewCell? in
            // configure and return cell
             guard let appsCell = tableView.dequeueReusableCell(withIdentifier: DiffableTVCell.reuseIdentifier, for: indexPath) as? DiffableTVCell else{ fatalError("Could not return an app cell") }
            
            
             // remove higlighting on cell tap
             appsCell.selectionStyle = .none
                          
             // set our apps labels
            appsCell.setLabels(title: app.name, image: app.appImageName)
             
             // set cell as active or not based on app
             appsCell.setAppAsActive(isActive: app.isActive)
            
            return appsCell
        }
        
       
        
    }
    
    // On Tap: Change our app to active, update our diffable
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = dataSource!.itemIdentifier(for: indexPath)!
            app.toggleActive()
            updateTableViewDiffable()
       }
    
    
    func updateTableViewDiffable() {

        var snapshot = NSDiffableDataSourceSnapshot<Section, AppsController.App>()
        
        for section in Section.allCases{
            snapshot.appendSections([section])
            if section == .main{
                snapshot.appendItems(appsController.filteredActiveApps())
                snapshot.reconfigureItems(appsController.filteredActiveApps())

            } else {
                snapshot.appendItems(appsController.allInactiveApps())
                snapshot.reconfigureItems(appsController.filteredActiveApps())

            }
            
        }
        
      
        
       dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
}


// MARK: SetUpView and layouts
extension DiffableTableViewController{
    
    
    private func setUpViews(){
        // hide our navigation bar
        self.navigationController?.isNavigationBarHidden = true
       
    
        // add our table view
        tableView.backgroundColor = UIColor(hue: 0.6889, saturation: 0.02, brightness: 0.96, alpha: 1.0) /* #f1f0f7 */
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // register table view cells
        tableView.register(DiffableTVCell.self, forCellReuseIdentifier:  DiffableTVCell.reuseIdentifier)

        
    }
    
}


private class DataSource: UITableViewDiffableDataSource<DiffableTableViewController.Section, AppsController.App>{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "ACTIVE" : "APPS"
      
    }
    
}

