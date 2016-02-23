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
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    var messageViewOriginalCenter: CGPoint!
    var feedViewOriginalCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
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
            if translation.x < -60 {
                laterIcon.center.x = laterIconOriginalCenter.x + translation.x + 60
                backgroundColorView.backgroundColor = UIColor.yellowColor()
            }

        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x < -60 {
                UIView.animateWithDuration(0.2,
                    animations: {
                        () -> Void in
                        self.messageView.center.x =
                            self.messageViewOriginalCenter.x - self.messageView.frame.width
                    }, completion: {
                        (Bool) -> Void in
                        self.rescheduleView.alpha = 1
                    }
                )
            }
        }
    }

    @IBAction func onDismissButton(sender: UIButton) {
        listView.alpha = 0
        rescheduleView.alpha = 0
        messageView.center = messageViewOriginalCenter
        laterIcon.center = laterIconOriginalCenter
        backgroundColorView.backgroundColor = backgroundViewOriginalColor
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
