//
//  User.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import RealmSwift
import Foundation

struct User: Decodable {
    let login: String
    let name: String
}
