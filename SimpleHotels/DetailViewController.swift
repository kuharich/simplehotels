//
//  DetailViewController.swift
//  SimpleHotels
//
//  Created by Mark Kuharich on 10/22/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    
    var hotelDetails: Hotel?
    
    @IBAction func viewOnMapTapped(_ sender: Any) {
        if let mapView = storyboard?.instantiateViewController(withIdentifier: "MapView") as? MapViewController {
            mapView.hotelDetails = hotelDetails
            navigationController?.pushViewController(mapView, animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        if let hotel = hotelDetails {
            name.text = hotel.name
            rating.textAlignment = NSTextAlignment.right
            rating.text = "Rating: " + String(hotel.rating) + " "
            cosmosView.rating = Double(hotel.rating)
            price.text = "$" + hotel.price
            
            guard let url = URL(string: hotel.imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.hotelImage.image = UIImage(data: data!)
                }
            }.resume()
        }
        
    }

}
