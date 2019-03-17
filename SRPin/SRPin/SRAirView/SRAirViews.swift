//
//  SRAirView.swift
//  SRPin
//
//  Created by 黄彦棋 on 2019/3/17.
//  Copyright © 2019 Seer. All rights reserved.
//

import UIKit

open class SRAirContentView: UIView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

open class SRAirScrollView:UIScrollView{
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
