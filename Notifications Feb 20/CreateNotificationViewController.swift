//
//  CreateNotificationViewController.swift
//  Notifications Feb 20
//
//  Created by Margiett Gil on 2/20/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
protocol CreateNotificationControllerDelegate: AnyObject {
    func didCreateNotification(_ createNotificationController: CreateNotificationViewController)
}

class CreateNotificationViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateNotificationControllerDelegate?
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5 // current time plus 5 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func createLocalNotification() {
        // Step 1: create the content
        let content = UNMutableNotificationContent()
        content.title = titleTextField.text ?? "No title"
        content.body = "local Notifications is awesome when used appropriatly"
        content.subtitle = "learning local Notifications"
        
        //TODO: userInfo dictionary c an hold additional data
        //content.userInfo = ["":""]
        
        
        
        
       
        //MARK: create indentifier
        let identifier = UUID().uuidString // unique String
         //MARK: attachment
        if let imageURL = Bundle.main.url(forResource: "pursuit-logo", withExtension: "png"){
            do {
                let attachment = try UNNotificationAttachment(identifier: identifier, url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print("error with attachment: \(error)")
            }
        } else {
            print("image resource could not be found")
        }
        
        
        // create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        
        
        // create a request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // add request to the unnotificationCenter
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error adding request: \(error)")
            } else {
                print("request was successfully added ")
            }
        }
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        guard sender.date > Date() else { return }
        
        timeInterval = sender.date.timeIntervalSinceNow
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.didCreateNotification(self)
    }
    
    
}
