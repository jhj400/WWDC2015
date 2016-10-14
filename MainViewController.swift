//
//  MainViewController.swift
//  WWDC
//
//  Created by Hong on 2015. 4. 23..
//  Copyright (c) 2015년 student. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UIDynamicAnimatorDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet var longPressGesture: UILongPressGestureRecognizer!
    
    private var dropsPerRow = 4
    private let dropBehavior = DropBehavior()
    
    // MARK : - Constants
    private struct Constants {
        static let seoul = "seoul"
        static let standing = "standing"
        static let riding = "riding"
        static let prize = "prize"
        static let hanyangLogo = "hanyangLogo"
        static let hanyangLion = "hanyangLion"
        static let hanyangBuilding = "hanyangBuilding"
        static let pyungChang = "pyungChang"
        static let pyungChang2 = "pyungChang2"
        static let ddmOld = "ddmOld"
        static let ddmNew = "ddmNew"
        static let wideDdp3 = "wideDdp3"
        static let wooriLogo = "wooriLogo"
        static let wooriMascot = "wooriMascot"
        static let wooriBuilding = "wooriBuilding"
        static let berkeleyLogo = "berkeleyLogo"
        static let berkeleyStreet = "berkeleyStreet"
        static let illinois = "illinois"
        static let illinoisBuilding = "illinoisBuilding"
        static let illinoisSeal = "illinoisSeal"
        static let showInfo = "show Info"
        static let animateViewDuration = NSTimeInterval(0.5)
        static let transitionScale = CGFloat(0.9)
        static let transitionAlpha = CGFloat(0.9)
    }
    
    private var imageString = [Constants.seoul, Constants.standing, Constants.riding, Constants.prize,
        Constants.hanyangLogo, Constants.hanyangLion, Constants.hanyangBuilding, Constants.pyungChang,
        Constants.pyungChang2, Constants.ddmOld, Constants.ddmNew, Constants.wideDdp3,
        Constants.wooriLogo, Constants.wooriMascot, Constants.wooriBuilding, Constants.berkeleyLogo,
        Constants.berkeleyStreet, Constants.illinois, Constants.illinoisBuilding, Constants.illinoisSeal]
    
    lazy var animator: UIDynamicAnimator = {
        let lazyDynamicAnimator = UIDynamicAnimator(referenceView: self.pictureView)
        lazyDynamicAnimator.delegate = self
        return lazyDynamicAnimator
    }()
    
    // MARK: - animation
    func animateTab() {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tabLabel.alpha = 0.0
        })
    }
    
    //MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabLabel.alpha = 1.0
        animator.addBehavior(dropBehavior)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animateTab()
    }
    
    override func shouldAutorotate() -> Bool {
        let orientation = UIDevice.currentDevice().orientation
        switch orientation {
        case .Portrait, .PortraitUpsideDown:
            dropsPerRow = 4
        case .LandscapeLeft, .LandscapeRight:
            dropsPerRow = 7
        default:
            break
        }
        replay()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//            case Constants.showInfo:
//                if let ivc = segue.destinationViewController as? InfoViewController {
//                    if let ppc = ivc.popoverPresentationController {
//                        ppc.delegate = self
//                    }
//                }
//            default:
//                break
//            }
//        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.OverFullScreen
    }
    
    private var dropSize: CGSize {
        let size = pictureView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    private var num = 0
    private var row = 0
    
    @IBAction func dropPicture(sender: UITapGestureRecognizer) {
        if(num > 19) {
            return
        } else if (num < 2) {
            self.tabLabel.alpha = 1.0
            animateTab()
        }
        drop(num)
        num = num + 1
    }
    
    var lastDroppedView: UIImageView?
    
    func drop(index: Int) {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        let image = UIImage(named: imageString[index])!
        frame.origin.x = CGFloat(row) * dropSize.width
        
        let dropView = UIImageView(frame: frame)
        
        dropView.image = image
        
        lastDroppedView = dropView
        
        dropBehavior.addPictureDrop(dropView)
        row = row + 1
        if(row >= dropsPerRow) {
            row = 0
        }
        
    }
    
    func replay() {
        var views = pictureView.subviews
        
        for (var index = 0; index < views.count; index++) {
            if let view = views[index] as? UIImageView {
                dropBehavior.removePictureDrop(views[index] as! UIImageView)
            }
        }
        row = 0
        num = 0
    }

    @IBAction func replay(sender: UIButton) {
        replay()
    }
    @IBAction func popOverView(sender: UILongPressGestureRecognizer) {
    }
}

