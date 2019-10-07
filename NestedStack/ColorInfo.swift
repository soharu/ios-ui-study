//
//  ColorInfo.swift
//  NestedStack
//
//  Created by Jahyun Oh on 07/10/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

struct ColorInfo: Equatable {
    let color: UIColor
    let name: String
    let description: String

    static let red = ColorInfo(
        color: .systemRed,
        name: "Red",
        description: "Red is the color at the end of the visible spectrum of light, next to orange and opposite violet. It has a dominant wavelength of approximately 625–740 nanometres. It is a primary color in the RGB color model and the CMYK color model, and is the complementary color of cyan."
    )

    static let green = ColorInfo(
        color: .systemGreen,
        name: "Green",
        description: "Green is the color between blue and yellow on the visible spectrum. It is evoked by light which has a dominant wavelength of roughly 495–570 nm."
    )

    static let blue = ColorInfo(
        color: .systemBlue,
        name: "Blue",
        description: "Blue is one of the three primary colours of pigments in painting and traditional colour theory, as well as in the RGB colour model. It lies between violet and green on the spectrum of visible light. The eye perceives blue when observing light with a dominant wavelength between approximately 450 and 495 nanometres."
    )

    static let pink = ColorInfo(
        color: .systemPink,
        name: "Pink",
        description: "Pink is a pale red color that is named after a flower of the same name. It was first used as a color name in the late 17th century. According to surveys in Europe and the United States, pink is the color most often associated with charm, politeness, sensitivity, tenderness, sweetness, childhood, femininity and the romantic. A combination of pink and white is associated with chastity and innocence, whereas a combination of pink and black links to eroticism and seduction."
    )
}
