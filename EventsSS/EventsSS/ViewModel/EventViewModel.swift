//
//  EventViewModel.swift
//  EventsSS
//
//  Created by rodrigo on 15/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import Foundation
import UIKit

struct EventViewModel
{
    //let people = [String]()
    let date:String
    let description:String
    let imageURL:String
    //let longitude:String
    //let latitude:String
    let price:String
    let title:String
    let id:String
    //let cupons:String
    
    init(evento: Event)
    {
        self.imageURL = evento.image ?? ""
        self.title = evento.title ?? ""
        self.description = evento.description ?? ""
        self.id = evento.id ?? ""
        
        //Convert data em milisegundos para date
        let dateFromMili = Date(timeIntervalSince1970: TimeInterval(evento.date) / 1000)
        if dateFromMili != nil
        {
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: dateFromMili) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd/MM/yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            
            self.date = myStringafd
        }
        else
        {
            self.date = ""
        }
        
        
        var preco = evento.price
        if(preco != nil)
        {
              self.price = String(format: "R$ %.02f", preco)
        }
        else
        {
            self.price = ""
        }
    }
}
