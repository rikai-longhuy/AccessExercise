//
//  UserDetailInforTableViewCell.swift
//  github_staff

import UIKit

class UserDetailInforTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var staffView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        staffView.layer.cornerRadius = staffView.bounds.height / 2
        staffView.layer.masksToBounds = true
    }
    
    func configure(content: String?, icon: UIImage?, isStaff: Bool = false) {
        contentLabel.text = content
        iconImageView.image = icon
        staffView.isHidden = !isStaff
    }
}
