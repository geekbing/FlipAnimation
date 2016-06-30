//
//  Second.swift
//  FlipAnimation
//
//  Created by Bing on 6/30/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class Second: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 大图
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        imageView.image = UIImage(named: "second")
        self.view.addSubview(imageView)
        
        // Back按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: screenHeight * 0.75, width: 200, height: 40))
        backBtn.center.x = self.view.center.x
        backBtn.setTitle("Back", forState: .Normal)
        backBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backBtn.backgroundColor = UIColor.redColor()
        backBtn.layer.masksToBounds = true
        backBtn.layer.cornerRadius = 20
        backBtn.addTarget(self, action: .backBtnClick, forControlEvents: .TouchUpInside)
        self.view.addSubview(backBtn)
    }
    
    // 点击Back按钮
    func backBtnClick()
    {
        (self.transitioningDelegate as! UIViewController).dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

private extension Selector
{
    static let backBtnClick = #selector(Second.backBtnClick)
}
