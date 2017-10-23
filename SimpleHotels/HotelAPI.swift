//
//  HotelAPI.swift
//  SimpleHotels
//
//  Created by Mark on 10/21/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let chicagoUri = "https://techblog.expedia.com/utility/chicago-hotels.json"
fileprivate let sfUri = "https://techblog.expedia.com/utility/san-francisco-hotels.json"

fileprivate let cityDict = ["san francisco" : sfUri,
                            "chicago" : chicagoUri]
class HotelAPI {
    static let shared = HotelAPI()
    
    fileprivate init() { }
    
    
    let hotelDict = [ "" : "" ]
    
    func getHotels(withCity: String, completionHandler: @escaping ([Hotel]?) -> Void) {
        guard let uri = cityDict[withCity.lowercased()] else  {
            // TODO: throw error probably
            print("Sorry I don't know this city")
            completionHandler([Hotel]())
            return
        }
        var hotels = [Hotel]()
        
        Alamofire.request(uri).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value as? NSDictionary {
                    let json = result["hotels" as Any] as! [Any]
                    let jsonEntries = json as! [NSDictionary]
                    for entry in jsonEntries {
                        let hotel = Hotel(fromDictionary: entry)
                        hotels.append(hotel)
                    }
                }
            case .failure(let error):
                print(error)
            }
            completionHandler(hotels)
        }
    }
}
