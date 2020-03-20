//
//  NewsView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 20.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            NewsList(viewModel: NewsViewModel())
                
            .alert(isPresented: $viewModel.showingError) {
                Alert(title: Text("Упс"),
                      message: Text(viewModel.errorMessage),
                      dismissButton: nil)
            }
            
            .navigationBarTitle("Новости")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
