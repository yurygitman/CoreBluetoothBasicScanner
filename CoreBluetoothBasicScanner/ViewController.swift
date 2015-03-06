//
//  ViewController.swift
//  CoreBluetoothBasicScanner
//
//  Created by GrownYoda on 3/6/15.
//  Copyright (c) 2015 yuryg. All rights reserved.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    let myCentralManager = CBCentralManager()
    var myConnectedPeripheral = CBPeripheral()
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        myCentralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    }


// Mark   CBCentralManager Methods
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        printToMyTextView("centralManagerDidUpdateState")
       
        /*
        typedef enum {
            CBCentralManagerStateUnknown  = 0,
            CBCentralManagerStateResetting ,
            CBCentralManagerStateUnsupported ,
            CBCentralManagerStateUnauthorized ,
            CBCentralManagerStatePoweredOff ,
            CBCentralManagerStatePoweredOn ,
        } CBCentralManagerState;
     */
        switch central.state{
        case .PoweredOn:
            println("poweredOn")
            
            
        case .PoweredOff:
            printToMyTextView("Central State PoweredOFF")

        case .Resetting:
            printToMyTextView("Central State Resetting")

        case .Unauthorized:
            printToMyTextView("Central State Unauthorized")
        
        case .Unknown:
            printToMyTextView("Central State Unknown")
            
        case .Unsupported:
            printToMyTextView("Central State Unsupported")
            
        default:
            printToMyTextView("Central State None Of The Above")
            
        }
        
    }
    
    
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {

          printToMyTextView(" -- didDiscoverPeripheral -- ")
        
//        printToMyTextView("Description: \(peripheral.description)")
        printToMyTextView("Name: \(peripheral.name)")
        printToMyTextView("RSSI: \(peripheral.RSSI)")
        printToMyTextView("Services: \(peripheral.services)")
        printToMyTextView("Description: \(peripheral.description)")
        
        printToMyTextView("\r")

    }
    
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
          printToMyTextView("didConnectPeripheral")
        //
    }
    
    
    
// Mark   CBPeriperhalManager

    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        //
          printToMyTextView("---didDiscoverServices---")
        
        printToMyTextView("Description: \(peripheral.description)")
        printToMyTextView("Name: \(peripheral.name)")
        printToMyTextView("RSSI: \(peripheral.RSSI)")
        printToMyTextView("Services: \(peripheral.services)")
        printToMyTextView("\r")
        
    }
    
  
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        //
          printToMyTextView("didDiscoverPeripheral")

    }
  
    func peripheral(peripheral: CBPeripheral!, didReadRSSI RSSI: NSNumber!, error: NSError!) {
        //code
          printToMyTextView("didDiscoverCharacteristicsForService")
    
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        //
          printToMyTextView("didUpdateValueForCharacteristic")

    }
    
    
//  Mark UI Stuff
    
    @IBOutlet weak var myTextView: UITextView!
    
    @IBAction func scanSwitch(sender: UISwitch) {
        if sender.on{

        myCentralManager.scanForPeripheralsWithServices(nil, options: nil )
        printToMyTextView("scanning for Peripherals")

          
        }else{
        myCentralManager.stopScan()
        printToMyTextView("stop scanning")
            
        }
    }
    
    func printToMyTextView(passedString: String){
        myTextView.text = passedString + "\r" + myTextView.text
    }
    
}

