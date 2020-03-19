//
//  NewsList.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct NewsList: View {
    
    @ObservedObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                if viewModel.isLoading {
                    LoadingView()
                }
                
                ForEach(viewModel.news) { newsModel in
                    NewsView(newsModel: newsModel)
                }
                
                Button(action: {
                    self.viewModel.loadNews()
                }) {
                    if viewModel.isNextPageLoading {
                        Text("Загружаю")
                    } else {
                        Text("Загрузить еще")
                    }
                }.disabled(viewModel.isNextPageLoading)
            }
            .navigationBarTitle("Новости")
            
            .alert(isPresented: $viewModel.showingError) {
                Alert(title: Text("Упс"),
                      message: Text(viewModel.errorMessage),
                      dismissButton: nil)
            }
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
