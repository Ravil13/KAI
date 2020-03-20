//
//  NewsService.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 17.02.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation
import SwiftSoup

enum NewsEndpoint: Endpoint {
    
    case news(page: Int)
    
    var urlComponents: URLComponents? {
        switch self {
        case .news:
            return URLComponents(string: "https://kai.ru/news")
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .news(let page):
            return ["p_p_id": "56_INSTANCE_auCw7LKENgM7",
                    "p_p_lifecycle": "2",
                    "p_p_state": "normal",
                    "p_p_mode": "view",
                    "p_p_cacheability": "cacheLevelPage",
                    "p_p_col_id": "column-1",
                    "p_p_col_count": "1",
                    "page": "\(page)",
                    "tag": "0",
                    "refresh": "false",
                    "endDate": CurrentDay.stringDate()]
        }
    }
}

class NewsService {
    
    func requestNews(page: Int,
                     success: @escaping ([NewsModel]) -> Void,
                     failure: @escaping ErrorClouser) {
        
        let newsEndpoint: NewsEndpoint = .news(page: page)
        API.requestHTML(endpoint: newsEndpoint, success: { [weak self] html in
            guard let self = self else { return }
            success(self.parseNews(from: html))
        }, failure: failure)
    }
    
    private func parseNews(from html: String) -> [NewsModel] {
        
        let doc = try? SwiftSoup.parse(html)
        let items = try? doc?.getElementsByClass("item")
        
        let news = items?.map { item -> NewsModel in
            let title = try? item.getElementsByClass("title").first()?.getElementsByTag("p").first()?.text()
            let pic = try? item.getElementsByClass("pic").first()
            let subtitle = try? item.getElementsByClass("short").first()?.text()
            let date = try? item.getElementsByClass("date").first()?.text()
            let author = try? item.getElementsByClass("creds").first()?.getElementsByTag("p").first()?.text()
            
            let image = try? pic?.getElementsByTag("img").first()
            let imageURL = try? image?.attr("src")
            
            let link = try? item.attr("href")
            
            
            return NewsModel(title: title,
                             subtitle: subtitle,
                             imageUrl: imageURL,
                             author: author,
                             date: date,
                             link: link)
        }
        
        return news ?? []
    }
}

