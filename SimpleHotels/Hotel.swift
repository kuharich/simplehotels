//
//  Hotel.swift
//  SimpleHotels
//
//  Created by Mark on 10/21/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import Foundation


struct Hotel {
    var name: String
    var price: String
    var latitude: Double
    var longitude: Double
    var rating: Float
    var imageUrl: String
    let imageDomain = "https://images.trvl-media.com" 
    
    init(fromDictionary: NSDictionary) {
        name = fromDictionary["hotelName" as Any] as? String ?? ""
        if let priceInfo = fromDictionary["lowRateInfo"] as? [String: Any]  {
            price = priceInfo["averageRate"] as! String
        } else {
            price = "(n/a)"
        }
        
        // TODO: check for errors here
        latitude = Double((fromDictionary["latitude" as Any] as! String)) ?? 0.0
        longitude = Double((fromDictionary["longitude" as Any] as! String)) ?? 0.0
        rating = Float((fromDictionary["hotelGuestRating" as Any] as! String)) ?? 0.0
        imageUrl = imageDomain + ((fromDictionary["largeThumbnailUrl" as Any] as? String) ?? "")
    }
}
