//
//  Reactor.swift
//  ReactorKit_Counter
//
//  Created by 김라영 on 2024/10/25.
//

import Foundation
import ReactorKit
import RxSwift

class CounterReactor: Reactor {
    // Action 스트림 정의
    enum Action {
        case increase
        case decrease
    }
    
    // Mutation정의 -> 상태를 어떻게 변화시킬지 정의
    enum Mutation {
        case increase
        case decrease
    }
    
    struct State {
        var value: Int
    }
    
    var initialState: State
    
    init(initialState: State = State(value: 0)) {
        self.initialState = initialState
    }
}

extension CounterReactor {
    // Action을 Mutation으로 변환
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.just(Mutation.increase)
        case .decrease:
            return Observable.just(Mutation.decrease)
        }
    }
    
    //Mutation를 통해서 새로운 State로 만들기
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = state
        switch mutation {
        case .increase:
            newState.value += 1
        case .decrease:
            newState.value -= 1
        }
        
        return newState
    }
}
