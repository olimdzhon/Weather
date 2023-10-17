//
//  DetailsViewController.swift
//  Weather
//
//  Created by Олимджон Садыков on 26/09/23.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - App Outlets
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var userData: UITextField!
    
    // MARK: - Variables & Consts
    let reuseIdentifier = "cell"
    
    var cityName: String = ""
    var degreeValue: String = ""
    var hour: [HourModel] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.1907614172, green: 0.3954713941, blue: 0.556213975, alpha: 1).cgColor, #colorLiteral(red: 0.2383326888, green: 0.4728462696, blue: 0.6649188995, alpha: 1).cgColor]
        gradient.locations = [0.0,1.0]
        gradient.frame = view.frame
        view.layer.insertSublayer(gradient, at: 0)
        
        city.text = cityName
        degree.text = degreeValue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        myView.addGestureRecognizer(viewTap)
        
        let user = defaults.object(forKey: "Name") as? String
        let surname = defaults.object(forKey: "Surname") as? String
        let age = defaults.object(forKey: "Age") as? Int
        print("--------------------------------->")
        print(user)
        print(surname)
        print(age)
    }
    
    // MARK: - App Actions
    @IBAction func buttonClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func recordData(_ sender: UIButton) {
        defaults.set(userData.text!, forKey: "Name")
        defaults.set("Monkey D.", forKey: "Surname")
        defaults.set(25, forKey: "Age")
        
    }
    
    // MARK: - Gesture handle functions
    @objc func viewTap(_ sender: UITapGestureRecognizer? = nil) {
        print("Вы нажали на view")
    }
    
    // MARK: - Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hour.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        cell.myLabel.text = String(hour[indexPath.row].time.dropFirst(11))
        
        AF.request( "https://robohash.org/123.png", method: .get).response { [self] response in
            cell.myImage.image = UIImage(data: response.data!, scale:1)
         }
        
        cell.secondLabel.text = String(hour[indexPath.row].temp_c) + "\u{00B0}"
        
        return cell
    }
    
}

