//
//  MyStateMachine.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/10.
//


/*
 状态（state）总数是有限的；
 任何时刻只在一种状态之中；
 接收到某个事件（event）触发后，会从一种状态转移（transition）到另一种状态。
 */

import Foundation

// 事件
//public protocol EventType:Hashable {}

public enum ConfigEvent: Hashable {
    /// 进入搜索结果页面
    case jumpToSearchResultView
    /// 进入输入密码页面
    case jumpToInputPasswordView
    /// 进入权限提示页面
    case jumpToAuthorityView
    /// 开始发送 wifi 和密码
    case jumpToConfigView
    ///  进入账号密码错误页面
    case jumpToIllegalPasswordView
    /// 配网成功
    case jumpToConfigSuccessView
    /// 配网失败
    case jumpToConfigFailureView
    
}


public enum ConfigState:Hashable {
    /// 搜索结果页面
    case searchState
    /// 权限提示页面
    case authorityState
    /// 输入密码页面
    case passwordState
    /// 发送wifi和密码
    case configState
    /// wifi名称密码错误
    case illegalPasswordState
    /// 配网成功
    case ConfigSuccessState
    /// 配网失败
    case ConfigFailureState
}


public struct Transition {

    // 事件
    let event:ConfigEvent
    // 原本状态
    let originalState: ConfigState
    // 目标状态
    let targetState: ConfigState
    
    init(event: ConfigEvent, originalState: ConfigState, targetState: ConfigState) {
        self.event = event
        self.originalState = originalState
        self.targetState = targetState
    }

}

final public class StateMachine{
    
    // 封装操作及回调
    private struct Operation{
        let transition : Transition
        // 操作完成的回调
        let callBack : (Transition) -> ()
    }
    
     static let shared = {
        let instance = StateMachine.init(currentState: .searchState)
        return instance
    }()
    

    // 记录操作对应字典
    private var transitionsByEvent:[ConfigState : [ConfigEvent:Operation]] = [:]
    
    var currentState:ConfigState
    
    private init(currentState:ConfigState) {
        self.currentState = currentState
    }
    
    // 用来记录 transition
    func add(event:ConfigEvent,originalState: ConfigState,targetState: ConfigState,callback:@escaping (Transition) -> ()) {
        var operations = transitionsByEvent[originalState] ?? [:]
        let transition = Transition(event: event, originalState: originalState, targetState: targetState)
        let operation = Operation(transition: transition, callBack: callback)
        operations[event] = operation
        transitionsByEvent[originalState] = operations
    }
    
    // 变化
    func trigger (event:ConfigEvent) {
        guard let operation = transitionsByEvent[currentState]?[event] else { return }
        operation.callBack(operation.transition)
        currentState = operation.transition.targetState
    }
}


















