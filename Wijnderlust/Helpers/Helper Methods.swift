//
//  Helper Methods.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 30/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import MapKit

let textFieldColor = UIColor(displayP3Red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
let wijnderlustRed = UIColor(red: 149/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
let inactiveGrey = UIColor(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1.0)
let inactiveRed = UIColor(red: 226/255.0, green: 191/255.0, blue: 191/255.0, alpha: 1.0)
let baseCategory = [YelpCategory(json: ["alias" : "wine_bars", "title": "Wine Bars"])]

extension UITextField {
    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = textFieldColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

//Alert Method
extension UIViewController {
    public func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//Set 'Is Logged In'
extension UserDefaults {
    
    func setCurrentUser(id: String) {
        set(id, forKey: "userId")
    }
    
    func getCurrentUserId() -> String {
        if let userId = string(forKey: "userId") {
            return userId
        }
        
        return ""
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}

//Adjust a map to a set coordinate
func adjustMap(with coordinate: Coordinate, on map: MKMapView) {
    let coordinate2D = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    let span = MKCoordinateRegionMakeWithDistance(coordinate2D, 2000, 2000).span
    let region = MKCoordinateRegion(center: coordinate2D, span: span)
    map.setRegion(region, animated: true)
}

//MARK: Venue Indicators

//Wine Serving?
func doesServeWine(categories: [YelpCategory]) -> Bool {
    var wineResult: Bool = false
    
    for category in categories {
        if wineResult == true {
            continue
        }
        switch category.alias {
        case "wine_bars": wineResult = true
        case "wineries": wineResult = true
        case "winetastingroom": wineResult = true
        case "beer_and_wine": wineResult = true
        case "pubs": wineResult = true
        case "gastropubs": wineResult = true
        case "champagne_bars": wineResult = true
        case "bars": wineResult = true
        case "pianobars": wineResult = true
        default: wineResult = false
        }
    }
    
    if wineResult == true {
        return true
    } else {
        return false
    }
}

//Food Serving?
func doesServeFood(categories: [YelpCategory]) -> Bool {
    var foodResult: Bool = false
    
    for category in categories {
        if foodResult == true {
            continue
        }
        switch category.alias {
        case "food": foodResult = true
        case "acaibowls": foodResult = true
        case "backshop": foodResult = true
        case "bagels": foodResult = true
        case "bakeries": foodResult = true
        case "beer_and_wine": foodResult = true
        case "bento": foodResult = true
        case "beverage_stores": foodResult = true
        case "breweries": foodResult = true
        case "bubbletea": foodResult = true
        case "butcher": foodResult = true
        case "cakeshop": foodResult = true
        case "chimneycakes": foodResult = true
        case "churros": foodResult = true
        case "cideries": foodResult = true
        case "coffee": foodResult = true
        case "coffeeroasteries": foodResult = true
        case "coffeeteasupplies": foodResult = true
        case "convenience": foodResult = true
        case "csa": foodResult = true
        case "cupcakes": foodResult = true
        case "customcakes": foodResult = true
        case "delicatessen": foodResult = true
        case "desserts": foodResult = true
        case "distilleries": foodResult = true
        case "diyfood": foodResult = true
        case "donairs": foodResult = true
        case "donuts": foodResult = true
        case "eltern_cafes": foodResult = true
        case "empanadas": foodResult = true
        case "ethicgrocery": foodResult = true
        case "farmersmarket": foodResult = true
        case "fishmonger": foodResult = true
        case "fooddeliveryservices": foodResult = true
        case "foodtrucks": foodResult = true
        case "friterie": foodResult = true
        case "gelato": foodResult = true
        case "gluhwein": foodResult = true
        case "gourmet": foodResult = true
        case "grocery": foodResult = true
        case "hawkercentre": foodResult = true
        case "honey": foodResult = true
        case "icecream": foodResult = true
        case "importedfood": foodResult = true
        case "internetcafe": foodResult = true
        case "intlgrocery": foodResult = true
        case "jpsweets": foodResult = true
        case "juicebars": foodResult = true
        case "kiosk": foodResult = true
        case "kombucha": foodResult = true
        case "milkshakebars": foodResult = true
        case "nasilemak": foodResult = true
        case "organic_stores": foodResult = true
        case "panzerotti": foodResult = true
        case "piadina": foodResult = true
        case "poke": foodResult = true
        case "pretzels": foodResult = true
        case "salumerie": foodResult = true
        case "shavedice": foodResult = true
        case "shavedsnow": foodResult = true
        case "smokehouse": foodResult = true
        case "streetvendors": foodResult = true
        case "sugarshacks": foodResult = true
        case "tea": foodResult = true
        case "torshi": foodResult = true
        case "tortillas": foodResult = true
        case "waterstores": foodResult = true
        case "wineries": foodResult = true
        case "zapiekanka": foodResult = true
        case "afghani": foodResult = true
        case "african": foodResult = true
        case "andalusian": foodResult = true
        case "arabian": foodResult = true
        case "argentine": foodResult = true
        case "armenian": foodResult = true
        case "asianfusion": foodResult = true
        case "asturian": foodResult = true
        case "australian": foodResult = true
        case "austrian": foodResult = true
        case "baguettes": foodResult = true
        case "bangladeshi": foodResult = true
        case "basque": foodResult = true
        case "bavarian": foodResult = true
        case "bbq": foodResult = true
        case "beergarden": foodResult = true
        case "beerhall": foodResult = true
        case "beisl": foodResult = true
        case "belgian": foodResult = true
        case "bistros": foodResult = true
        case "blacksea": foodResult = true
        case "brasseries": foodResult = true
        case "brazilian": foodResult = true
        case "breakfast_brunch": foodResult = true
        case "british": foodResult = true
        case "buffets": foodResult = true
        case "bulgarian": foodResult = true
        case "burgers": foodResult = true
        case "burmese": foodResult = true
        case "cafes": foodResult = true
        case "cafeteria": foodResult = true
        case "cajun": foodResult = true
        case "cambodian": foodResult = true
        case "canteen": foodResult = true
        case "caribbean": foodResult = true
        case "catalan": foodResult = true
        case "cheesesteaks": foodResult = true
        case "chicken_wings": foodResult = true
        case "chickenshop": foodResult = true
        case "chilean": foodResult = true
        case "chinese": foodResult = true
        case "comfortfood": foodResult = true
        case "corsican": foodResult = true
        case "creperies": foodResult = true
        case "cuban": foodResult = true
        case "currysausage": foodResult = true
        case "cypriot": foodResult = true
        case "czech": foodResult = true
        case "czechslovakian": foodResult = true
        case "danish": foodResult = true
        case "delis": foodResult = true
        case "diners": foodResult = true
        case "dinnertheater": foodResult = true
        case "dumplings": foodResult = true
        case "eastern_european": foodResult = true
        case "eltern_cafes": foodResult = true
        case "ethiopian": foodResult = true
        case "filipino": foodResult = true
        case "fischbroetchen": foodResult = true
        case "fishnchips": foodResult = true
        case "flatbread": foodResult = true
        case "fondue": foodResult = true
        case "food_court": foodResult = true
        case "foodstands": foodResult = true
        case "freiduria": foodResult = true
        case "french": foodResult = true
        case "galician": foodResult = true
        case "gamemeat": foodResult = true
        case "gastropubs": foodResult = true
        case "georgian": foodResult = true
        case "german": foodResult = true
        case "giblets": foodResult = true
        case "gluten_free": foodResult = true
        case "greek": foodResult = true
        case "guamanian": foodResult = true
        case "halal": foodResult = true
        case "hawaiian": foodResult = true
        case "heuriger": foodResult = true
        case "himalayan": foodResult = true
        case "hkcafev": foodResult = true
        case "honduran": foodResult = true
        case "hotdog": foodResult = true
        case "hotdogs": foodResult = true
        case "hotpot": foodResult = true
        case "hungarian": foodResult = true
        case "iberian": foodResult = true
        case "indonesian": foodResult = true
        case "indpak": foodResult = true
        case "international": foodResult = true
        case "irish": foodResult = true
        case "island_pub": foodResult = true
        case "israeli": foodResult = true
        case "italian": foodResult = true
        case "japanese": foodResult = true
        case "jewish": foodResult = true
        case "kebab": foodResult = true
        case "kopitiam": foodResult = true
        case "korean": foodResult = true
        case "kosher": foodResult = true
        case "kurdish": foodResult = true
        case "laos": foodResult = true
        case "laotian": foodResult = true
        case "latin": foodResult = true
        case "lyonnais": foodResult = true
        case "malaysian": foodResult = true
        case "meatballs": foodResult = true
        case "mediterranean": foodResult = true
        case "mexican": foodResult = true
        case "mideastern": foodResult = true
        case "milkbars": foodResult = true
        case "modern_australian": foodResult = true
        case "modern_european": foodResult = true
        case "mongolian": foodResult = true
        case "moroccan": foodResult = true
        case "newamerican": foodResult = true
        case "newcanadian": foodResult = true
        case "newmexican": foodResult = true
        case "newzealand": foodResult = true
        case "nicaraguan": foodResult = true
        case "nightfood": foodResult = true
        case "nikkei": foodResult = true
        case "noodles": foodResult = true
        case "norcinerie": foodResult = true
        case "norwegian": foodResult = true
        case "opensandwiches": foodResult = true
        case "oriental": foodResult = true
        case "pakistani": foodResult = true
        case "panasian": foodResult = true
        case "parma": foodResult = true
        case "persian": foodResult = true
        case "peruvian": foodResult = true
        case "pfcomercial": foodResult = true
        case "pita": foodResult = true
        case "pizza": foodResult = true
        case "polish": foodResult = true
        case "polynesian": foodResult = true
        case "popuprestaurants": foodResult = true
        case "portuguese": foodResult = true
        case "potatoes": foodResult = true
        case "poutineries": foodResult = true
        case "pubfood": foodResult = true
        case "raw_food": foodResult = true
        case "riceshop": foodResult = true
        case "romanian": foodResult = true
        case "rotisserie_chicken": foodResult = true
        case "russian": foodResult = true
        case "salad": foodResult = true
        case "sandwiches": foodResult = true
        case "scandinavian": foodResult = true
        case "schnitzel": foodResult = true
        case "scottish": foodResult = true
        case "seafood": foodResult = true
        case "serbocroatian": foodResult = true
        case "signature_cuisine": foodResult = true
        case "singaporean": foodResult = true
        case "slovakian": foodResult = true
        case "soulfood": foodResult = true
        case "soup": foodResult = true
        case "southern": foodResult = true
        case "spanish": foodResult = true
        case "srilankan": foodResult = true
        case "steak": foodResult = true
        case "sud_ouest": foodResult = true
        case "supperclubs": foodResult = true
        case "sushi": foodResult = true
        case "swabian": foodResult = true
        case "swedish": foodResult = true
        case "swissfood": foodResult = true
        case "syrian": foodResult = true
        case "tabernas": foodResult = true
        case "taiwanese": foodResult = true
        case "tapas": foodResult = true
        case "tapasmallplates": foodResult = true
        case "tavolacalda": foodResult = true
        case "tex-mex": foodResult = true
        case "thai": foodResult = true
        case "tradamerican": foodResult = true
        case "traditional_swedish": foodResult = true
        case "trattorie": foodResult = true
        case "turkish": foodResult = true
        case "ukrainian": foodResult = true
        case "uzbek": foodResult = true
        case "vegan": foodResult = true
        case "vegetarian": foodResult = true
        case "venison": foodResult = true
        case "vietnamese": foodResult = true
        case "waffles": foodResult = true
        case "wok": foodResult = true
        case "wraps": foodResult = true
        case "yugoslav": foodResult = true
        default: foodResult = false
        }
    }
    
    if foodResult == true {
        return true
    } else {
        return false
    }
}

//Offers Rooms?
func doesOfferRooms(categories: [YelpCategory]) -> Bool {
    var roomResult: Bool = false
    
    for category in categories {
        if roomResult == true {
            continue
        }
        switch category.alias {
        case "bedbreakfast": roomResult = true
        case "campgrounds": roomResult = true
        case "guesthouses": roomResult = true
        case "healthretreats": roomResult = true
        case "hotels": roomResult = true
        case "resorts": roomResult = true
        default: roomResult = false
        }
    }
    
    if roomResult == true {
        return true
    } else {
        return false
    }
}

//Location Permissions?
func isAuthorizedForLocation() -> Bool{
    let status = LocationManager.isAuthorized
    
    if status == true {
        return true
    } else {
        return false
    }
}
