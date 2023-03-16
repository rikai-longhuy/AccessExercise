//
//  UserDetailAvatarTableViewCell.swift
//  github_staff

import UIKit
import SDWebImage

class UserDetailAvatarTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var didTapClose: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    @IBAction func closeAction(_ sender: Any) {
        didTapClose?()
    }
    
    func configure(user: UserModel) {
        if let imageUrl = user.avatarUrl {
            avatarImageView.sd_setImage(with: URL(string: imageUrl))
        } else {
            avatarImageView.image = nil
        }
        nameLabel.text = user.login
        descriptionLabel.text = user.bio ?? ""
    }
}
