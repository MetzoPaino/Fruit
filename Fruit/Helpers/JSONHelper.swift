//
//  JSONHelper.swift
//  Fruit
//
//  Created by William Robinson on 10/03/2018.
//  Copyright © 2018 William Robinson. All rights reserved.
//

import Foundation

func parseJSON(data: Data) throws -> [[String: Any]] {

    let topLevelKey = "fruit"
    if
        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any],
        let jsonArray =  jsonDictionary[topLevelKey] as? [[String: Any]] {
        return jsonArray
    } else {
        throw DownloadManagerError.jsonParser
    }
}
