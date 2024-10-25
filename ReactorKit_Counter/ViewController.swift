//
//  ViewController.swift
//  ReactorKit_Counter
//
//  Created by 김라영 on 2024/10/25.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    /// +버튼
    @IBOutlet weak var increaseBtn: UIButton!
    /// -버튼
    @IBOutlet weak var decreaseBtn: UIButton!
    
    /// 숫자
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // bind함수랑 연결해줄 reactor
        self.reactor = CounterReactor()
    }
}

extension ViewController: StoryboardView {
    func bind(reactor: CounterReactor) {
        increaseBtn.rx.tap
            .debug("increase Btn")
            .map { CounterReactor.Action.increase } //사용자 입력을 Reacotor에서 정의해 놓은 Action의 incrase로 변경(즉, Action Type으로 변경)
            .bind(to: reactor.action) // 그걸 self.reactor의 action과 묶는다.(action 스트림에 전달)
            .disposed(by: disposeBag)
        
        decreaseBtn.rx.tap
            .map { CounterReactor.Action.decrease } // Action Type으로 변경
            .bind(to: reactor.action) //
            .disposed(by: disposeBag)
        
        reactor.state.map { state in // self.reactor의 state에서 value만 가지고 온다
            return state.value
        }
        .map{ "\($0)" }
        .bind(to: numberLabel.rx.text) // reactor로 부터 새롭게 생선된 state를 ViewController 클래스의 numberLabel과 묶는다.
        .disposed(by: disposeBag)
    }
}

