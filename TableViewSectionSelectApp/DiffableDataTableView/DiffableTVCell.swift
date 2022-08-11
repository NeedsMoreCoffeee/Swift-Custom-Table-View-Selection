//
//  CustomTableViewCell.swift
//  TableViewSectionSelectApp
//
//  Created by NeedsMoreCoffee on 8/7/22.
//
import UIKit


// MARK: The Table View Cell Used In our Menu
 class DiffableTVCell: UITableViewCell{
     
     static let reuseIdentifier = "label-cell-reuse-identifier"

     // the label used for our apps name
    private let appsTitleLabel = UILabel()
     
    // the image view we will set our apps image to.
    private let appsImageView = UIImageView()
     
     
     // the image view that shows a checkmark when activated.
     private let appIsActiveImageView = UIImageView()
     
     
    // sets our apps label font size
    private let fontSize = 20.0
     

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    

     /// sets the title
     public func setLabels(title: String, image: String){
        appsTitleLabel.text = title
         
         if image == "" {
             appsImageView.image = nil

         } else {
             appsImageView.image = UIImage(named: image)

         }
    }
    
     /// mark this cells app as active
     public func setAppAsActive(isActive: Bool){
         appIsActiveImageView.image = isActive ? UIImage(named: "checkmark_icon") : nil
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
extension DiffableTVCell{
    
    private func setUpView(){
        
        // add our appImageView
        backgroundColor = .white
        appsImageView.backgroundColor = .white
        addSubview(appsImageView)
        appsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            appsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            appsImageView.widthAnchor.constraint(equalToConstant: 27),
            appsImageView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        // add our app is active checkmark view
        backgroundColor = .white
        appIsActiveImageView.backgroundColor = .clear
        appIsActiveImageView.tintColor = .systemBlue
        addSubview(appIsActiveImageView)
        appIsActiveImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appIsActiveImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            appIsActiveImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            appIsActiveImageView.widthAnchor.constraint(equalToConstant: 15),
            appIsActiveImageView.heightAnchor.constraint(equalToConstant: 15)
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
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(hue: 0.6667, saturation: 0.01, brightness: 0.92, alpha: 1.0) /* #e8e8eb */

        addSubview(seperatorView)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: appsTitleLabel.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  0),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        
        
    }
    
}


