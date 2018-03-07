//
//  DownloadManager.swift
//  Fruit
//
//  Created by William Robinson on 07/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import UIKit

class DownloadManager {

    let dataEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"

    var defaultSession = URLSession.shared
    var dataTask = URLSessionDataTask()

    func downloadData(completionHandler: @escaping (Data) -> Void) {

        guard
            let urlComponents = URLComponents(string: dataEndpoint),
            let url = urlComponents.url else {
                print("The URL failed to resolve")
                return
        }

        dataTask = defaultSession.dataTask(with: url) { data, response, error in

            if let error = error {
                print("DataTask error: " + error.localizedDescription)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {

                let date = Date()

                DispatchQueue.main.async {

                        print("\n time interval\n\n")
                        print(Date().timeIntervalSince(date))
                        completionHandler(data)
                    }
            } else {
                print("No data")

            }
        }
        dataTask.resume()
    }
}
