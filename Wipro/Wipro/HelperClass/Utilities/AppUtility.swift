//
//  AppUtility.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit
import SwiftMessages

class AppUtility: NSObject {
    static func showToastMessage(_ message: String?, isSuccess: Bool) {
        DispatchQueue.main.async(execute: { () -> Void in
            SwiftMessagesHelper.showMessageWith(title: nil, subTitle: message, theme: (isSuccess ? .success : .error))
        })
    }
}


class SwiftMessagesHelper: NSObject {
    class func showMessageWith(title : String?, subTitle : String?, theme : Theme?) {
        var config = SwiftMessages.defaultConfig
        let wordsCount = subTitle?.components(separatedBy: .whitespacesAndNewlines).count ?? 0
        let seconds = (Double(wordsCount) * 0.3)
        config.duration = .seconds(seconds: seconds > 2 ? seconds : 2)
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        let messageView = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        messageView.bodyLabel?.text = subTitle
        messageView.titleLabel?.text = title
        if let messageTheme = theme {
            if messageTheme == .success {
                messageView.configureTheme(backgroundColor: UIColor.green, foregroundColor: UIColor.white)
            } else if messageTheme == .error {
                messageView.configureTheme(backgroundColor: UIColor.red, foregroundColor: UIColor.white)
            } else {
                messageView.configureTheme(messageTheme, iconStyle: .subtle)
            }
        }
        messageView.titleLabel?.isHidden = title == nil
        messageView.bodyLabel?.isHidden = subTitle == nil
        messageView.button?.isHidden = true
        SwiftMessages.show(config: config, view: messageView)
    }
}
