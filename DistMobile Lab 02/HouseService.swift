//
//  PizzaService.swift
//  Activity Week 4
//
//  Created by Jared Johnston on 2025-01-28.
//

import Foundation

public class HouseService{
    private let baseUrl = "https://houseapi-e4bsdwfudjatbyfc.canadaeast-01.azurewebsites.net/houses"
    
    func fetch(id : Int = -1,completion : @escaping (Result<[House], Error>) -> Void){
        guard let url = URL(string: baseUrl + (id == -1 ? "" : "/\(id)")) else {
            completion(.failure(URLError(.badURL)))
            return;
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do{
                let pizza = try JSONDecoder().decode([House].self, from: data)
                completion(.success(pizza))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}
