//
//  Person.swift
//  iOS_with_restapi (iOS)
//
//  Created by Leng Sopharot on 4/12/21.
//

import SwiftUI
import Foundation
  

struct Person: Codable,  Hashable {
    
    var personid: Int
    var first_name: String
    var last_name: String
    var email: String
    var address: String
    var status: Int
    
}

