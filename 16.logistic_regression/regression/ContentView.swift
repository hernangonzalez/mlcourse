//
//  ContentView.swift
//  regression
//
//  Created by Hernan G. Gonzalez on 27/12/2019.
//  Copyright © 2019 Indeba. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var model = ContentModel()

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            ChartView(model: model.chart)
                .background(Color.gray)
        }
        .onAppear(perform: model.loadPredictions)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
