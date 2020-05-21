//
//  TransitionView.swift
//  CircleViewTransitionApp
//
//  Created by Hassan Abbasi on 14/05/2020.
//  Copyright © 2020 Hassan Abbasi. All rights reserved.
//

import Foundation
import UIKit

class TransitionView:UIView{
    fileprivate var circle = UIView()
    fileprivate var circleColor:UIColor?
    fileprivate var duration = 0.5
    fileprivate let circleSize = CGSize(width: 0.001, height: 0.001)
    fileprivate var animated = false
    
    
    func setCircleColor(_ color:UIColor){
        self.circleColor = color
    }
    
    
    func setAnimationDuration(_ duration:Double){
        self.duration = duration
    }
    
    func exitAnimation(){
        if !animated{return}
        UIView.animate(withDuration: duration, animations: {
            self.circle.transform = CGAffineTransform(scaleX: self.circleSize.width, y: self.circleSize.height)
            self.circle.subviews.forEach({$0.alpha = 0})

        }) { (_) in
            self.circle.removeFromSuperview()
            self.circle.subviews.forEach({$0.alpha = 1})
            self.circle = UIView()
            self.animated = false
        }
    }
    
    func animate(view:UIView, fromView:UIView){
        setupView(secondView: view, buttonView: fromView)
        circle.transform = CGAffineTransform(scaleX: circleSize.width, y: circleSize.height)
        UIView.animate(withDuration: duration, animations: {
            self.circle.transform = CGAffineTransform.identity
        }, completion:nil)
        self.animated = true
    }
    
   
    
    
    
    fileprivate func setupView(secondView:UIView,buttonView:UIView){
        self.clipsToBounds = true
        self.circleColor = self.circleColor ?? secondView.backgroundColor
        let viewCenter = buttonView.center
        let viewSize = self.frame.size
        
        
        self.addSubview(circle)
        circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: buttonView.center)
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.center = buttonView.center
        circle.backgroundColor = circleColor
     
        
        
        circle.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        secondView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        secondView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        secondView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    /**Credits: github.com/brianadvent
    https://github.com/brianadvent/CircularTransition/blob/master/CircularTransition/CircularTransition.swift
     **/
    fileprivate  func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
}
