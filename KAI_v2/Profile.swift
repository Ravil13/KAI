//
//  Profile.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 11.05.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

struct Profile {
    var name: String
    var surname: String
    var group: String
    var groupId: String
    var birthDate: Date
    
    var fullName: String {
        surname.capitalized + " " + name.capitalized
    }
    
    static let `default` = Profile(name: "Равиль",
                                   surname: "Вильданов",
                                   group: "4435",
                                   groupId: "",
                                   birthDate: Date())
}
