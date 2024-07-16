//
//  DetailView.swift
//  CarsUI
//
//  Created by Владислав Баранов on 08.07.2024.
//

import Foundation
import SwiftUI
struct DetailView: View {
    
    var car : Company
    var model : Models
    
    @State private var info : String = ""
    @State private var imageName : Image = Image("default")
    @State private var currentModel : Models = Models(name: "", info: "")
    
    var body: some View {
        VStack {
            imageName
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .padding(8)
            ScrollView {
                Text(currentModel.info!)
                    .padding(8)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        } .onAppear() {
            Task {
                let infoResult = await APIManager.shared.getInfo(company: car.car!, model: model.name!){ infoResult in
                    currentModel = infoResult
                    
                    let imageResult = APIManager.shared.getImage(picName: currentModel.imageName!){ imageResult in
                        imageName = imageResult
                    }
                }
            }
        }
        .navigationTitle("\(car.car!) \(model.name!)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(car: Company(id: 0, car: "BMW", carModels: [Models(name: "X5")]), model: Models(id: 0, name: "X5", info: "someinfo", imageName: "bmw_x5"))
    }
}


