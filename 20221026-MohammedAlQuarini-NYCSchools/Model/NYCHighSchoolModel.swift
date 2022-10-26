//
//  NYCHighSchoolModel.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import Foundation

struct NYCHighSchoolModel : Codable {
    let dbn : String?
    let schoolName : String?
    let overveiwParagraph : String?
    let phoneNumber : String?
    let email : String?
    let addressLine1 : String?
    let city : String?
    let state : String?
    let zip : String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overveiwParagraph = "overveiw_paragraph"
        case phoneNumber = "phone_number"
        case email
        case addressLine1 = "primary_address_line_1"
        case city
        case state
        case zip
    }
    
}
