//
//  ContactItem.swift
//  ContactListApp
//
//  Created by 藤治仁 on 2022/03/16.
//

import SwiftUI

struct ContactItem: Identifiable {
    var id = UUID()
    let familyName: String
    let givenName: String
    let phoneNumbers: [String]
}
