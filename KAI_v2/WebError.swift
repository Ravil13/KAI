//
//  WebError.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

class WebError: NSError {
    
    enum Codes {
        static let somethingWentWrong = 1
    }
    
    static let somethingWentWrong = NSError(domain: "WebError",
                                            code: Codes.somethingWentWrong,
                                            userInfo: [NSLocalizedDescriptionKey: "Что-то пошло не так"])
}
