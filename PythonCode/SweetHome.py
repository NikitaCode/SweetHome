#!/usr/bin/env python
# -*- coding: utf-8 -*-

import paho.mqtt.client as mqtt
import RPi.GPIO as gpio

def gpioSetup():
	
	gpio.setmode(gpio.BCM)
	gpio.setup(23, gpio.OUT)

def connectionStatus(client, userdata, flags, rc):
	mqttClient.subscribe("rpi/gpio")

def messageDecoder(client, userdata, msg):
	message = msg.payload.decode(encoding='UTF-8')
	
	if message == "on":
		gpio.output(23, gpio.HIGH)
		print("LED is ON!")
	elif message == "off":
		gpio.output(23, gpio.LOW)
		print("LED is OFF!")
	else:
		print("Unknown message!")

gpioSetup()

clientName = "RPI"
serverAddress = "192.168.1.116"

mqttClient = mqtt.Client(clientName)

mqttClient.on_connect = connectionStatus
mqttClient.on_message = messageDecoder

mqttClient.connect(serverAddress)
mqttClient.loop_forever()

