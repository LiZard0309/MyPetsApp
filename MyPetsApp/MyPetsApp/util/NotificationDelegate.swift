//
//  NotificationDelegate.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 28.01.25.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    @Published var notificationMessage = ""
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "ACCEPT_ACTION":
            print("Accepted")
            notificationMessage = NSLocalizedString("Ok", comment: "")
        case "DECLINE_ACTION":
            print("Declined")
            notificationMessage = NSLocalizedString("Cancel", comment: "")
        default:
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }    
}
