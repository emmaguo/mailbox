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
    var messageViewOriginalCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(
            width: feedView.frame.width,
            height: feedView.frame.height + messageView.frame.height            
        )
        laterIcon.alpha = 0
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        listIcon.alpha = 0
        backgroundColorView.backgroundColor = UIColor.lightGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageViewOriginalCenter = messageView.center
            laterIconOriginalCenter = laterIcon.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center.x = messageViewOriginalCenter.x + translation.x
            UIView.animateWithDuration(0.4, animations: {
                self.laterIcon.alpha = 1
            })
            if translation.x < -60 {
                laterIcon.center.x = laterIconOriginalCenter.x + translation.x + 60
            }

        } else if sender.state == UIGestureRecognizerState.Ended {
            messageView.center.x = messageViewOriginalCenter.x
            laterIcon.center.x = laterIconOriginalCenter.x
        }
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
