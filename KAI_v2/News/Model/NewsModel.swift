//
//  NewsModel.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

struct NewsModel: Identifiable {
    let id = UUID()
    let title: String?
    let subtitle: String?
    let imageUrl: String?
    let author: String?
    let date: String?
    let link: String?
    
    var fullImageUrl: URL? {
        URL(string: "https://kai.ru" + (self.imageUrl ?? ""))
    }
    
    var url: URL? {
        URL(string: "https://kai.ru/" + (self.link ?? ""))
    }
}
