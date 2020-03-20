//
//  WebError.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

class WebError: NSError {
    
    static let domain = "WebError"
    
    enum Codes {
        static let somethingWentWrong = 1
        static let badResponse = 2
    }
    
    static let somethingWentWrong = NSError(domain: domain,
                                            code: Codes.somethingWentWrong,
                                            userInfo: [NSLocalizedDescriptionKey: "Что-то пошло не так"])
    
    static let badResponse = NSError(domain: domain,
                                     code: Codes.badResponse,
                                     userInfo: [NSLocalizedDescriptionKey : "Неверный ответ"])
}
