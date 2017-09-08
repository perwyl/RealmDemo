//
//  FirstViewController.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {

    @IBOutlet weak var redStepper: UIStepper!
    @IBOutlet weak var greenStepper: UIStepper!
    @IBOutlet weak var blueStepper: UIStepper!

    @IBOutlet weak var redStepperLabel: UILabel!
    @IBOutlet weak var greenStepperLabel: UILabel!
    @IBOutlet weak var blueStepperLabel: UILabel!

    @IBOutlet weak var dbNameTextField: UITextField!

    lazy var viewModel: FirstViewModel = {
        return FirstViewModel()
    }()

    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        redStepper.maximumValue = 255
        redStepper.minimumValue = 0
        redStepper.wraps = true
        redStepper.value = 100

        greenStepper.maximumValue = 255
        greenStepper.minimumValue = 0
        greenStepper.wraps = true
        greenStepper.value = 100

        blueStepper.maximumValue = 255
        blueStepper.minimumValue = 0
        blueStepper.wraps = true
        blueStepper.value = 100

        // Will not trigger notification
        //updateColor()
        updateNotificationListener()

        // will trigger notification
        updateColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func redStepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        redStepperLabel.text = "RED: \(String(describing: value))"

        redStepper.backgroundColor = UIColor(red: value, green: 0, blue: 0)
        updateColor()
    }

    @IBAction func greenStepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        greenStepperLabel.text = "GREEN: \(String(describing: value))"
        greenStepper.backgroundColor = UIColor(red: 0, green: value, blue: 0)
        updateColor()
    }

    @IBAction func blueStepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        blueStepperLabel.text = "BLUE: \(String(describing: value))"
        blueStepper.backgroundColor = UIColor(red: 0, green: 0, blue: value)
        updateColor()
    }

    @IBAction func btnRandomColorTapped(_ sender: Any) {
    }

    func updateColor() {
        let dbColor = DBColor()
        dbColor.blue = Int(blueStepper.value)
        dbColor.red = Int(redStepper.value)
        dbColor.green = Int(greenStepper.value)

        viewModel.updateColor(with: dbColor)
    }

    @IBAction func dbNameDidChanged(_ sender: UITextField) {
        if let dnName = sender.text {
            LocalDatabase.sharedInstance.setDefaultRealm(for: dnName)

            let results = viewModel.getColor()

            // Retrieve the old values
            if let result = results {
                updateUI(with: result)
            } else {
                let dbColor = DBColor()
                dbColor.blue = 100
                dbColor.red = 100
                dbColor.green = 100
                dbColor.id = 1

                viewModel.updateColor(with: dbColor)
            }
            updateNotificationListener()
        }
    }

    func updateUI(with result: DBColor) {
        redStepperLabel.text = "RED: \(String(describing: result.red))"
        redStepper.value = Double(result.red)

        blueStepperLabel.text = "BLUE: \(String(describing: result.blue))"
        blueStepper.value = Double(result.blue)

        greenStepperLabel.text = "GREEN: \(String(describing: result.green))"
        greenStepper.value = Double(result.green)

        view.backgroundColor = UIColor(red: Int(redStepper.value), green: Int(greenStepper.value), blue: Int(blueStepper.value))
    }

    func updateNotificationListener() {
        let realm = try! Realm()

        // object has to be there to listen
        guard let results = realm.object(ofType: DBColor.self, forPrimaryKey: 1) else {
            return
        }

        updateUI(with: results)

        // 'Attempting to modify object outside of a write transaction - call beginWriteTransaction on an RLMRealm
        //results.blue = 90

        token = results.addNotificationBlock{ [weak self] realmCollectionChange in
            switch realmCollectionChange {
            case .change(let changes):
                for property in changes {
                    if property.name == "red" {
                        self?.redStepperLabel.text = "RED: \(String(describing: property.newValue))"
                        self?.redStepper.value = (property.newValue as? Double)!
                    }

                    if property.name == "green" {
                        self?.greenStepperLabel.text = "GREEN: \(String(describing: property.newValue))"
                        self?.greenStepper.value = (property.newValue as? Double)!
                    }

                    if property.name == "blue" {
                        self?.blueStepperLabel.text = "BLUE: \(String(describing: property.newValue))"
                        self?.blueStepper.value = (property.newValue as? Double)!
                    }
                }

                self?.view.backgroundColor = UIColor(red: Int((self?.redStepper.value)!), green: Int((self?.greenStepper.value)!), blue: Int((self?.blueStepper.value)!))
            case .error(let error):
                print("Error \(error)")

            case .deleted:
                print("Value Deleted")
            }
        }
    }
}

