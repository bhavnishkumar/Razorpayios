//
//  ViewController.swift
//  RazorPayDemo
//
//  Created by Appinventiv on 12/07/22.
//

import UIKit
import Razorpay

class ViewController: UIViewController {
    
    //  MARK: UI - VIEW CONTROLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //  MARK: BTTON ACTIONS
    @IBAction func onClickBuy(_ sender: UIButton) {
        
        RazorPayManager.sharedInstance.showPaymentForm(vwController: self, amount: "0", currency: "INR", desc: "purchase description", orderId: "order_DBJOWzybf0sJbb", productImage: "https://url-to-image.png", productName: "MTH", contact: "9797979797", email: "foo@bar.com", themeColorHexCode: "#F37254") { [weak self] errCode, errStr, successID in
            
            guard let _ = self else { return }
            
            if let errorCode = errCode, let errorString = errStr {
                debugPrint("Error Code: \(errorCode) and Error String: \(errorString)")
            }
            
            if let successPaymentID = successID {
                debugPrint("Success Payment Id: : ",successPaymentID)
            }
        }
    }
}
