//
//  ViewController.swift
//  Notifications Feb 20
//
//  Created by Margiett Gil on 2/20/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //data for tableview
    private var notification = [UNNotificationRequest]()
    // this is a sigleton
    private let center = UNUserNotificationCenter.current()
    
    private let pendingNotification = PendingNotification()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        checkForNotificationAuthorization()
        //   requestNotificationPermission()
        loadNotifications()
    }
    
    private func loadNotifications(){
        pendingNotification.getPendingNotifications { (requests) in
            self.notification = requests
        }
    }
     //MARK: asking user permission for notification
    private func checkForNotificationAuthorization(){
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                print("app is authorized for notifications")
            } else {
                self.requestNotificationPermission()
            }
            
        }
        
    }
   // We need permission for alert and sound and have to ask permission for each
    private func requestNotificationPermission(){
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("error requesting authorization: \(error)")
                return
            }
            if granted {
                print("access was granted")
                
            } else {
                print("access denied")
            }
        }
        
    }


}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        return cell
    }
}
