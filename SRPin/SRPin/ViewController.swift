//
//  ViewController.swift
//  SRPin
//
//  Created by 黄彦棋 on 2019/3/7.
//  Copyright © 2019 Seer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pinView: SRPinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // rhythm 参数 ，true 表示跳动完成后，底部圆圈放大的律动效果
        //              false 完成后不做动画
        self.pinView.jump(rhythmNeed: true)
    }

}

