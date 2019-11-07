//
//  ColorInfo.swift
//  NestedStack
//
//  Created by Jahyun Oh on 07/10/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

struct ColorInfo: Decodable {
    let data: [Item]

    struct Item: Decodable, Equatable {
        let name: String
        let description: String
    }
}

extension ColorInfo {
    static func load() -> ColorInfo? {
        guard let url = Bundle.main.url(forResource: "ColorInfo", withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let colors = try? JSONDecoder().decode(ColorInfo.self, from: data) else { return nil }
        return colors
    }
}

enum NamedColor: String {
    case red = "Red"
    case green = "Green"
    case blue = "Blue"
    case pink = "Pink"

    var value: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .pink:
            return .systemPink
        }
    }
}
