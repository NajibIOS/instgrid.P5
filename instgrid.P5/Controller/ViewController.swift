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
        setupBehaviors()
        swipeConfiguration()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    // To Pick The Images From  Their sources
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
    
    @objc private func displayImageSourceMenu() {
        // Create the alert
        let alertController = UIAlertController(title: "Take a photo", message: "", preferredStyle: .actionSheet)
        // Create The Actions
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.startPickerControllerCamera()
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.startPickerControllerLibrary()
        }
        // Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // After Creating these action, we add it to our alert
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // For Update The Tag & Restart The PickerControlleur
    @objc private func startPickerControllerWithTag(gesture: UITapGestureRecognizer){
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
    
    // Shared The Grid VIew
    private func shareGridView() {
        guard let image = gridView.convertToImage() else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController,animated: true, completion: nil)
        activityController.completionWithItemsHandler = { activity, completed, items, error in
            self.animationBack()
        }
    }
    
    // Manage The Return Of The Grid
    private func animationBack() {
        UIView.animate(withDuration: 0.5, animations: {
            self.gridView.transform = .identity
        })
    }
}

//MARK: UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // If user want to cancel to choose a photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Pour faire dissparaitre le controleur qui va nous de choisir une photo
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        // Afin de s'assurer que le fichier choisit est une photo
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        guard let tag = gridView.currentTag else { return }
        let imageViews = [gridView.topLeftImageView, gridView.topRightImageView, gridView.bottomLeftImageView, gridView.bottomRightImageView ]
        imageViews[tag]?.image = selectedImage
        // Pour cacher le boutton '+'
        let plusAddButton = [gridView.bottonUpleft, gridView.buttonUpRight, gridView.buttonDownLeft, gridView.buttonDownRight]
        imageViews[tag]?.image = selectedImage
        plusAddButton[tag]?.isHidden = true
        // Tap Gesture apres apres que le bouton "+" ai disparu.
        let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(showImageSourceMenu(gesture: )))
        gridView.addGestureRecognizer(tapGestureRecongnizer)
        dismiss(animated: true, completion: nil)
    }
}



