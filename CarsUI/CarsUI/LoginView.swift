//
//  loginView.swift
//  CarsUI
//
//  Created by Владислав Баранов on 09.07.2024.
//

import Foundation
import SwiftUI


struct LoginView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var shouldShowNewScreen = false

    
    
    var body: some View {
        if shouldShowNewScreen {
           
            ContentView()
            
        } else {
            VStack {
                Spacer()
                Spacer()
                Text("Welcome")
                    .bold()
                Spacer()
                TextField("Email", text: $email)
                    .textFieldStyle(.plain)
                    .bold()
                    .padding(8)
                Rectangle()
                    .frame(height: 1)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                SecureField("Password", text: $password)
                    .padding(8)
                    .textFieldStyle(.plain)
                    .bold()
                Rectangle()
                    .frame(height: 1)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                Spacer()
                Button {
                    APIManager.shared.register(email: email, password: password) { isLogin in
                        if isLogin == true {
                            shouldShowNewScreen = true
                        }
                        
                    }
                } label: {
                    Text("Регистрация")
                        .frame(width: 200, height: 40)
                        .bold()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.red))
                            
                        )
                        .foregroundColor(.white)
                }
                .padding(8)
                
                Button {
                    APIManager.shared.login(email: email, password: password){ isLogin in
                        if isLogin == true {
                            shouldShowNewScreen = true
                        }
                    }
                } label: {
                    Text("Уже есть аккаунт? Войти")
                        .foregroundStyle(.black)
                }
                .padding(8)
                
                Spacer()
                Spacer()
            }
//            
//            .sheet(isPresented: $shouldShowNewScreen) {
//                ContentView()
//            }
            
            
        }
    }
    
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


