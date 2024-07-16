//
//  DetailView.swift
//  CarsUI
//
//  Created by Владислав Баранов on 08.07.2024.
//

import Foundation
import SwiftUI
struct ModelsView: View {
    let car: Company
    
    @State private var models : [Models] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(models) { model in
                    NavigationLink(
                        destination: DetailView(car: car, model: model),
                        label: {
                            Text(model.name!)
                        }
                    )
                    
                }
            }
            .onAppear{
                Task {
                    do {
                        APIManager.shared.getModels(company: car.car!){result in
                            models = result
                        }
                    }
                }
            }
        }
        .navigationTitle("\(car.car!)")
    }
}

struct ModelsView_Previews: PreviewProvider {
    static var previews: some View {
        ModelsView(car: Company(id: 0, car: "BMW", carModels: [Models(id: 0, name: "X5")]))
    }
}
