//
//  AnalyticsManager.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

/**
 Possible analytic events.

 - Download: Any network request
 - Display: The time it takes from user request to rendering a view.
 - Error: A raised exception or application crash.
 */
enum AnalyticEvent {
    case load
    case display
    case error

    var queryItem: URLQueryItem {
        let queryName = "event"
        switch self {
        case .load: return URLQueryItem(name: queryName, value: "load")
        case .display: return URLQueryItem(name: queryName, value: "display")
        case .error: return URLQueryItem(name: queryName, value: "error")
        }
    }
}

class AnalyticsManager {

    private let queryName = "event"

    /**
     Creates a new URLComponents object for constructing analytic URLs
     - Note: This includes the scheme, host and path
     - Returns: A new URLComponents object pointing towards the analytics endpoint
     */
    func createURLComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "raw.githubusercontent.com"
        urlComponents.path = "/fmtvp/recruit-test-data/master/stats"
        return urlComponents
    }

    /**
     Creates a string for a load event using a TimeInterval object
     - Parameters:
        - timeTaken: Length of time of the download event
     - Returns: A fully constructed url string for sending a load event
     */
    func loadEvent(timeTaken: TimeInterval) -> URLComponents {

        var urlComponents = createURLComponents()
        let queryItem = AnalyticEvent.load.queryItem
        let queryData = URLQueryItem(name: queryName, value: "\(timeTaken.milliseconds())")
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents
    }

    /**
     Creates a string for a display event using a TimeInterval object
     - Parameters:
        - timeTaken: Length of time of the display event
     - Returns: A fully constructed url string for sending a display event
     */
    func displayEvent(timeTaken: TimeInterval) -> URLComponents {

        var urlComponents = createURLComponents()
        let queryItem = AnalyticEvent.display.queryItem
        let queryData = URLQueryItem(name: queryName, value: "\(timeTaken.milliseconds())")
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents
    }

    /**
     Creates a string for an error event using an NSException object.
     - Parameters:
        - exception: The exception thrown.
     - Note: Will attempt to use an exception's name, reason and stack trace for url
     - Returns: A fully constructed url string for sending an error event.
     */
    func errorEvent(exception: NSException) -> URLComponents {

        let newLine = "\n" // urlComponents won't parse %0A correctly

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
        let queryData = URLQueryItem(name: queryName, value: dataString)
        urlComponents.queryItems = [queryItem, queryData]

        return urlComponents
    }
}
