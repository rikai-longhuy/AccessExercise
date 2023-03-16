//
//  UserDetailViewModel.swift
//  github_staff

import Foundation
import RxCocoa
import RxSwift

class UserDetailViewModel {

    var userReplay: BehaviorRelay<UserModel>
    var activityTracker = ActivityIndicator()
    init(user: UserModel) {
        userReplay = BehaviorRelay(value: user)
    }
}

extension UserDetailViewModel {
    
    struct Input {
        let viewDidLoad: Driver<Void>
    }
    
    struct Output {
        let reload: Driver<UserModel>
    }
    
    func transform(input: Input, bag: DisposeBag) -> Output {
        input
            .viewDidLoad
            .asObservable()
            .map({ [weak self] in
                return self?.userReplay.value.login
            })
            .unwrap()
            .flatMap ({ [unowned self] id in
                return NetworkService
                    .request(UserAPI.detail(id: id), type: UserModel.self)
                    .trackActivity(self.activityTracker)
            })
            .asDriverJustComplete()
            .drive(onNext: { [weak self] user in
                self?.userReplay.accept(user!)
            })
            .disposed(by: bag)
        return Output(reload: userReplay.asDriver());
    }
}
