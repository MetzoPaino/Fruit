//
//  AnalyticsManager.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

enum AnalyticEvent {
    case download
    case displayTime
    case error

    var queryItem: URLQueryItem {
        let item = "event"
        switch self {
        case .download: return URLQueryItem(name: item, value: "load")
        case .displayTime: return URLQueryItem(name: item, value: "display")
        case .error: return URLQueryItem(name: item, value: "error")
        }
    }
}

class AnalyticsManager {

    private let analyticsEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?"

    func createURLComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "raw.githubusercontent.com"
        urlComponents.path = "/fmtvp/recruit-test-data/master/stats"
        return urlComponents
    }

    func downloadEvent(timeTaken: TimeInterval) -> String? {

        var urlComponents = createURLComponents()
        let queryItem = AnalyticEvent.download.queryItem
        let queryData = URLQueryItem(name: "event", value: "\(timeTaken)")
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents.string
    }

    func displayEvent(timeTaken: TimeInterval) -> String? {

        var urlComponents = createURLComponents()
        let queryItem = AnalyticEvent.displayTime.queryItem
        let queryData = URLQueryItem(name: "event", value: "\(timeTaken)")
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents.string
    }

    func errorEvent(exception: NSException) -> String? {

        let newLine = "\n" // addingPercentEncoding below won't parse %0A correctly

        var dataString = exception.name.rawValue
        dataString.append(newLine)

        if let reason = exception.reason {
            dataString.append(reason)
            dataString.append(newLine)
        }

        let lineLimit = 3

        for (index, stackSymbol) in exception.callStackSymbols.enumerated() {

            // Strip out excess whitespace for more readable url
            let components = stackSymbol.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
            let strippedString = components.joined(separator: " ")

            dataString.append(strippedString + newLine)

            if index >= lineLimit {
                break
            }
        }

        var urlComponents = createURLComponents()
        let queryItem = AnalyticEvent.error.queryItem
        let queryData = URLQueryItem(name: "event", value: dataString)
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents.string
    }
}
