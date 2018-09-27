//
//  GridView.swift
//  instgrid.P5
//
//  Created by abdel on 02/08/2018.
//  Copyright © 2018 Najib ANNABi. All rights reserved.
//

import UIKit

class GridView : UIView {
    
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    var currentTag: Int?
    @IBOutlet weak var bottonUpleft: UIButton!
    @IBOutlet weak var buttonUpRight: UIButton!
    @IBOutlet weak var buttonDownLeft: UIButton!
    @IBOutlet weak var buttonDownRight: UIButton!
    var grid: Grid! {
        didSet {
            displayDidChanged()
        }
    }
    
    // MARK: Initialization Block Of The "GridView" Class

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        
    }
    @IBAction func addButtomAction(_ sender: UIButton) {
        currentTag = sender.tag
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addButtomAction"), object: nil)
    }
    
    // MARK:- METHODS
    // To Load Xib File
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GridView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func displayDidChanged() {
        let views = [topLeftView, topRightView, bottomLeftView, bottomRightView]
        for i in 0..<views.count {
            let value = grid.display[i]
            views[i]?.isHidden = value
        }
        
    }
}

