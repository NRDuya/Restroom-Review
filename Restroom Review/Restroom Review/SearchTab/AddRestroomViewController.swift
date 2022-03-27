//
//  AddRestroomViewController.swift
//  Restroom Review
//

import UIKit
import FirebaseFirestore
import MapKit

protocol AddRestroomDelegate: AnyObject {
    func addRestroom(restroom: Restroom)
}

class AddRestroomViewController: UIViewController, AddAddressDelegate  {
    weak var delegate: AddRestroomDelegate? = nil
    var address: MKMapItem?
    
    @IBOutlet weak var restroomName: UITextField!
    @IBOutlet weak var restroomPhone: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addressClicked(_ sender: UITextField) {
        performSegue(withIdentifier: "ChangeAddressSegue", sender: self)
    }

    func addAddress(address: MKMapItem) {
        self.address = address
        addressText.text = address.placemark.title
    }
    
    @IBAction func addRestroomClicked(_ sender: UIButton) {
        guard let name: String = restroomName.text, !name.isEmpty else {
            return
        }
        guard let phone: String = restroomPhone.text else {
            return
        }
        guard let address: MKMapItem = address else {
            return
        }
        
        guard let addressName = address.placemark.title else {
            return
        }
        
        let coordinates = address.placemark.coordinate
        let location = GeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let newRestroom: Restroom = Restroom(name: name, location: location, address: addressName, phone: phone, hours: nil)
        
        delegate?.addRestroom(restroom: newRestroom)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addAddressVC = segue.destination as? AddAddressViewController {
            addAddressVC.delegate = self
            addAddressVC.address = address?.placemark.title
        }
        
    }
}
