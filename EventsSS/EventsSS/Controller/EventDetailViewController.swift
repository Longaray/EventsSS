//
//  EventDetailViewController.swift
//  EventsSS
//
//  Created by rodrigo on 15/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import UIKit

class EventDetailViewController : UIViewController{
 
    var eventImg = UIImageView()
    var eventTitle = UILabel()
    var eventDate = UILabel()
    var eventPrice = UILabel()
    var eventDescription =  UITextView()
    var eventCheckIn = UIButton()
    
    var eventoLocal: EventViewModel!
    private var request = Service()
    var labelMessage: UILabel!
      
    func exitScreen() {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEventDetail()
    }
    
    func configureEventDetail()
    {
        view.backgroundColor = .systemBlue
        view.addSubview(eventImg)
        view.addSubview(eventTitle)
        view.addSubview(eventDate)
        view.addSubview(eventPrice)
        view.addSubview(eventDescription)
        view.addSubview(eventCheckIn)
        
        configureUIComponents()
        configureEventDetailConstraints()
        setData()
    }
    
    @objc func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func checkInButton(_ sender: Any) {
        checkInDialog()
    }

    override func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setEvento( evento: EventViewModel)
    {
        self.eventoLocal = evento
    }

    func checkInDialog() {
        let alertController = UIAlertController(title: "Realizar CheckIn?", message: "Insira nome e email", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "CheckIn", style: .default) { (_) in
            
            //getting the input values from user
            let eventoID = self.eventoLocal.id
            let name = alertController.textFields?[0].text
            let email = alertController.textFields?[1].text
            
            let parameters = [
                "eventId": eventoID,
                "name":name,
                "email": email
            ]
            
            self.request.postEvento(parameters: parameters as [String : Any], completionHandler: {response,error  in
                guard error == nil else {
                    return
                }
                
                switch response?.result {
                                case .success:
                                    print(response)
                                    let alert = UIAlertController(title: "Sucesso", message: "Seu check-In foi realizado com sucesso!", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    break
                                case .failure(let error):
                                    print(error)
                                case .none:
                                    print(error)
                                    let alert = UIAlertController(title: "Erro", message: "Nāo foi possivel realizar ovcheck-in, por favor, tente novamente!", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                     
                
            })
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setData()
    {
        eventTitle.text = self.eventoLocal.title
        eventDate.text = "Data: " + self.eventoLocal.date
        eventPrice.text = "Preço: " + self.eventoLocal.price
        eventDescription.text =  self.eventoLocal.description
        eventDescription.isEditable = false
        self.eventImg.image = UIImage(named: "notAvailable")
        let url = URL(string: self.eventoLocal.imageURL)
        if(url != nil){
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.eventImg.image = image
                        }
                    }
                }
            }
        }
    }
    
    @objc func shareEventButton(_ sender: Any)
    {

        let imageToShare = [eventImg.image!]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop
        ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func configureUIComponents(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareEventButton))
        
        eventImg.layer.cornerRadius = 10
        eventImg.clipsToBounds = true
        
        eventTitle.numberOfLines = 0
        eventTitle.adjustsFontSizeToFitWidth = true
        eventTitle.textAlignment = .center
        eventTitle.textColor = .white
        eventTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        eventCheckIn.setTitle("CheckIn", for: .normal)
        eventCheckIn.titleLabel?.textColor = .white
        eventCheckIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        eventCheckIn.backgroundColor = .blue
        eventCheckIn.layer.cornerRadius = 10
        
        eventDate.numberOfLines = 0
        eventDate.adjustsFontSizeToFitWidth = true
        eventDate.textColor = .white
        eventDate.font = UIFont.boldSystemFont(ofSize: 20)
        
        eventPrice.numberOfLines = 0
        eventPrice.adjustsFontSizeToFitWidth = true
        eventPrice.textAlignment = .right
        eventPrice.textColor = .white
        eventPrice.font = UIFont.boldSystemFont(ofSize: 20)
        
        eventDescription.textColor = .white
        eventDescription.font = UIFont.boldSystemFont(ofSize: 16)
        eventDescription.backgroundColor = UIColor.white.withAlphaComponent( 0)
    }
    
    func configureEventDetailConstraints(){

        //Image
        eventImg.translatesAutoresizingMaskIntoConstraints = false
        eventImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        eventImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        eventImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        eventImg.widthAnchor.constraint(equalTo: eventImg.heightAnchor, multiplier: 16/9).isActive = true
        
        //Title
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        eventTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventTitle.topAnchor.constraint(equalTo: eventImg.bottomAnchor, constant: 2).isActive = true
        eventTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        eventTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        eventTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        eventTitle.widthAnchor.constraint(equalTo: eventImg.heightAnchor, multiplier: 16/9).isActive = true
        
        //CheckIn
        eventCheckIn.translatesAutoresizingMaskIntoConstraints = false
        eventCheckIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventCheckIn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2).isActive = true
        eventCheckIn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        eventCheckIn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        eventCheckIn.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        //Date
        eventDate.translatesAutoresizingMaskIntoConstraints = false
        eventDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventDate.bottomAnchor.constraint(equalTo: eventCheckIn.topAnchor, constant: 2).isActive = true
        eventDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        eventDate.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //Price
        eventPrice.translatesAutoresizingMaskIntoConstraints = false
        eventPrice.bottomAnchor.constraint(equalTo: eventCheckIn.topAnchor, constant: 2).isActive = true
        eventPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        eventPrice.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //Description
        eventDescription.translatesAutoresizingMaskIntoConstraints = false
        eventDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventDescription.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 20).isActive = true
        eventDescription.bottomAnchor.constraint(equalTo: eventDate.topAnchor, constant: -12).isActive = true
        eventDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        eventDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        eventDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        eventDescription.widthAnchor.constraint(equalTo: eventImg.heightAnchor, multiplier: 16/9).isActive = true
         
    }

}
