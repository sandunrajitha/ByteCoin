//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        pickerView.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        /* this returns the number of components picker view should have
         ex: HH:MM:SS picker should have 3 components */
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
        
        /* this method is used to return the number of rows each component should have
         as an example:
         
         switch component {
         case 0:
                5
         case 1:
                10
         case 2:
                15
         default:
             return "bla"
         }
         
         first component will have 5 rows, second will have 10 rows, third 15 rows, etc...
         */
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(component)
        //print(row)
        switch component {
        case 0:
            return coinManager.currencyArray[row]
        default:
            return "_"
        }
    }
    
}

// MARK: - UIPickerViewDelegate


extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(coinManager.currencyArray[row])")
        coinManager.fetchExchangeRate(for: coinManager.currencyArray[row])
    }
}
