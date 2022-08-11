//
//  AppsController.swift
//  TableViewSectionSelectApp
//
//  Created by NeedsMoreCoffeee on 8/9/22.
//

import Foundation

class AppsController{
    
    class App: Hashable{
        var name: String
        var isActive = false
        var appImageName = ""
        
        let identifier = UUID()
        
        
        init(name: String, appImageName: String){
            self.name = name
            self.appImageName = appImageName
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: App, rhs: App) -> Bool{
            return lhs.identifier == rhs.identifier
        }
        
         func toggleActive(){
            self.isActive.toggle()
        }
        
    }
    
    var apps: [App] = [ App(name: "Photos", appImageName: "photos_icon"),
                            App(name: "App Store", appImageName: "app_store_icon"),
                            App(name: "Calender", appImageName: "app_store_icon"),
                            App(name: "iBooks", appImageName: "ibooks_icon"),
                            App(name: "iTunes", appImageName: "iTunes_icon"),
                            App(name: "Mail", appImageName: "mail_icon"),
                            App(name: "Maps", appImageName: "maps_icon"),
                            App(name: "Messages", appImageName: "messages_icon"),
                            App(name: "Music", appImageName: "music_icon"),
                            App(name: "Notes", appImageName: "notes_icon"),
                            ]
    
   
    
    
    func filteredActiveApps() -> [App]{
        let activeApps = apps.filter{ $0.isActive == true}.sorted{ $0.name.lowercased() < $1.name.lowercased()}
        return activeApps
    }
    
    
    func allInactiveApps() -> [App]{
        return apps.filter{ $0.isActive == false}.sorted{ $0.name.lowercased() < $1.name.lowercased()}
    }
    
    func changeTitle(id: UUID){
        for app in apps {
            if app.identifier == id{
                print("Changing app name from \(app.name) to Testing")
                app.name = "Testing"
                
            }
        }
    }
}
