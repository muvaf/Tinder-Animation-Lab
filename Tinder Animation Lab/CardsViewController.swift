//
//  CardsViewController.swift
//  Tinder Animation Lab
//
//  Created by monus on 4/6/17.
//  Copyright © 2017 Muhammed Onus. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    let maxAngleInDegree:CGFloat = 30
    var firstTouchPoint: CGPoint?
    
    @IBAction func clickedImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileViewControllerSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let profileVC = segue.destination as! ProfileViewController
        profileVC.imageToSet = cardImageView.image
        
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            cardInitialCenter = cardImageView.center
            firstTouchPoint = sender.location(in: view)
        } else if sender.state == .changed {
            
            cardImageView.center = CGPoint(x: cardInitialCenter.x + sender.translation(in: view).x, y: cardInitialCenter.y)
            
            var transformInDegree = maxAngleInDegree * (sender.translation(in: view).x / (cardImageView.frame.size.width/2))
            if firstTouchPoint!.y > cardInitialCenter.y {
                transformInDegree = -1 * transformInDegree
            }
            cardImageView.transform = view.transform.rotated(by: CGFloat(transformInDegree * CGFloat(M_PI) / 180))
            
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.5, animations: {
                self.cardImageView.transform = CGAffineTransform.identity
                self.cardImageView.center = self.cardInitialCenter
            })
        }
    }
    @IBOutlet weak var cardImageView: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
