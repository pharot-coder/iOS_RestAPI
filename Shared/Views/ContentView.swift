//
//  ContentView.swift
//  Shared
//
//  Created by Leng Sopharot on 4/12/21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HomeView().environmentObject(PersonViewModel())
    }
}

struct HomeView: View {
    //    @StateObject var model = PersonViewModel(
    @EnvironmentObject var model: PersonViewModel
    @State var first_name = ""
    @State var last_name = ""
    @State var email = ""
    @State var address = ""
    @State var isPresentedNewData = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(model.persons, id: \.personid) { person in
                    NavigationLink(
                        destination: DetailView(person: person),
                        label: {
                            VStack(alignment:.leading){
                                Text(person.first_name)
                                    .font(.title)
                                Text(person.last_name)
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                                
                            }.padding(3)
                        })
                }
               
                .onDelete(perform: { indexSet in
                    
                    indexSet.forEach{
                        (index) in
                        model.delete(personid: index)
                        self.model.getData()
                    }
                    
                })
                
            }
            
            .listStyle(InsetListStyle())
           
            .navigationTitle("API Demo")
            .navigationBarItems( leading: leadingButton, trailing: trailingButton )
        }
        .onAppear{
            model.getData()
        }
        .sheet(isPresented: $isPresentedNewData, content: {
            AddDataView(isPresented: $isPresentedNewData, first_name: $first_name, last_name: $last_name, email: $email, address: $address)
        })
       
    }
    
    
    
    var leadingButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: "info")
                .resizable()
                .frame( height: 20)
        })
    }
    
    var trailingButton: some View {
        Button(action: {
            isPresentedNewData.toggle()
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width:20, height: 20)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
