//
//  SectionModel.swift
//  TableView_Test
//
//  Created by LeeX on 9/21/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import RxDataSources
import RxCocoa
import RxSwift

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: SectionModelType {
    typealias Item = String

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
