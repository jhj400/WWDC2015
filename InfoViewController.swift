//
//  InfoViewController.swift
//  WWDC
//
//  Created by Hong on 2015. 4. 24..
//  Copyright (c) 2015년 student. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    private var i = 0
    private var textArray = ["I am Hongjae Jeon", "and I am an  developer", "from Gangnam", "Seoul, South Korea", "I am currently a student", "in computer science", "at Berkeley City College", "I developed 5 iOS apps", "at Woori Investment firm", "I wanted to gain", "deeper understanding of", "iOS development", "I will be studying at", "the University of Illinois", "at Urbana-Champaign",  "this Fall, but first...", "I would love to learn", "the latest features of Swift", "from Apple engineers at", ""]
    private var text:String {
        get {
            if i >= textArray.count {
                i = 0
            }
            return textArray[i++]
        }
    }
    private var timer = NSTimer()
    
    //MARK: - Constants
    private struct Constants {
        static let topOffset = CGFloat(20)
        static let toolBarHeight = CGFloat(48)
        static let interval = NSTimeInterval(1.0)
    }
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var displayLabel: LTMorphingLabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var wwdcImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.view.backgroundColor = UIColor.clearColor()
//        changeViewLoc()
//        replay.text = "Hello."
        wwdcImageView.alpha = 0.0
        startTimer()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
    }
    
    @IBAction func animation(sender: UIButton) {
        wwdcImageView.alpha = 0.0
        displayLabel.alpha = 1.0
        startTimer()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.interval, target: self, selector: "changeText", userInfo: nil, repeats: true)
        
    }
    
    func changeText() {
        helloLabel.alpha = 0.0
        displayLabel.text = text
        if i >= textArray.count {
            timer.invalidate()
            i = 0
        } else if i == textArray.count - 1 {
            displayLabel.alpha = 0.0
            wwdcImageView.alpha = 1.0
        }
    }
    
    func changeViewLoc() {
//        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, Constants.toolBarHeight))
//        toolBar.userInteractionEnabled = true
//        toolBar.addGestureRecognizer(panGesture)
//        toolBar.items = [cancel];
//        self.view.addSubview(toolBar)
        
    }

    /*
    
    - (void)changeViewLoc
    {
    //    _navController.view.frame = CGRectMake(0, start, CGRectGetWidth(kBounds), CGRectGetHeight(kBounds) - kTopOffset);
    
    //    self.view.frame = CGRectMake(0, kTopOffset - 50, CGRectGetWidth(kBounds), CGRectGetHeight(kBounds) - kTopOffset - 50);
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kTopOffset, CGRectGetWidth(kBounds), 48)];
    [toolBar setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [toolBar addGestureRecognizer:panGesture];
    
    [self.view addSubview:toolBar];
    
    UIImage* image = [UIImage imageNamed:@"map"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    CGRect rect = CGRectMake(0, kTopOffset + 46, CGRectGetWidth(kBounds), CGRectGetHeight(kBounds) - kTopOffset - 48);
    imageView.frame = rect;
    [self.view addSubview:imageView];
    [self.view setNeedsDisplay];
    //    [_delegate reloadData];
    }
*/
}
