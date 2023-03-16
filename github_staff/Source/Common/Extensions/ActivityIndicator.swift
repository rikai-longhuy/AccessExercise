//
//  ActivityIndicator.swift
//  github_staff

import Foundation

import Foundation
import RxSwift
import RxCocoa

class ActivityIndicator: SharedSequenceConvertibleType {
    
    typealias Element = Bool
    
    public typealias E = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _variable = BehaviorRelay(value: false)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _variable.asDriver()
            .distinctUntilChanged()
        
            .debounce(.milliseconds(200))
            .flatMap({ show -> Driver<Bool> in
            if show {
                return Driver.just(show)
            } else {
                return Driver.just(show).delay(.milliseconds(300))
            }
        })
    }

    func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }

    private func subscribed() {
        _lock.lock()
        _variable.accept(true)
        _lock.unlock()
    }

    func sendStopLoading() {
        _lock.lock()
        _variable.accept(false)
        _lock.unlock()
    }

    func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _loading
    }

    func show(isShow: Bool) {
        _lock.lock()
        _variable.accept(isShow)
        _lock.unlock()
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
