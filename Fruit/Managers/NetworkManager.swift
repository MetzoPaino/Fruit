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
    case invalidResponse
    case unknownError
}

class NetworkManager {

    private var defaultSession = URLSession.shared
    private var dataTask = URLSessionDataTask()

    func downloadData(completionHandler: @escaping ([[String: Any]]?, TimeInterval?, Error?) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "raw.githubusercontent.com"
        urlComponents.path = "/fmtvp/recruit-test-data/master/data.json"

        do {
            let url = try createURL(urlComponents: urlComponents)
            dataTask = defaultSession.dataTask(with: url) { data, response, error in

                if let error = error {
                    completionHandler(nil, nil, error)
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {

                    let date = Date()

                    DispatchQueue.main.async {

                        do {
                            let json = try parseJSON(data: data)
                            completionHandler(json, Date().timeIntervalSince(date), nil)
                        } catch {
                            completionHandler(nil, Date().timeIntervalSince(date), error)
                        }
                    }
                } else {
                    completionHandler(nil, nil, DownloadManagerError.invalidResponse)
                }
            }
            dataTask.resume()

        } catch {
            completionHandler(nil, nil, error)
            return
        }
    }

    func postAnalytic(urlComponents: URLComponents) {
        do {
            let url = try createURL(urlComponents: urlComponents)
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in

                if let error = error {
                    print("DataTask error: " + error.localizedDescription)
                } else if
                    let _ = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {

                    DispatchQueue.main.async {
                        print("Analytic event sent successfully")
                    }
                } else {
                    print("Analytic event failed to send successfully")
                }
            })
            dataTask.resume()
        } catch {
            return
        }
    }

    func createURL(urlComponents: URLComponents) throws -> URL {

        guard let url = urlComponents.url else {
            print("The URL failed to resolve")
            throw DownloadManagerError.urlResolveFailure
        }
        return url
    }
}
