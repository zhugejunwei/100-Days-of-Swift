//
//  WeatherInfo.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/4/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class WeatherInfo: NSObject {
    /*
     base = stations;
     clouds =     {
     all = 1;
     };
     cod = 200;
     coord =     {
     lat = "40.44";
     lon = "-80";
     };
     dt = 1473012581;
     id = 5206379;
     main =     {
     humidity = 47;
     pressure = 1025;
     temp = "78.78";
     "temp_max" = 82; ///
     "temp_min" = 77; ///
     };
     name = Pittsburgh;
     sys =     {
     country = "United States";
     id = 2375;
     message = "0.03";
     sunrise = 1472986279;
     sunset = 1473032755;
     type = 1;
     };
     visibility = 16093;
     weather =     (
     {
     description = "sky is clear";
     icon = 01d;
     id = 800;
     main = Clear; ///
     }
     );
     wind =     {
     deg = 100;
     speed = "6.7";
     };
     */
    
    var main: [String]?
    var name: String?
    var weather: [String]?
    
    init(dic: NSDictionary) {
        super.init()
        self.setValuesForKeysWithDictionary(dic as! [String: AnyObject])
    }
}
