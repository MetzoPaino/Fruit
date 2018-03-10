//
//  DownloadManager.swift
//  Fruit
//
//  Created by William Robinson on 07/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

enum DownloadManagerError: Error {
    case jsonParser
    case urlResolveFailure
    case unknownError
}

class DownloadManager {

    var defaultSession = URLSession.shared
    var dataTask = URLSessionDataTask()

    func downloadData(completionHandler: @escaping ([[String: Any]]?, Error?) -> Void) {

        let dataEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"

        guard let url = try? createURL(string: dataEndpoint) else {
            // NO NO NO
            return
        }

        dataTask = defaultSession.dataTask(with: url) { data, response, error in

            if let error = error {
                completionHandler(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {

                let date = Date()

                DispatchQueue.main.async {


                    do {
                         let json = try parseJSON(data: data)
                        completionHandler(json, nil)
                    } catch {}
                }
            }
        }
        dataTask.resume()
        }




