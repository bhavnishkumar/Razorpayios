//
//  RazorPayManager.swift
//  RazorPayDemo
//
//  Created by Appinventiv on 12/07/22.
//



//HOW TO USE


import Foundation
import UIKit
import Razorpay

class RazorPayManager: RazorpayProtocol, RazorpayPaymentCompletionProtocol {
    
    //  MARK: VARIABLES - CONSTANTS
    static let sharedInstance = RazorPayManager()
    var razorPayKey: String = "rzp_live_k2FiBtOJLjDDaY" //   YOUR KEY 
    var razorpay: RazorpayCheckout? = nil
    var viewController: UIViewController?
    var completionCallBacks: ((Int32?, String?, String?) -> ())?
    
    // PRIVATE INITILIZER
     private init() {
        razorpay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
    }
    
    // FUNCTIONS
     func showPaymentForm(vwController: UIViewController ,amount: String, currency: String, desc: String, orderId: String, productImage: String, productName: String, contact: String, email: String, themeColorHexCode: String, completionCallBacks: @escaping ((_ errorCode: Int32?, _ errorString: String?, _ successPaymentID: String?) -> ())) {
        
        self.viewController = vwController
        self.completionCallBacks = completionCallBacks

        let options: [String:Any] = [
            "amount": amount,   // This is in currency subunits. 100 = 100 paise = INR 1.
            "currency": currency,   //We support more that 92 international currencies.
            "description": desc,
            "order_id": "",
            "image": productImage,
            "name": productName,
            "prefill": [
                "contact": contact,
                "email": email
            ],
            "theme": [
                "color": themeColorHexCode
            ]
        ]
        if let rzPay = razorpay{
            rzPay.open(options)
        } else {
            debugPrint("Not Created Instance")
        }
       
    }
    
    
    //  MARK: RAZOR PAY COMPLETION PROTOCOL
    func onPaymentError(_ code: Int32, description str: String) {
        debugPrint("Error Code \(code) and Error String \(str)")
        self.completionCallBacks?(code, str, nil)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        debugPrint("Payment ID \(payment_id)")
        self.completionCallBacks?(nil, nil, payment_id)
    }
    
}
