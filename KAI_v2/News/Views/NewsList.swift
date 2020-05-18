//
//  NewsList.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct NewsList: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.news) { newsModel in
                NewsCellView(newsModel: newsModel)
            }
            
            Button(action: {
                self.viewModel.loadNews()
            }) {
                if viewModel.isNextPageLoading || viewModel.isLoading {
                    Text("Загружаю")
                } else {
                    Text("Загрузить еще")
                }
            }.disabled(viewModel.isNextPageLoading || viewModel.isLoading)
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList(viewModel: NewsViewModel())
    }
}
