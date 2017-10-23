//
//  HotelsViewController.swift
//  SimpleHotels
//
//  Created by Mark Kuharich on 10/21/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import UIKit

class HotelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var hotels = [Hotel]()
    
    @IBOutlet weak var citySegementedControl: UISegmentedControl!
    @IBOutlet weak var hotelsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelsTable.delegate = self
        let city = citySegementedControl.titleForSegment(at: citySegementedControl.selectedSegmentIndex)!
        HotelAPI.shared.getHotels(withCity: city, completionHandler: gotHotels)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func cityChanged(_ sender: Any) {
        let city = citySegementedControl.titleForSegment(at: citySegementedControl.selectedSegmentIndex)!
        print(city)
        HotelAPI.shared.getHotels(withCity: city, completionHandler: gotHotels)
    }

    func gotHotels(_ hotels: [Hotel]?) -> Void {
        guard let hotels = hotels else {
            return
        }
        self.hotels = hotels
        hotelsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCell") as! HotelCellTableViewCell
        let hotel = hotels[indexPath.row]
        print("Got hotel: ", hotel.name)
        cell.nameLabel.text = hotel.name
        cell.priceLabel.text = "$" + hotel.price
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let details = storyboard?.instantiateViewController(withIdentifier: "HotelDetail") as? DetailViewController {
            details.hotelDetails = hotels[indexPath.row]
            navigationController?.pushViewController(details, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
