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

class NetworkManager {

    var defaultSession = URLSession.shared
    var dataTask = URLSessionDataTask()

    func downloadData(completionHandler: @escaping ([[String: Any]]?, Error?) -> Void) {

        let dataEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json#"

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

                    print("\n time interval\n\n")
                    self.postEventLoading(string: self.createLoadingEvent(timeTaken: Date().timeIntervalSince(date)))

                    do {
                         let json = try parseJSON(data: data)
                        completionHandler(json, nil)
                    } catch {}
                }
            }
        }
        dataTask.resume()
        }

    func createLoadingEvent(timeTaken: TimeInterval) -> String {

        let analyticsEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?"
        let analyticsEvent = "event=load&data=\(timeTaken)"
        return analyticsEndpoint + analyticsEvent
    }

    func createDisplayEvent(timeTaken: TimeInterval) -> String {

        let analyticsEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?"
        let analyticsEvent = "event=display&data=\(timeTaken)"
        return analyticsEndpoint + analyticsEvent
    }

    func postEventLoading(string: String) {

        guard let url = try? createURL(string: string) else {
            // NO NO NO
            return
        }

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
    }

    func createURL(string: String) throws -> URL {

        guard
            let urlComponents = URLComponents(string: string),
            let url = urlComponents.url else {
                print("The URL failed to resolve")
                throw DownloadManagerError.urlResolveFailure
        }
        return url
    }
}
