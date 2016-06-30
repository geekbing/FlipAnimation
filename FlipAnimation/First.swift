//
//  First.swift
//  FlipAnimation
//
//  Created by Bing on 6/30/16.
//  Copyright © 2016 Bing. All rights reserved.
//


import UIKit

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

class First: UIViewController
{
    // 百分比变换
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        self.view.backgroundColor = UIColor.whiteColor()
     
        // 大图
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        imageView.image = UIImage(named: "first")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        // Next按钮
        let nextBtn = UIButton(frame: CGRect(x: 0, y: screenHeight * 0.75, width: 200, height: 40))
        nextBtn.center.x = self.view.center.x
        nextBtn.setTitle("Next", forState: .Normal)
        nextBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nextBtn.backgroundColor = UIColor.redColor()
        nextBtn.layer.masksToBounds = true
        nextBtn.layer.cornerRadius = 20
        nextBtn.addTarget(self, action: .nextBtnClick, forControlEvents: .TouchUpInside)
        self.view.addSubview(nextBtn)
        
        // 给First VC增加左滑手势
        self.addScreenEdgePanGestureRecognizer(self.view, edges: .Right)
    }
    
    // 点击Next按钮
    func nextBtnClick()
    {
        let vc = Second()
        vc.transitioningDelegate = self
        // 给Second VC增加右滑手势
        self.addScreenEdgePanGestureRecognizer(vc.view, edges: .Left)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 边缘手势
    func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer)
    {
        let progress = abs(edgePan.translationInView(UIApplication.sharedApplication().keyWindow!).x) / screenWidth
        
        if edgePan.state == .Began
        {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            if edgePan.edges == .Right
            {
                let vc = Second()
                vc.transitioningDelegate = self
                // 给Second VC增加右滑手势
                self.addScreenEdgePanGestureRecognizer(vc.view, edges: .Left)
                self.presentViewController(vc, animated: true, completion: nil)
            }
            else if edgePan.edges == .Left
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        else if edgePan.state == .Changed
        {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        }
        else if edgePan.state == .Cancelled || edgePan.state == .Ended
        {
            if progress > 0.5
            {
                self.percentDrivenTransition?.finishInteractiveTransition()
            }
            else
            {
                self.percentDrivenTransition?.cancelInteractiveTransition()
            }
            self.percentDrivenTransition = nil
        }
    }

    func addScreenEdgePanGestureRecognizer(onView: UIView, edges: UIRectEdge)
    {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: .edgePanGesture)
        edgePan.edges = edges
        onView.addGestureRecognizer(edgePan)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

private extension Selector
{
    static let nextBtnClick = #selector(First.nextBtnClick)
    static let edgePanGesture = #selector(First.edgePanGesture(_:))
}

extension First: UIViewControllerTransitioningDelegate
{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return PresentAnimation()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return DismissAnimation()
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return self.percentDrivenTransition
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return self.percentDrivenTransition
    }
}