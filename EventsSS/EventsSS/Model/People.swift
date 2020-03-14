//
//  People.swift
//  EventsSS
//
//  Created by rodrigo on 14/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import Foundation
import ObjectMapper

class People: Mappable {

    var id : String?
    var eventId : String?
    var name : String?
    var picture : String?

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {

        id      <- map["id"]
        eventId <- map["eventId"]
        name    <- map["name"]
        picture <- map["picture"]

    }
}
