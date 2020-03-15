//
//  NewsViewModel.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Combine

class NewsViewModel: ObservableObject {
    
    @Published var news: [NewsModel] = []
    
    private var page: Int = 1
    
    private let service: NewsService
    
    init(service: NewsService = NewsService()) {
        self.service = service
        self.loadNews()
    }
    
    func loadNews() {
        service.requestNews(page: page, success: { news in
            self.news.append(contentsOf: news)
            self.page += 1
        }, failure: { error in
            print(error)
        })
    }
}

