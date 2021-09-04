//
//  QRCodeScanBusinessCardHandler.swift
//  LTXiOSUtilsDemo
//  名片Handler，加好友
//  Created by CoderStar on 2021/6/2.
//  Copyright © 2021 CoderStar. All rights reserved.
//

import Foundation

public class QRCodeScanBusinessCardHandler: QRCodeScanHandler {
    public var nextHandler: QRCodeScanHandler?

    public func handle(info: Any?) -> Bool? {
        guard let dict = info as? [String: String], let type = dict["type"], type == "businessCard" else {
            return nextHandler?.handle(info: info)
        }
        print("名片码")
        return true
    }

    public init() {

    }
}
