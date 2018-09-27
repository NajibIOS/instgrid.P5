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
}
