//
//  DropBehavior.swift
//  WWDC
//
//  Created by Hong on 2015. 4. 23..
//  Copyright (c) 2015년 student. All rights reserved.
//

import UIKit

class DropBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    
    lazy var dropBehavior:UIDynamicItemBehavior = {
        let lazyDropBehavior = UIDynamicItemBehavior()
        lazyDropBehavior.elasticity = 0.5
        lazyDropBehavior.allowsRotation = true
        return lazyDropBehavior
    } ()
    
    lazy var barrier: UICollisionBehavior = {
        let lazyBarrier = UICollisionBehavior ()
        lazyBarrier.translatesReferenceBoundsIntoBoundary = true
        return lazyBarrier
    } ()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(dropBehavior)
        addChildBehavior(barrier)
    }
    
    func addPictureDrop(picture: UIImageView) {
        dynamicAnimator?.referenceView?.addSubview(picture)
        gravity.addItem(picture)
        dropBehavior.addItem(picture)
        barrier.addItem(picture)
    }
    
    func removePictureDrop(picture: UIImageView) {
        gravity.removeItem(picture)
        dropBehavior.removeItem(picture)
        barrier.removeItem(picture)
        picture.removeFromSuperview()
    }
}
