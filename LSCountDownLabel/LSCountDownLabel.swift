//
//  LSCountDownLabel.swift
//  realtornote
//
//  Created by 영준 이 on 2017. 8. 17..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

class LSCountDownLabel : UILabel{
    /// Max Counting seconds
    @IBInspectable var seconds : Int = 0;
    
    /// minimum text scale to show counting animation
    @IBInspectable var minimumScale : CGFloat = 0.25;
    
    /// current value of counting
    var value = 0;
    /// is the counting currently
    var isCounting = false;
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    /**
        Start counting animation and triggers completion handler when the counting has been finished
        - parameter completion: completion handler to trigger when the counting has been finished
    */
    func start(_ completion: @escaping (Int) -> Void){
        guard !self.isCounting else{
            return;
        }
        
        self.isCounting = true;
        self.value = self.seconds;
        
        self.count(completion);
    }
    
    /**
        Stop counting animation
    */
    func stop(){
        guard self.isCounting else{
            return;
        }
        
        self.isCounting = false;
        self.layer.removeAllAnimations();
        self.transform = CGAffineTransform.identity;
    }
    
    /**
        Start animation to show the counting
        - parameter completion: completion handler for the finish of the counting
    */
    private func count(_ completion: @escaping (Int) -> Void){
        self.transform = CGAffineTransform.init(scaleX: self.minimumScale, y: self.minimumScale);
        self.text = "\(self.value)";
        
        guard self.isCounting  else{
            self.text = "";
            return;
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.transform = CGAffineTransform.identity;
        }) { [unowned self](result) in
            self.value = self.value - 1;
            
            guard self.value > 0 else{
                self.isCounting = false;
                completion(self.value);
                return;
            }
            
            self.count(completion);
        }
    }
}
