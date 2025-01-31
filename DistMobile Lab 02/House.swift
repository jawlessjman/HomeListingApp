//
//  House.swift
//  DistMobile Lab 02
//
//  Created by Jared Johnston on 2025-01-31.
//

import Foundation

public class House : Identifiable, Codable{
    public var id : Int
    public var imageUrl : String
    public var sold : Bool
    public var postingDate : String
    public var price : Int
    public var likes : Int
    public var details : String
    public var address : String
    public var company : String
}
