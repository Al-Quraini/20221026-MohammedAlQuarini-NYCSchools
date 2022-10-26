//
//  NYCSchoolTableViewCell.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import Foundation
import UIKit

class NYCSchoolTableViewCell : UITableViewCell {
    
    static let id : String = "NYCSchoolTableViewCell"
    
    
    // school name
    let schoolName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    // overview paragraph
    let overview : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        
        return label
    }()
    
    // school phone number
    let phoneNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        
        return label
    }()
    
    // school email
    let email : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        
        return label
    }()
    
    // school address
    let address : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        return label
    }()
    
    // vertical stack view to arrange labels
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .fillEqually
                
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set up views
    private func setup(){
        // add subviews
        addSubview(stackView)
        stackView.addArrangedSubview(schoolName)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(phoneNumber)
    }
    
    // prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        schoolName.text = nil
        overview.text = nil
        email.text = nil
        phoneNumber.text = nil
        address.text =  nil
    }
    
    // layout the views
    private func layout(){
        
        // set constraints
        NSLayoutConstraint.activate([
            // stack view constraints
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    // map values to views
    func configCell(model : NYCHighSchoolModel){
        let addressLine1 = model.addressLine1 ?? "",
        city = model.city ?? "", state = model.state ?? "",
        zip = model.zip ?? ""
        
        schoolName.text = model.schoolName ?? "N/A"
        overview.text = model.overveiwParagraph ?? "N/A"
        email.text = model.email ?? "N/A"
        phoneNumber.text = model.phoneNumber ?? "N/A"
        // address formatting
        address.text = "\(addressLine1), \(city), \(state), \(zip)"
    }
    
    
}
