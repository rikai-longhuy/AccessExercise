//
//  ViewController.swift
//  github_staff

import UIKit
import RxSwift
import RxCocoa

class ListUserViewController: UIViewController {
    let viewModel = ListUserViewModel()
    let bag = DisposeBag()
    
    // MARK: IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ListUserTableViewCell.self)
    }
    
    private func bindViewModel() {
        let didScrollToBottom = tableView
            .rx
            .willDisplayCell
            .filter { [weak self] event in
                guard let self = self else {
                    return false
                }
                return self.tableView.isLastSectionAndLastRow(at: event.indexPath)
            }
            .mapToVoid()
            .asDriverJustComplete()
        
        let didTapCell = tableView.rx
            .itemSelected
            .do(onNext: {[weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map({$0.row})
            .asDriverJustComplete()
        
        let input = ListUserViewModel.Input(viewDidLoad: Driver.just(()),
                                            loadmore: didScrollToBottom,
                                            didTapCell: didTapCell)
        let output = viewModel.transform(input: input, with: bag)
        
        output
            .reload
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: bag)
        
        output.moveToDetail.drive(onNext: {[weak self] user in
            let detailViewController: UserDetailViewController = UIViewController.loadFromStoryboard(name: "Main")
            let viewModel = UserDetailViewModel(user: user)
            detailViewController.viewModel = viewModel
            self?.present(detailViewController, animated: true)
        }).disposed(by: bag)
    }
}

extension ListUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ListUserTableViewCell.self)
        cell.configure(user: viewModel.users.value[indexPath.row])
        return cell
    }
}

extension ListUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListUserTableViewCell.cellHeight();
    }
}

