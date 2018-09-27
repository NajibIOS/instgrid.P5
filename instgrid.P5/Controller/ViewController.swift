//
//  ViewController.swift
//  instgrid.P5
//
//  Created by abdel on 26/07/2018.
//  Copyright © 2018 Najib ANNABi. All rights reserved.
//imagePickerController

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var pattern1Button: UIButton!
    @IBOutlet weak var pattern2Button: UIButton!
    @IBOutlet weak var pattern3Button: UIButton!
    @IBOutlet weak var gridView: GridView!
    private let imagePicker = UIImagePickerController()
    private var swipeGestureRecognizer : UISwipeGestureRecognizer?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // Setup Notification Observer & Delegate
    private func setupBehaviors()  {
        gridView.grid = .pattern2
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(displayImageSourceMenu), name: Notification.Name(rawValue: "addButtomAction"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDiretion), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func pattenrButtonTapped(_ sender: UIButton) {
        [pattern1Button, pattern2Button, pattern3Button].forEach {$0?.isSelected = false}
        sender.isSelected = true
        switch sender.tag {
        case 0:
            gridView.grid = .pattern1
        case 1:
            gridView.grid = .pattern2
        case 2:
            gridView.grid = .pattern3
        default:
            break
        }
    }
    
    // Pour aller cher la photo depuis sa source
    private func startPickerControllerLibrary() {
        imagePicker.sourceType = .photoLibrary
        // Afficher le controlleur
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func startPickerControllerCamera() {
        imagePicker.sourceType = .camera
        // Afficher le controlleur
        present(imagePicker, animated: true, completion: nil)
    }
    
    // To Pick photo from camera
    @objc private func showImageSourceMenu(gesture: UITapGestureRecognizer) {
        gridView.currentTag = gesture.view?.tag
        displayImageSourceMenu()
    }
    
    //MARK: - Methodes To Manage The SwipeUP
    
    // The Swipe Format (Portrait - Landscape)
    @objc private func setUpSwipeDiretion() {
        if UIDevice.current.orientation.isLandscape {
            swipeGestureRecognizer?.direction = .left
        } else if UIDevice.current.orientation.isPortrait{
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    // The Methode to configurate the SwipeGesture
    private func swipeConfiguration() {
        swipeGestureRecognizer = UISwipeGestureRecognizer (target: self, action: #selector(swipeAndShare))
        gridView.addGestureRecognizer(swipeGestureRecognizer!)
    }
    
    @objc private func swipeAndShare() {
        if swipeGestureRecognizer?.direction == .up {
            swipeUp()
        }else {
            swipeLeft()
        }
    }
    
    private func swipeUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.gridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }, completion: { _ in
            self.shareGridView()
        })
    }
    
    private func swipeLeft() {
        UIView.animate(withDuration: 0.5, animations: {
            self.gridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        }, completion: { _ in
            self.shareGridView()
        })
    }
}
