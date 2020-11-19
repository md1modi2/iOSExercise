//
//  MainViewController+EmptyDataSet.swift
//  Wipro
//
//  Created by hb on 09/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class EmptyDataSet {
    
    class func getTitleAttributedString(_ title:String) -> NSAttributedString {
        return NSAttributedString.init(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22.0 * CGRect.fontRatio), NSAttributedString.Key.foregroundColor : UIColor.gray])
    }
    
    class func getDescriptionAttributedString(_ description:String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        return NSAttributedString.init(string: description, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0 * CGRect.fontRatio), NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.paragraphStyle : paragraph])
    }
    
    class func getButtonTitleAttributedString(_ buttonTitle:String) -> NSAttributedString {
        return NSAttributedString.init(string: buttonTitle, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0 * CGRect.fontRatio), NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
}

extension MainViewController : EmptyDataSetDelegate, EmptyDataSetSource {
    
    func configureEmptyDataSet() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.reloadEmptyDataSet()
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 8.0
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return EmptyDataSet.getTitleAttributedString("Sorry!")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return EmptyDataSet.getDescriptionAttributedString("No Data Found")
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return EmptyDataSet.getButtonTitleAttributedString(NSLocalizedString("Tap to Refresh", comment: ""))
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        doRefresh()
    }

}
