//
//  FacePeripheral.swift
//  ftaoba
//
//  Created by ukyo on 2020/04/19.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreData

class FacePeripheral: NSObject {
    private var peripheralManager: CBPeripheralManager?
    private var service: CBMutableService?
    private var characteristic: CBMutableCharacteristic?
    
    var isConnecting: Bool {
        get {
            return peripheralManager?.state == .poweredOn
        }
    }
    
    static let serviceUUID = CBUUID(string:  "07B196F9-5AA0-4270-B610-8DEDA20A417C")
    static let characterisiticUUID = CBUUID(string: "7A051851-3ABE-4ADB-94FC-8E2021A58320")
    static let advertisementData = [CBAdvertisementDataServiceUUIDsKey:  [FacePeripheral.serviceUUID], CBAdvertisementDataLocalNameKey: "ftaoba"] as [String: Any]
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func notify(_ data: Data) {
        if peripheralManager?.state != .poweredOn { return }
        peripheralManager?.updateValue(data, for: characteristic!, onSubscribedCentrals: nil)
    }
}

extension FacePeripheral: CBPeripheralManagerDelegate {
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error != nil {
            print("Service Add Failed... \(error!)")
            return
        }
        print("Service Add Sucsess!")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print("Failed... error: \(error!)")
            return
        }
        print("Succeeded!")
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            if service == nil {
                characteristic = CBMutableCharacteristic(type: FacePeripheral.characterisiticUUID, properties: [.notifyEncryptionRequired], value: nil, permissions: [.readEncryptionRequired])
                service = CBMutableService(type: FacePeripheral.serviceUUID, primary: true)
                service?.characteristics = [characteristic!]
                peripheralManager?.add(service!)
            }
            peripheral.startAdvertising(FacePeripheral.advertisementData)
        case .poweredOff:
            peripheral.stopAdvertising()
        default:
            return
        }
    }
    
    
}
