//
//  UserDetailViewController.swift
//  github_staff

import UIKit
import RxCocoa
import RxSwift

class UserDetailViewController: UIViewController {
    
    var viewModel: UserDetailViewModel!
    private var bag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var avatarCell: UserDetailAvatarTableViewCell = {
       return UIView.loadViewFromNib(type: UserDetailAvatarTableViewCell.self)
    }()
    
    private lazy var nameCell: UserDetailInforTableViewCell = {
        return UIView.loadViewFromNib(type: UserDetailInforTableViewCell.self)
    }()
    
    private lazy var locationCell: UserDetailInforTableViewCell = {
        return UIView.loadViewFromNib(type: UserDetailInforTableViewCell.self)
    }()
    
    private lazy var blogCell: UserDetailInforTableViewCell = {
        return UIView.loadViewFromNib(type: UserDetailInforTableViewCell.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(UserDetailAvatarTableViewCell.self)
        
        avatarCell.didTapClose = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func bindViewModel() {
        let input = UserDetailViewModel.Input(viewDidLoad: Driver.just(()))
        let output = viewModel.transform(input: input, bag: bag)
        output.reload.drive(onNext: { [weak self] user in
            self?.tableView.beginUpdates()
            self?.avatarCell.configure(user: user)
            self?.nameCell.configure(content: user.login, icon: CellType.name.image, isStaff: user.siteAdmin ?? false)
            self?.locationCell.configure(content: user.location, icon: CellType.location.image)
            self?.blogCell.configure(content: user.blog, icon: CellType.blog.image)
            self?.tableView.endUpdates()
        }).disposed(by: bag)
    }
}



extension UserDetailViewController {
    enum CellType: Int, CaseIterable {
        case avatar
        case name
        case location
        case blog
        
        var image: UIImage? {
            switch self {
            case .name:
                return UIImage(named: "man")
            case .blog:
                return UIImage(named: "blog")
            case .location:
                return UIImage(named: "location")
            default:
                return nil
            }
        }
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellType(rawValue: indexPath.row)
        switch cellType {
        case .name:
            return nameCell
        case .location:
            return locationCell
        case .blog:
            return blogCell
        default:
            return avatarCell
        }
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
