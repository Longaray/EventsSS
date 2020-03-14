//
//  Event.swift
//  EventsSS
//
//  Created by rodrigo on 14/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

/*
 {
    "people":[
       {
          "id":"1",
          "eventId":"1",
          "name":"name 1",
          "picture":"picture 1"
       }
    ],
    "date":1534784400000,
    "description":"O Patas Dadas estará na Redenção, nesse domingo, com cães para adoção e produtos à venda!\n\nNa ocasião, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarão prontinhos para ganhar o ♥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doação:\n- guias e coleiras em bom estado\n- ração (as que mais precisamos no momento são sênior e filhote)\n- roupinhas \n- cobertas \n- remédios dentro do prazo de validade",
    "image":"http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
    "longitude":-51.2146267,
    "latitude":-30.0392981,
    "price":29.99,
    "title":"Feira de adoção de animais na Redenção",
    "id":"1",
    "cupons":[
       {
          "id":"1",
          "eventId":"1",
          "discount":62
       }
    ]
 },
 */

import UIKit
import ObjectMapper

class Event: Mappable {

    var people = [People]()
    var date = 0.0
    var description : String?
    var image : String?
    var longitude : String?
    var latitude : String?
    var price = 0.0
    var title : String?
    var id : String?
    var cupons = [Cupon]()

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {

        people      <- map["people"]
        date        <- map["date"]
        description <- map["description"]
        image       <- map["image"]
        longitude   <- map["longitude"]
        latitude    <- map["latitude"]
        price       <- map["price"]
        title       <- map["title"]
        id          <- map["id"]
        cupons      <- map["cupons"]
    }
}
