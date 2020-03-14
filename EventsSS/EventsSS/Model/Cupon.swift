//
//  Cupon.swift
//  EventsSS
//
//  Created by rodrigo on 14/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import UIKit
import ObjectMapper

class Cupon: Mappable {

    var id : String?
    var eventId : String?
    var discount = 0.0

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        eventId     <- map["eventId"]
        discount    <- map["discount"]
        
    }
}
