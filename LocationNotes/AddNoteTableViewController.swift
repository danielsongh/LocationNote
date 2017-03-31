//
//  AddNoteTableViewController.swift
//  LocationNotes
//
//  Created by Daniel Song on 3/30/17.
//  Copyright © 2017 Daniel Song. All rights reserved.
//

import UIKit


class AddNoteTableViewController: UITableViewController {

    @IBOutlet weak var radiusPicker: UIPickerView!
    
    //List of numbers from 1000 to 10000 incremented by 1000
    var radiusPickerData:[String] = stride(from: 1000, to: 10000, by: 1000).map{ String($0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRadiusPicker()
    }
    
    func setupRadiusPicker() {
        radiusPicker.delegate = self
        radiusPicker.dataSource = self
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
extension AddNoteTableViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return radiusPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return radiusPickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}


extension AddNoteTableViewController: UIPickerViewDelegate{
    
    
}
