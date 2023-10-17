//
//  ViewController.swift
//  Weather
//
//  Created by Олимджон Садыков on 23/09/23.
//

import UIKit
import Alamofire

class MainViewController: UITableViewController  {
    
    let cities = ["DYU", "LBD", "TJU", "KQT"]
    
    var cityData: [CityModel] = []
    
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.1907614172, green: 0.3954713941, blue: 0.556213975, alpha: 1).cgColor, #colorLiteral(red: 0.2383326888, green: 0.4728462696, blue: 0.6649188995, alpha: 1).cgColor]
        gradient.locations = [0.0,1.0]
        gradient.frame = tableView.frame
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
        tableView.backgroundView = backgroundView
        
        for city in cities {
            print("city: \(city)")
            requestTemperatureData(city: city)
        }
        
    }
    
    
    // MARK: - Table view functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.4204627872, green: 0.5546509027, blue: 0.6822960377, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        cell.textLabel?.text = cityData[indexPath.row].name
        cell.detailTextLabel?.text = String(cityData[indexPath.row].time.dropFirst(11))
        
        let temperature = UILabel()
        temperature.text = cityData[indexPath.row].degree
        temperature.sizeToFit()
        temperature.textColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        cell.accessoryView = temperature
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ViewDetailsVC", sender: self)
    }
    
    // MARK: - Function for request data
    func requestTemperatureData(city: String) {
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=4ada8a4df1924e99bc871726230710&q=iata:\(city)", method: .get).response { [self] response in
            
            guard let data = response.data else { return }
            showResponse(data)
            
            do {
                let decoder = JSONDecoder()
                let temperature = try decoder.decode(TemperatureModel.self, from: data)
                print("\n---> Температура из запроса: \(temperature)")
                
                let cityModel = CityModel(name: temperature.location.name, time: temperature.current.last_updated, degree: String(temperature.current.temp_c) + "\u{00B0}", hour: temperature.forecast.forecastday[0].hour)
                
                cityData.append(cityModel)
                tableView.reloadData()

            } catch let err {
                print(err)
            }
        }
    }
    
    func showResponse(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("\n---> response json: " + String(decoding: jsonData, as: UTF8.self))
        } else {
            print("=========> json data malformed")
        }
    }
    
    
    // MARK: - Segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! DetailsViewController
        let selectedRow = tableView.indexPathForSelectedRow!.row
        detailsVC.cityName = cityData[selectedRow].name
        detailsVC.degreeValue = cityData[selectedRow].degree
        detailsVC.hour = cityData[selectedRow].hour
    }
    
    
}

