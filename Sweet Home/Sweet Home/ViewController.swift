//
//  ViewController.swift
//  Sweet Home
//
//  Created by Nikita Sherbakov on 6/5/19.
//  Copyright © 2019 Nikita Sherbakov. All rights reserved.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "192.168.1.116", port: 1883)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mqttClient.connect()
        print("connection succses")
    }
    
    @IBAction func connectButton(_ sender: UIButton) {
        mqttClient.connect()
    }
    
    @IBAction func disconnectButton(_ sender: UIButton) {
        mqttClient.disconnect()
    }
    
    
    @IBAction func openDoorButton(_ sender: UIButton) {
        
       openDoor()

    }
    
    func openDoor() {
        mqttClient.publish("rpi/gpio", withString: "on")
//        sleep(3)
//        mqttClient.publish("rpi/gpio", withString: "off")
    }
    
}

