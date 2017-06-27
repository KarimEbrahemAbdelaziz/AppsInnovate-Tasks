//
//  ViewController.swift
//  Calendar
//
//  Created by KARIM on 6/25/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UITableViewController {

    let eventStore = EKEventStore()
    
    @IBOutlet weak var eventNotes: UITextField!
    @IBOutlet weak var eventTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
        checkForPermission()
        eventTitle.text! = ""
        eventNotes.text! = ""
    }
    
    func checkForPermission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            makeEvent()
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: { (isAvailable, error) in
                if let error = error {
                    print(error)
                } else {
                    if isAvailable {
                        self.makeEvent()
                    }
                }
            })
        case .denied, .restricted:
            let alert = UIAlertController(title: "Access denied !!", message: "You didn't give access for the App to integrate with your calendar.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func makeEvent() {
        let newEvent = EKEvent(eventStore: eventStore)
        
        if let title = eventTitle.text, eventTitle.text! != "" {
            newEvent.title = title
        } else {
            newEvent.title = "Dummy data to prevent empty title"
        }
        
        newEvent.startDate = Date()
        newEvent.endDate = Date()
        newEvent.notes = eventNotes.text!
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        // Save the event using the Event Store instance
        do {
            try eventStore.save(newEvent, span: .thisEvent)
            
            let alert = UIAlertController(title: "Event Saved", message: "Your Event had beed Saved :)", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)

        } catch {
            let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }


}

