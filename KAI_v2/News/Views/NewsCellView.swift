//
//  NewsCellView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 15.03.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewsCellView: View {
    
    let newsModel: NewsModel
    @State private var presentingDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(newsModel.fullImageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(newsModel.date ?? "")
                .font(.title)
                .foregroundColor(.blue)
                .padding(.horizontal)
            
            Text(newsModel.title ?? "")
                .font(.headline)
                .padding(.horizontal)
            
            Text(newsModel.subtitle ?? "")
                .padding(.horizontal)
            
            Text("Автор: ")
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Text(newsModel.author ?? "")
                .padding(.horizontal)
                .padding(.bottom)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .sheet(isPresented: $presentingDetail) {
            SafariView(url: self.newsModel.url!)
        }
        .onTapGesture {
            self.presentingDetail.toggle()
        }
    }
}

struct NewsCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NewsCellView(newsModel: NewsModel(title: "«Мне интересно работать в творческой команде»",
                                              subtitle: "Интервью с финалисткой конкурса «Кадровый резерв» Диной Катасёвой.",
                                              imageUrl: "/image/journal/article?img_id=11101025&amp;t=1584108263944",
                                              author: "Ксения Иванова, пресс-служба КНИТУ-КАИ",
                                              date: "13.03 2020", link: ""))
        }
    }
}
