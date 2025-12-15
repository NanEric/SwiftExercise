//
//  FormAuth.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/15.
//

import Foundation
import Combine

//表单验证：基于 Combine 实现一个登录表单实时验证：
//用户名：非空，至少 6 位；
//密码：非空，至少 8 位，包含字母和数字；
//实时监听两个输入框的变化，动态更新 “登录按钮是否可点击”；
//验证状态通过 @Published 暴露，UI 响应式更新。
