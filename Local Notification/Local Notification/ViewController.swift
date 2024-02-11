//
//  ViewController.swift
//  Local Notification
//
//  Created by Gamze Akyüz on 10.02.2024.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var notificationControl: Bool = false
    
    @IBOutlet weak var switchBildirimBir: UISwitch!
    @IBOutlet weak var switchBildirimIki: UISwitch!
    @IBOutlet weak var switchBildirimUc: UISwitch!
    @IBOutlet weak var switchBildirimDort: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().delegate = self
        
        userNotificationAllow()

        
    }
//    bildirimleri uygulamanın ön arayüzündede çalışır hale getirme
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound,.badge])
        
    }
    

    func userNotificationAllow() {

//        kullanıcıdan bildirim izni almak için kulanılır.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted, errror) in
            
            self.notificationControl = granted
            
            if granted {
                print("Bildirimlere İzin Verildi.")
            }else {
                print("Bildirimlere İzin Verilmedi")
            }
            
        })
    }
    

    @IBAction func bildirimBir(_ sender: Any) {
        if notificationControl {
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Sub Title"
            content.body = "Message"
            content.badge = 1
            content.sound = UNNotificationSound.default
            
//            bildirimi tekrarlamayacak şekilde 10 Saniye içerisin de yönlendirme
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
            
            print("10 Saniye Bildirimi Açıldı")
            
        }
    }
    
    @IBAction func bildirimBirswitchChange(_ sender: UISwitch) {
            
            if sender.isOn {
                if notificationControl {
                    let content = UNMutableNotificationContent()
                    content.title = "Title"
                    content.subtitle = "Sub Title"
                    content.body = "Message"
                    content.badge = 1
                    content.sound = UNNotificationSound.default

    //                    Bildirimler tekrarlı olmasını istiyorsan min 60 saniye bir bildirim göndermesini sağlaman gerekiyor.
                               
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                    
                    let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
                    
                }
                print("Tekrarlı 60 Saniye Bildirimi Açıldı")
            }else {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                
                print("Bildirim Kapandı")
            }
            
        }

    @IBAction func bildirimIkiswitchChange(_ sender: UISwitch) {
            
            if sender.isOn {
                if notificationControl {
                    let content = UNMutableNotificationContent()
                    content.title = "Title"
                    content.subtitle = "Sub Title"
                    content.body = "Message"
                    content.badge = 1
                    content.sound = UNNotificationSound.default
                    
                    //     1 saat aralıkla bildirim göndermek için  3600 saniye süreyle bildirim oluşturmak için kullanmak zorundasın
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
                    
                    let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
                    
                }
                print("Tekrarlı 3600 Saniye Bildirimi Açıldı")
            }else {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                
                print("Bildirim Kapandı")
            }
            
        }
    
    @IBAction func bildirimUcswitchChange(_ sender: UISwitch) {
            
            if sender.isOn {
                if notificationControl {
                    let content = UNMutableNotificationContent()
                    content.title = "Title"
                    content.subtitle = "Sub Title"
                    content.body = "Message"
                    content.badge = 1
                    content.sound = UNNotificationSound.default
                    
                    //                    1 gün arayla 86400 saniye sonra
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
                    
                    let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
                    
                }
                print("Tekrarlı 86400 Saniye Bildirimi Açıldı")
            }else {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                
                print("Bildirim Kapandı")
            }
            
        }
    
    @IBAction func bildirimDortswitchChange(_ sender: UISwitch) {
        
        if sender.isOn {
            if notificationControl {
                let content = UNMutableNotificationContent()
                content.title = "Title"
                content.subtitle = "Sub Title"
                content.body = "Message"
                content.badge = 1
                content.sound = UNNotificationSound.default
                
                //                belirlenen tarih gerçekleştiğinde ilk bildirim oluşur ve tarihe göre tekrarlama yapar.
                
                var date = DateComponents()
                
                //                 her saat 8.30  olduğunda bildirim  oluşturcak
                date.minute = 30
                date.hour = 8
                
                /*
                 her 5.ci ayın 20'sinde saat 8.30  olduğunda bildirim  oluşturcak
                 date.minute = 30
                 date.hour = 8
                 date.day = 20
                 date.month = 5
                 */
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                
                let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
                
            }
            print("Bildirim Açıldı")
        }else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            
            print("Bildirim Kapandı")
        }
        
    }

    @IBAction func actionBildirimButton(_ sender: Any){
        
        if notificationControl {
            
            let yes = UNNotificationAction(identifier: "Yes", title: "Yes", options: .foreground)
            let no = UNNotificationAction(identifier: "No", title: "No", options: .foreground)
            let delete = UNNotificationAction(identifier: "Delete", title: "Delete", options: .destructive)
            
            let category = UNNotificationCategory(identifier: "category", actions: [yes, no, delete], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            let content = UNMutableNotificationContent()
            content.title = "Title"
            content.subtitle = "Sub Title"
            content.body = "Bildirim Kapansın mı ? "
            content.badge = 1
            content.sound = UNNotificationSound.default
            
            content.categoryIdentifier = "category"
            
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            
            let notificationRequest = UNNotificationRequest(identifier: "Create Notification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        }
        print("10 Saniye Bildirimi Oluşturuldu.")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "Yes" {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            print("Bildirim Kapandı")
        }
        if response.actionIdentifier == "Hayır" {
            print("Bildirim Açık")
        }
        if response.actionIdentifier == "Delete" {
            print("Bildirim Silindi")
        }
        
        completionHandler()
    }
    
}


