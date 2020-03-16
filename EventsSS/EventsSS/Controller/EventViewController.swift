//
//  EventViewController.swift
//  EventsSS
//
//  Created by rodrigo on 15/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tbtTable = UITableView()
    var eventosList = [EventViewModel]()
    private var request = Service()
    
    struct Cells{
        static let eventCell = "EventCell"
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
    
        super.navigationItem.title = "Eventos"
        configureTableView()
        fetchData()
    }
    
    func configureTableView(){
        view.addSubview(tbtTable)
        setTableViewDelegate()
        tbtTable.rowHeight = 100
        tbtTable.register(EventCell.self, forCellReuseIdentifier: Cells.eventCell)
        tbtTable.pin(to: view)
        
    }
    
    func setTableViewDelegate(){
        self.tbtTable.delegate = self
        self.tbtTable.dataSource = self
    }
    
    func fetchData(){
        //Popula lista com todos os eventos
        request.getEventos(completionHandler: {eventos,error  in
            guard error == nil else {
                return
            }
            self.eventosList += eventos?.map({return EventViewModel(evento: $0)}) ?? []
            self.tbtTable.reloadData()
        })
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventosList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tbtTable.dequeueReusableCell(withIdentifier: Cells.eventCell) as! EventCell
        let eventViewModel = self.eventosList[indexPath.row]
        cell.set(event: eventViewModel)
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let controller = EventDetailViewController()
        controller.setEvento(evento: self.eventosList[indexPath.row])

        self.navigationController!.pushViewController( controller, animated: true )
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


