//
//  AnalyticsManager.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

enum AnalyticEvent: Error {
    case download
    case displayTime
    case error

    func eventString() -> String {
        switch self {
        case .download: return "load"
        case .displayTime: return "display"
        case .error: return "error"
        }
    }
}

class AnalyticsManager {

    private let analyticsEndpoint = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?"

    func downloadEvent(timeTaken: TimeInterval) -> String {
        let analyticsEvent = "event=\(AnalyticEvent.eventString(.download))&data=\(timeTaken)"
        return analyticsEndpoint + analyticsEvent
    }

    func displayEvent(timeTaken: TimeInterval) -> String {
        let analyticsEvent = "event=\(AnalyticEvent.eventString(.displayTime))&data=\(timeTaken)"
        return analyticsEndpoint + analyticsEvent
    }

    func errorEvent(exception: NSException) -> String {

        var reason = "UnknownExceptionReason"
        if let exceptionReason = exception.reason {
            reason = exceptionReason
        }

        let analyticsEvent = "event=\(AnalyticEvent.eventString(.error))&data=\(reason)"
        return analyticsEndpoint + analyticsEvent
    }
}
