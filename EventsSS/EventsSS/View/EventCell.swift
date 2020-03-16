//
//  EventCell.swift
//  EventsSS
//
//  Created by rodrigo on 15/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    var eventImageView = UIImageView()
    var eventTitlelbl = UILabel()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        addSubview(eventImageView)
        addSubview(eventTitlelbl)
        
        configureImageView()
        configureTitleLabel()
        configureCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView(){
        eventImageView.layer.cornerRadius = 10
        eventImageView.clipsToBounds = true
    }
    
    func configureTitleLabel()
    {
        eventTitlelbl.numberOfLines = 0
        eventTitlelbl.adjustsFontSizeToFitWidth = true
    }
    
    func set(event: EventViewModel){
        
        let url = URL(string: event.imageURL)
        if(url != nil)
        {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.eventImageView.image = image
                        }
                    }
                }
            }
        }
        eventTitlelbl.text = event.title
    }
    
    func configureCellConstraints()
    {
        //Image
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        eventImageView.widthAnchor.constraint(equalTo: eventImageView.heightAnchor, multiplier: 16/9).isActive = true
        
        //Title
        eventTitlelbl.translatesAutoresizingMaskIntoConstraints = false
        eventTitlelbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        eventTitlelbl.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor, constant: 20).isActive = true
        eventTitlelbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        eventTitlelbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
}
