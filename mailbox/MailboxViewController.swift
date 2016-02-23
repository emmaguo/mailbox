//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Emma Guo on 2/20/16.
//  Copyright © 2016 emmaguo. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    var messageViewOriginalCenter: CGPoint!
    var feedViewOriginalCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var backgroundViewOriginalColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(
            width: feedView.frame.width,
            height: feedView.frame.height + messageView.frame.height
        )
        feedViewOriginalCenter = feedView.center
        messageViewOriginalCenter = messageView.center
        laterIconOriginalCenter = laterIcon.center
        archiveIconOriginalCenter = archiveIcon.center
        backgroundViewOriginalColor = backgroundColorView.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            backgroundColorView.alpha = 0
            UIView.animateWithDuration(0.5, animations: {
                self.backgroundColorView.alpha = 1
            })
 
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center.x = messageViewOriginalCenter.x + translation.x
            backgroundColorView.backgroundColor = backgroundViewOriginalColor
            
            if translation.x < 0 {
                archiveIcon.alpha = 0
                laterIcon.alpha = 1
            } else {
                archiveIcon.alpha = 1
                laterIcon.alpha = 0
            }
            
            if translation.x < -260 {
                laterIcon.image = UIImage(named: "list_icon")
                laterIcon.center.x = laterIconOriginalCenter.x + translation.x + 60
                backgroundColorView.backgroundColor = UIColor.brownColor()
            } else if translation.x < -60 {
                laterIcon.center.x = laterIconOriginalCenter.x + translation.x + 60
                backgroundColorView.backgroundColor = UIColor.yellowColor()
            } else if translation.x > 260 {
                archiveIcon.image = UIImage(named: "delete_icon")
                archiveIcon.center.x = archiveIconOriginalCenter.x + translation.x - 60
                backgroundColorView.backgroundColor = UIColor.redColor()
            } else if translation.x > 60 {
                archiveIcon.center.x = archiveIconOriginalCenter.x + translation.x - 60
                backgroundColorView.backgroundColor = UIColor.greenColor()
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x < -260 {
                continueMessageSlideLeft(listView)
            } else if translation.x < -60 {
                continueMessageSlideLeft(rescheduleView)
            } else if translation.x > 60 {
                continueMessageSlideRight()
            } else {
                centerMessage()
            }
        }
    }
    
    // Continue message sliding left to review list view or reschedule view
    func continueMessageSlideLeft(myview: UIView) {
        UIView.animateWithDuration(0.2,
            animations: {
                () -> Void in
                self.messageView.center.x =
                    self.messageViewOriginalCenter.x - self.messageView.frame.width
                self.laterIcon.center.x =
                    self.laterIconOriginalCenter.x - self.messageView.frame.width + 60
            }, completion: {
                (Bool) -> Void in
                myview.alpha = 1
            }
        )
    }
    
    // Continue message sliding right to dismiss message
    func continueMessageSlideRight() {
        UIView.animateWithDuration(0.2,
            animations: {
                () -> Void in
                self.messageView.center.x =
                    self.messageViewOriginalCenter.x + self.messageView.frame.width
                self.archiveIcon.center.x =
                    self.archiveIconOriginalCenter.x + self.messageView.frame.width - 60
            }, completion: {
                (Bool) -> Void in
                self.hideMessage()
            }
        )
    }
    
    // Center message animation
    func centerMessage() {
        UIView.animateWithDuration(0.2,
            animations: {
                () -> Void in
                self.messageView.center.x = self.messageViewOriginalCenter.x
            }
        )
    }
    
    // Hide message animation
    func hideMessage() {
        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        UIView.animateWithDuration(0.7,
            animations: {
                () -> Void in
                self.feedView.center.y = self.feedViewOriginalCenter.y - self.messageView.frame.height
            }
        )
    }
    
    // Show message animation
    func showMessage() {
        messageView.alpha = 1
        laterIcon.alpha = 1
        backgroundColorView.backgroundColor = backgroundViewOriginalColor
        UIView.animateWithDuration(0.5,
            animations: {
                () -> Void in
                self.feedView.center.y = self.feedViewOriginalCenter.y
            }
        )
    }

    @IBAction func onDismissButton(sender: UIButton) {
        listView.alpha = 0
        rescheduleView.alpha = 0
        laterIcon.center = laterIconOriginalCenter
        laterIcon.image = UIImage(named: "later_icon")
        messageView.center = messageViewOriginalCenter
        messageView.alpha = 0
        laterIcon.alpha = 0
        
        UIView.animateWithDuration(0.7,
            animations: {
                () -> Void in
                self.feedView.center.y = self.feedViewOriginalCenter.y - self.messageView.frame.height
            }, completion: {
                (Bool) -> Void in
                self.showMessage()
            }
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
