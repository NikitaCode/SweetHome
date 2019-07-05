//
//  ViewController.swift
//  Sweet Home
//
//  Created by Nikita Sherbakov on 17/6/19.
//  Copyright © 2019 Nikita Sherbakov. All rights reserved.
//

import UIKit
import MQTTClient

class SweetHomeViewController: UIViewController {
    
    // let MQTT_HOST = "192.168.1.200" //"bradley2.ddns.net"
    let MQTT_HOST = "bradley2.ddns.net"
    
    let MQTT_PORT: UInt32 = 1883
    
    private var transport = MQTTCFSocketTransport()
    fileprivate var session = MQTTSession()
    fileprivate var completion: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session?.delegate = self
        self.transport.host = MQTT_HOST
        self.transport.port = MQTT_PORT
        session?.transport = transport
        
        updateUI(for: self.session?.status ?? .created)
        session?.connect() { error in
            print("connection completed with status \(String(describing: error))")
            if error != nil {

            } else {

            }
        }
        
    }
    
    private func updateUI(for clientStatus: MQTTSessionStatus) {
        
        }
    
    
    
    private func subscribe() {
        self.session?.subscribe(toTopic: "rpi/gpio", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
    }
    
    private func publishMessage(_ message: String, onTopic topic: String) {
        session?.publishData(message.data(using: .utf8, allowLossyConversion: false), onTopic: topic, retain: false, qos: .exactlyOnce)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        publishMessage("on", onTopic: "rpi/gpio")
    }
}

extension SweetHomeViewController: MQTTSessionManagerDelegate, MQTTSessionDelegate {
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        if let msg = String(data: data, encoding: .utf8) {
            print("topic \(topic!), msg \(msg)")
        }
    }
    
    func messageDelivered(_ session: MQTTSession, msgID msgId: UInt16) {
        print("delivered")
        DispatchQueue.main.async {
            self.completion?()
        }
    }
}


