//
//  MusicCell.swift
//  FoilMusicDemoApp
//
//

import UIKit

class MusicCell: UITableViewCell {
    
    @IBOutlet open var bottomView: UIView!
    @IBOutlet open var bottomViewTop: NSLayoutConstraint!
    @IBOutlet open var topView: UIView!
    @IBOutlet weak var topViewTop: NSLayoutConstraint!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDefaultState()
        self.setUpUI()
    }
    
    func setUpUI() {
        self.selectionStyle = .none
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.masksToBounds = false
        bottomView.clipsToBounds = true
        
        topView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true
    }
    
    func isOpenCell(with animation: Bool) {
        UIView.animate(withDuration: 0.0,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: { () -> Void in
                        self.contentView.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            self.close(animation)
        })
    }
    
    private func configureDefaultState() {
        guard let foregroundViewTop = self.topViewTop,
            let containerViewTop = self.bottomViewTop else {
                fatalError("")
        }
        containerViewTop.constant = foregroundViewTop.constant + 10
        bottomView.alpha = 0
        if let height = (topView.constraints.filter { $0.firstAttribute == .height && $0.secondItem == nil }).first?.constant {
            topView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            foregroundViewTop.constant += height / 2
        }
        contentView.bringSubviewToFront(topView)
    }

    @objc open func close(_ value: Bool) {
        topView.alpha = value ? 0 : 1
        bottomView.alpha = value ? 1 : 0
    }
}
