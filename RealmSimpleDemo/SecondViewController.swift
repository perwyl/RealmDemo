//
//  SecondViewController.swift
//  RealmSimpleDemo
//
//  Created by Liu Jinyu on 07.09.17.
//  Copyright © 2017 Liu Jinyu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var viewModel: FirstViewModel = {
        return FirstViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }

    func updateUI() {
        if let results = viewModel.getColor() {
            view.backgroundColor = UIColor(red: results.red, green: results.green, blue: results.blue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SecondViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
