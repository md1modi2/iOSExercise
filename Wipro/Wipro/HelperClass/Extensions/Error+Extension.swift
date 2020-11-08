//
//  Error+Extension.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation

extension NSError {
    static func customError(with code: Int, message: String) -> Error? {
        let error = NSError(domain:"com.app.wipro", code:code, userInfo:[ NSLocalizedDescriptionKey: message])
        return error
    }
}
