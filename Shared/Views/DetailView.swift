//
//  DetailView.swift
//  iOS_with_restapi (iOS)
//
//  Created by Leng Sopharot on 7/12/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presenttationMode
    @EnvironmentObject var model: PersonViewModel
    @State var personId:Int = 0
    @State var first_name = ""
    @State var last_name = ""
    @State var email = ""
    @State var address = ""
    @State var isAlert = false
  
    let person: Person
    var body: some View {
        NavigationView{
            ZStack{
                Color(.gray).opacity(0.1).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment:.leading){
                    Text("Edit Data")
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
            .navigationBarItems(trailing: trailingButton)
        }  .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            self.first_name = person.first_name
            self.last_name = person.last_name
            self.email = person.email
            self.address = person.address
            self.personId = person.personid
        }
    }
 
    var trailingButton: some View {
        Button(action: {
            if first_name == "" && last_name == "" && email == "" && address == ""{
                isAlert.toggle()
            }else{
                let parameter: [String: Any] = ["first_name":first_name, "last_name":last_name, "email":last_name, "address": address]
                let personId = personId
                model.edit(parameter: parameter, personid: personId)
                self.model.getData()
                presenttationMode.wrappedValue.dismiss()
            }
        }, label: {
            Text("Save")
                .font(Font.system(size: 16, weight: .bold))
        })
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
