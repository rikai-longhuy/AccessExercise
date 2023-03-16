//
//  ListUserTableViewCell.swift
//  github_staff

import UIKit
import SDWebImage

private struct Constrant {
    static let cellHeight: CGFloat = 95.0
    static let avatarCorner: CGFloat = 28.0
}

class ListUserTableViewCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var staffView: UIView!
    @IBOutlet private weak var staffLabel: UILabel!
    @IBOutlet private weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        staffView.isHidden = true
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        mainView.layer.shadowRadius = 4
        mainView.layer.shadowOpacity = 0.4
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        avatarImageView.layer.cornerRadius = Constrant.avatarCorner
        avatarImageView.layer.masksToBounds = true
        staffView.layer.cornerRadius = staffView.bounds.height / 2
        staffView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        avatarImageView.image = nil
        super.prepareForReuse()
    }
    
    func configure(user: UserModel) {
        nameLabel.text = user.login
        if let imageUrl = user.avatarUrl {
            avatarImageView.sd_setImage(with: URL(string: imageUrl))
        } else {
            avatarImageView.image = nil
        }
        staffView.isHidden = !(user.siteAdmin ?? true)
    }
    
    class func cellHeight() -> CGFloat {
        return Constrant.cellHeight;
    }
}
