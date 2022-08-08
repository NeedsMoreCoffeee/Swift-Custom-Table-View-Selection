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
        self.backgroundColor = UIColor(hue: 0.6889, saturation: 0.02, brightness: 0.96, alpha: 1.0) /* #f1f0f7 */

        
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
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ])
        
        createSeperators(isTop: true)
        createSeperators(isTop: false)
        
      
    }
    
    private func createSeperators(isTop: Bool){
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(hue: 0.6667, saturation: 0.01, brightness: 0.92, alpha: 1.0) /* #e8e8eb */
      
        addSubview(seperatorView)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let yAxisAnchor: NSLayoutConstraint = isTop ? seperatorView.topAnchor.constraint(equalTo: topAnchor, constant: -1) : seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1)
    
        yAxisAnchor.isActive = true
    }
    
}
