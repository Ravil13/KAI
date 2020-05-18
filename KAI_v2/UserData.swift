//
//  UserData.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 11.05.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    
    @Published var profile = Profile.default
}
