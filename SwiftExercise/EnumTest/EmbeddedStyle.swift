//
//  EmbeddedStyle.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/17.
//

import Foundation

// 定义一个struct类型（柜子），内部包含一个enum，代表一个定制的类型（木质的，铁质的，塑料的）。

struct Cabinet {
    enum Style {
        case wooden(woodPrice: Double)
        case iron(weight: Double)
        case plastic(color: String)
    }
    
    let style: Style
}

class CabinetPrinter {
    private var innerCabinet: Cabinet?
    
    init(cabinet: Cabinet) {
        innerCabinet = cabinet
    }

    func printStyle() {
        guard let innerCabinet = innerCabinet else { return }
        switch innerCabinet.style {
            case .wooden(let woodPrice):
                print(" wooden cabinet, woodPrice: \(woodPrice)")
            case .iron(let weight):
                print(" iron cabinet, weight: \(weight)")
            case .plastic(let color):
                print(" plastic cabinet, color: \(color)")
        }
    }
}
