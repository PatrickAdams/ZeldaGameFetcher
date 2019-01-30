//
//  ZeldaGameFetcher.swift
//  KS
//
//  Created by Patrick Adams on 1/30/19.
//  Copyright © 2019 Sure, Inc. All rights reserved.
//

import UIKit

class ZeldaGameFetcher: NSObject {
    
    class func fetchZeldaGames(completionHandler: @escaping ([ZeldaGame]?, Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var giantBombUrl = URL(string: "https://www.giantbomb.com/api/search/")
        let URLParams = [
            "api_key": "3fcbb59495873947a3f376447585a2d618737842",
            "format": "json",
            "query": "The Legend of Zelda",
            "resources": "game",
            "field_list": "name,image,deck",
            "limit": "50",
            ]
        giantBombUrl = giantBombUrl!.appendingQueryParameters(URLParams)
        var request = URLRequest(url: giantBombUrl!)
        request.httpMethod = "GET"
        request.addValue("sat=fc78d8b651357b38785f4e035cc60c55; device_view=full", forHTTPHeaderField: "Cookie")
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                do {
                    let retrievedJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let results =  retrievedJson["results"] as! [[String:Any]]
                    var games = [ZeldaGame]()
                    
                    for result in results {
                        
                        let newGame = ZeldaGame()
                        newGame.info = result["deck"] as? String
                        newGame.name = result["name"] as? String
                        let imageDict = result["image"] as? [String:Any]
                        newGame.thumbUrl = imageDict!["icon_url"] as? String
                        
                        if (newGame.name?.contains("The Legend of Zelda"))! {
                            games.append(newGame)
                        }
                    }
                    
                    completionHandler(games, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
            else {
                completionHandler(nil, error)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
