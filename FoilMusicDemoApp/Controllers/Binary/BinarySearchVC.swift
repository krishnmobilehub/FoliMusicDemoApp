//
//  BinarySearchVC.swift
//  FoilMusicDemoApp


import UIKit

class BinarySearchVC: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputNumberLabel: UILabel!
    
    var numbers = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.tintColor = .black
        searchTextField.addDoneButtonOnKeyboard()
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        self.inputNumberLabel.text = "Input Number\n\(numbers.description)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.inputNumberLabel.text = ""
        }
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        guard let value: Int = Int(searchTextField.text ?? "") else {
            resultLabel.textColor = .red
            resultLabel.text = "Please enter valid number"
            return
        }
        
        if let index = binarySearch(in: numbers, for: value) {
            resultLabel.textColor = .green
            resultLabel.text = "Found \(value) at index \(index)"
        } else {
            resultLabel.textColor = .red
            resultLabel.text = "Did not find \(value)"
        }
    }
    
    func binarySearch(in numbers: [Int], for value: Int) -> Int? {
        var left = 0
        var right = numbers.count - 1

        while left <= right {
            let middle = Int(floor(Double(left + right) / 2.0))
            if numbers[middle] < value {
                left = middle + 1
            } else if numbers[middle] > value {
                right = middle - 1
            } else {
                return middle
            }
        }
        return nil
    }
}

extension BinarySearchVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        resultLabel.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
