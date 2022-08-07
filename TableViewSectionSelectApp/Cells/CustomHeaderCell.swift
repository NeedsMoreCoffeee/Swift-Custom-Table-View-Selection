//
//  CustomHeaderCell.swift
//  TableViewSectionSelectApp
//
//  Created by NeedsMoreCoffee on 8/7/22.
//

import UIKit

// a custom title bar for our UITableView
class CustomHeaderCell: UITableViewCell {
    
    // the title to be displayed
    private let titleLabel = UILabel()

  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addTitleLabel()
        self.backgroundColor = .clear
        
    }
    
    /// sets the title of our cell
    public func setTitle(title:String){
        titleLabel.text = title
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}










// MARK: Layout
extension CustomHeaderCell{
    
    // adds the title label
    private func addTitleLabel(){
        titleLabel.text = "TITLE"
        titleLabel.sizeToFit()
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    
}
