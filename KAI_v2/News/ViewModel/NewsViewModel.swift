//
//  NewsViewModel.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Combine

class NewsViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var isNextPageLoading = false
    @Published var showingError = false
    @Published var errorMessage = "Что-то пошло не так"
    @Published var news: [NewsModel] = []
    
    private var page: Int = 1
    
    private let service: NewsService
    
    init(service: NewsService = NewsService()) {
        self.service = service
        self.loadNews()
    }
    
    func loadNews() {
        if page == 1 {
            isLoading = true
        } else {
            isNextPageLoading = true
        }
        showingError = false
        service.requestNews(page: page, success: { news in
            self.news.append(contentsOf: news)
            self.page += 1
            self.isLoading = false
            self.isNextPageLoading = false
        }, failure: { error in
            self.isLoading = false
            self.isNextPageLoading = false
            self.showingError = true
            self.errorMessage = error.localizedDescription
        })
    }
}

