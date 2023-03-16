//
//  ListUserViewModel.dart.swift
//  github_staff

import Foundation
import RxSwift
import RxCocoa

private struct Constant {
    static let pageLimit = 100
}

class ListUserViewModel {
    var users = BehaviorRelay<[UserModel]>(value: [])
    
    private var since = 0
    private var isCanLoadmore = true
    private var activityIndicator = ActivityIndicator()
}

extension ListUserViewModel {
    struct Input {
        let viewDidLoad: Driver<Void>
        let loadmore: Driver<Void>
        let didTapCell: Driver<Int>
    }
    
    struct Output {
        let reload: Driver<Void>
        let moveToDetail: Driver<UserModel>
    }
    
    func transform(input: Input, with bag: DisposeBag) -> Output {
        let loadTrigger =  input.viewDidLoad
            .asObservable()
            .do(onNext: { [weak self] _ in
                self?.users.accept([])
            })
            .map({ _ -> Int in
                return 0
            });
        let loadMoreTrigger = input.loadmore
            .asObservable()
            .filter({ [weak self] _ in
                return self?.isCanLoadmore ?? false
            })
            .map({ [weak self] _ in
                return self?.since ?? 0
            });
        
        Observable.merge(loadTrigger, loadMoreTrigger)
            .flatMap({ [weak self] since -> Observable<[UserModel]?> in
                guard let self = self else {
                    return Observable.empty()
                }
                return NetworkService
                    .request(UserAPI.list(since: since, limit: Constant.pageLimit), type: [UserModel].self)
                    .trackActivity(self.activityIndicator)
            })
            .asDriverJustComplete()
            .do(onNext: { [weak self] data in
                self?.isCanLoadmore = (data?.count ?? 0) >= Constant.pageLimit
                self?.since += Constant.pageLimit
                var currentUsers = self?.users.value ?? []
                currentUsers.append(contentsOf: data ?? [])
                self?.users.accept(currentUsers)
            })
                .drive()
                .disposed(by: bag)
                
                let moveToDetail = input.didTapCell
                .map { [weak self] index in
                    return self?.users.value[index]
                }
                .unwrap()
        
        return Output(reload: users.asDriver().mapToVoid(),
                      moveToDetail: moveToDetail)
    }
}
