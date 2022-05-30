//
//  InsertViewController.swift
//  TODO
//
//  Created by Wojtek Rempiński on 29/05/2022.
//

import Foundation
import UIKit

class InsertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var insertTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!

    var delegate: AddTaskProtocol?
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.setValue(UIColor(named: Constans.mainColor), forKeyPath: "textColor")
        datePicker.minimumDate = Date.now
        datePicker.setValue(UIColor(named: Constans.mainColor), forKeyPath: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        insertTextField.backgroundColor = .white
        insertTextField.delegate = self
        insertTextField.textColor = UIColor(named: Constans.mainColor)
        insertTextField.attributedPlaceholder = NSAttributedString(
            string: "Wpisz nazwe zadania",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let text = insertTextField.text, text.isEmpty {
             let dialogMessage = UIAlertController(title: "Uwaga", message: "Uzupełnij nazwę zadania", preferredStyle: .alert)
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
             dialogMessage.addAction(ok)
             self.present(dialogMessage, animated: true, completion: nil)
        }else{
            let label = insertTextField.text
            let date = datePicker.date
            let category = pickerData[categoryPicker.selectedRow(inComponent: 0)]
            delegate?.addTask(title: label!, date: date, category: category)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate extensions
extension InsertViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}

//MARK: - AlertSavingProtocol extensions
extension InsertViewController: AlertSavingProtocol{
    func showFailureAlert() {
        let dialogMessage = UIAlertController(title: "BŁĄD", message: "Niepowodzenie zapisu zadania", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func showSuccessAlert() {
        let dialogMessage = UIAlertController(title: "Informacja", message: "Pomyślnie dodano zadanie", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.delegate?.reload()
         })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
