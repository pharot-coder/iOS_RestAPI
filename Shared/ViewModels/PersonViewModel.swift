//
//  PersonViewModel.swift
//  iOS_with_restapi (iOS)
//
//  Created by Leng Sopharot on 4/12/21.
//

import Foundation
import SwiftUI

class PersonViewModel: ObservableObject {
    @Published var persons = [Person]()
    
    func getData() {
        let url = "https://pharot-api.000webhostapp.com/api/person"
        
        guard let urlString = URL(string: url) else {
            return
        }
        
         let task = URLSession.shared.dataTask(with: urlString) {[weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let persons = try JSONDecoder().decode([Person].self, from: data)
                
                DispatchQueue.main.async {
                    self?.persons = persons
                }
                
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func store(parameter: [String: Any]){
        
        let url = "https://pharot-api.000webhostapp.com/api/person"
        
        guard let urlString = URL(string: url) else {
            print("Url not found")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameter)
        
        var req = URLRequest(url: urlString)
        req.httpMethod = "POST"
        req.httpBody = data
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("applicaion/json", forHTTPHeaderField: "Accept")
    
        let task = URLSession.shared.dataTask(with: req) {data, _, error in
            
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                let persons = try JSONDecoder().decode([Person].self, from: data)
                
                DispatchQueue.main.async {
                   print(persons)
                }
                
            }catch{
                print("Error")
            }
        }
        task.resume()
    }
    
    
    func edit(parameter: [String: Any], personid: Int){
        
        let url = "https://pharot-api.000webhostapp.com/api/person\(personid)"
        
        guard let urlString = URL(string: url) else {
            print("Url not found")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameter)
        
        var req = URLRequest(url: urlString)
        req.httpMethod = "PUT"
        req.httpBody = data
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("applicaion/json", forHTTPHeaderField: "Accept")
    
        let task = URLSession.shared.dataTask(with: req) {data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let persons = try JSONDecoder().decode(Person.self, from: data)
                
                DispatchQueue.main.async {
                   print(persons)
                }
                
            }catch let JsonError{
                print("Error :", JsonError.localizedDescription)
            }
        }
        task.resume()
    }
    
    func delete(personid: Int){
        
        let url = "https://pharot-api.000webhostapp.com/api/person\(personid)"
        
        guard let urlString = URL(string: url) else {
            print("Url not found")
            return
        }
                
        var req = URLRequest(url: urlString)
        req.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: req) {data, _, error in
            
            guard let data = data, error == nil else {
                
                return
            }
         
            do {
                let persons = try JSONDecoder().decode(Person.self, from: data)
                
                DispatchQueue.main.async {
                   print(persons)
                }
                
            }catch let JsonError{
                print("Error :", JsonError.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
}
