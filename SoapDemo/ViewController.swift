//
//  ViewController.swift
//  SoapDemo
//
//  Created by Eryus Developer on 13/03/18.
//  Copyright © 2018 Eryus Developer. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import StringExtensionHTML
import AEXML
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let soapRequest = AEXMLDocument()
        let envelopeAttributes = ["xmlns:SOAP-ENV" : "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns1" : "http://exportteam.in/"]
        let envelope = soapRequest.addChild(name: "SOAP-ENV:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "SOAP-ENV:Body")
        body.addChild(name: "ns1:CompanyProfile")
        
        let soapLenth = String(soapRequest.xml.count)
        let theURL = NSURL(string: "http://exportteam.in/WebServices/STEService.asmx")
        var mutableR = URLRequest(url: theURL! as URL)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        Alamofire.request(mutableR)
            .responseString { response in
                if let xmlString = response.result.value {
                    let xml = SWXMLHash.parse(xmlString)
                    let body =  xml["soap:Envelope"]["soap:Body"]
                    if let countriesElement = body["CompanyProfileResponse"]["CompanyProfileResult"].element {
                        let getCountriesResult = countriesElement.text
                        print("Response" + getCountriesResult)
                        let user = SoapResponse(JSONString: getCountriesResult)
                        print(user?.CompanyProfile![0].CompanyName)
                    }
                    
                }else{
                    print("error fetching XML")
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

