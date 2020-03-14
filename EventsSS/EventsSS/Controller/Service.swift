//
//  Service.swift
//  EventsSS
//
//  Created by rodrigo on 14/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import Alamofire
import SwiftyJSON

class Service: NSObject {

    func getEventos(completionHandler: @escaping ([Event]?,Error?) -> Void){
        
        let urlEvents = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events/"
        
        Alamofire.request(urlEvents).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)

                let eventos = Mapper<Event>().mapArray(JSONString: swiftyJsonVar.description)
                
                completionHandler(eventos,nil)

            }
        }
    }
    
    func postEvento(parameters:[String: Any], completionHandler: @escaping (DataResponse<Any>?,Error?) -> Void)
    {
        let urlEvents = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin"

        Alamofire.request(urlEvents, method: .post, parameters: parameters ,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
            completionHandler(response,nil)
        }
    }
}
