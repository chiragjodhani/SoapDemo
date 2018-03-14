//
//  SoapResponse.swift
//  SoapDemo
//
//  Created by Eryus Developer on 13/03/18.
//  Copyright © 2018 Eryus Developer. All rights reserved.
//

import Foundation
import ObjectMapper
class SoapResponse: Mappable {
    var CompanyProfile: [CompanyData]?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        CompanyProfile <- map["CompanyProfile"]
    }
}
class CompanyData:  Mappable {
    var CompanyName: String?
    var ContactPerson: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        CompanyName <- map["CompanyName"]
        ContactPerson <- map["ContactPerson"]
    }
}
