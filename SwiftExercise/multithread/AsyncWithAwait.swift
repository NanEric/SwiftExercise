//
//  AsyncWithAwait.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/16.
//

import Foundation


//许多老旧的 SDK 或您自己的旧代码仍然使用 completion handler（完成回调）。您需要将一个基于回调的 API 转换为现代的 async/await 样式，以使其能与其他现代并发代码无缝集成。
//场景： 您的老旧网络代码中有一个基于 completion handler 的函数：
//enum DataError: Error {
//    case network
//    case decoding
//}
//
//// 这是一个基于回调的旧函数
//func fetchProfile(id: Int, completion: @escaping (Result<String, DataError>) -> Void) {
//    // 模拟网络延迟和成功/失败
//    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
//        if id == 404 {
//            completion(.failure(.network))
//        } else {
//            completion(.success("User Profile for \(id)"))
//        }
//    }
//}
// **练习要求：**
//
//创建一个新的 async 函数 func loadProfile(id: Int) async throws -> String。
//
//在这个 async 函数中，调用旧的 fetchProfile 函数。
//
//使用 withCheckedThrowingContinuation 来安全地将回调的 Result 结果桥接到 async/await。


class RewriteToNewStyle {
    enum DataError: Error {
        case network
        case decoding
    }

    func fetchProfileOriginal(id: Int, completion: @escaping (Result<String, DataError>) -> Void) {
        // 模拟网络延迟和成功/失败
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if id == 404 {
                completion(.failure(.network))
            } else {
                completion(.success("User Profile for \(id)"))
            }
        }
    }
    
    // 方法一//////////////////////////
    // 这是一个基于回调的旧函数
    func fetchProfile(id: Int) async throws -> String {
        // 模拟网络延迟和成功/失败
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        if id == 404 {
            throw DataError.network
        }
        
        return "User Profile for \(id)"
    }
    
    // 方法二 ： 当fetchProfileOriginal是第三方库提供的时候，可以用方法二进行改写。////////////////////////
    func fetchProfileAsync(id: Int) async throws -> String {
        // 将基于回调的 API 转换为 async
        try await withCheckedThrowingContinuation { continuation in
            fetchProfileOriginal(id: id) { result in
                switch result {
                case .success(let profile):
                    continuation.resume(returning: profile)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    
    func callFetchProfile() {
        Task {
            do {
                let profile = try await fetchProfile(id: 100)
                print("success:\(profile)")
            } catch {
                print("error:\(error)")
            }
        }
        
        
    }
}




