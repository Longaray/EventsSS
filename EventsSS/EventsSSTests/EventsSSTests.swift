//
//  EventsSSTests.swift
//  EventsSSTests
//
//  Created by rodrigo on 14/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import XCTest
@testable import EventsSS

class EventsSSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
        
    //Testa retorno da api
    func testService_GetEventos() {
        
        let expectation = self.expectation(description: "getEventos")
        let request = Service()
        var eventosList = [Event]()
        request.getEventos(completionHandler: {eventos,error  in
                guard error == nil else {
                    return
                }
                eventosList = eventos ?? []
                expectation.fulfill()
                //XCTAssertGreaterThan(eventosList.count, 0)
            })
        
         waitForExpectations(timeout: 5, handler: nil)

        XCTAssertGreaterThan(eventosList.count, [].count)
         
    }

    //Testa post da api
    func testService_PostEvento() {
        
        let expectation = self.expectation(description: "postEventos")
        
        let request = Service()
        
        let parameters = [
            "eventId": "1",
            "name": "test",
            "email": "test@email.com"
        ]
        
        var resposta = ""
        
        request.postEvento(parameters: parameters as [String : Any], completionHandler: {response,error  in
            guard error == nil else {
                return
            }
            
            switch response?.result {
                            case .success:
                                resposta = "Sucesso"
                                expectation.fulfill()
                                break
                            case .failure(let error):
                                resposta = "Falha"
                                expectation.fulfill()
                            case .none:
                                resposta = "Falha"
                                expectation.fulfill()
                            }
                 
            
        })
        
         waitForExpectations(timeout: 5, handler: nil)

         XCTAssertEqual(resposta, "Sucesso")
         
    }

}
