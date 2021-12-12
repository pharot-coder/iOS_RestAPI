//
//  AddDataView.swift
//  iOS_with_restapi (iOS)
//
//  Created by Leng Sopharot on 6/12/21.
//

import SwiftUI

struct AddDataView: View {
    //    @StateObject var model = PersonViewModel()
    @EnvironmentObject var model: PersonViewModel
    @Binding var isPresented: Bool
    @Binding var first_name: String
    @Binding var last_name: String
    @Binding var email: String
    @Binding var address: String
    @State var isAlert = false
    var body: some View {
        NavigationView{
            ZStack{
                Color(.gray).opacity(0.1).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment:.leading){
                    Text("Create New Data")
                        .font(Font.system(size: 16, weight: .bold))
                    
                    TextField("First Name", text:$first_name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Last Name", text:$last_name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Email", text:$email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Address", text:$address)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $isAlert, content: {
                    let title = Text("Error")
                    let message = Text("Please input data before add")
                    return Alert(title: title, message: message)
                })
            }
            .navigationTitle("New Data")
            .navigationBarItems(leading: leadingButton, trailing: trailingButton)
        }  .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var leadingButton: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel")
                .font(Font.system(size: 16, weight: .bold))
        })
    }
    
    var trailingButton: some View {
        Button(action: {
            if first_name == "" && last_name == "" && email == "" && address == ""{
                isAlert.toggle()
            }else{
                let parameter: [String: Any] = ["first_name":first_name, "last_name":last_name, "email":last_name, "address": address]
                model.store(parameter: parameter)
                model.getData()
                isPresented.toggle()
                first_name = ""
                last_name = ""
                email = ""
                address = ""
            }
        }, label: {
            Text("Save")
                .font(Font.system(size: 16, weight: .bold))
        })
    }
}

//struct AddDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDataView()
//    }
//}
