//
//  CustomTableViewCell.swift
//  TableViewSectionSelectApp
//
//  Created by NeedsMoreCoffee on 8/7/22.
//
import UIKit


// MARK: The Table View Cell Used In our Menu
 class MenuTableCell: UITableViewCell{
     
     // the label used for our apps name
    let appsTitleLabel = UILabel()
     
    // the image view we will set our apps image to.
    let appsImageView = UIImageView()
     
    // sets our apps label font size
    private let fontSize = 20.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
     /// sets the title
    public func setLabels(title: String){
        appsTitleLabel.text = title
    }
    
     /// sets the app image
     public func setImage(image: UIImage){
         appsImageView.image = image
     }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: Layout
extension MenuTableCell{
    
    private func setUpView(){
        
        // add our appImageView
        backgroundColor = .white
        appsImageView.image = UIImage(named: "home_icon")
        appsImageView.backgroundColor = .white
        addSubview(appsImageView)
        appsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            appsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            appsImageView.widthAnchor.constraint(equalToConstant: 27),
            appsImageView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        
        // add our app title label
        let textBoldFont = UIFont(name: "HelveticaNeue", size: fontSize)
        
        appsTitleLabel.text = "Error"
        appsTitleLabel.textColor = .black
        appsTitleLabel.font = textBoldFont
        appsTitleLabel.sizeToFit()
        addSubview(appsTitleLabel)
        appsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appsTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            appsTitleLabel.leadingAnchor.constraint(equalTo: appsImageView.trailingAnchor, constant: 15)
        ])
        
    }
    
}


