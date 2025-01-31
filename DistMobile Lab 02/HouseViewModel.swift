//
//  HouseViewModel.swift
//  DistMobile Lab 02
//
//  Created by Jared Johnston on 2025-01-31.
//

import Foundation

public class HouseViewModel : ObservableObject {
    @Published public var houses : [House] = []
    @Published public var error : String?
    
    private let service = HouseService()
    
    public func fetch(id : Int = -1){
        service.fetch(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let temp):
                    self?.houses = temp
                case .failure(let temp):
                    print(temp)
                    self?.error = temp.localizedDescription
                }
            }
        }
    }
    
}
