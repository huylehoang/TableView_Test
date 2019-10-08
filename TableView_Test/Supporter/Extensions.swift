//
//  Helper.swift
//  TableView_Test
//
//  Created by LeeX on 9/21/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    func emptyScreen(withText text: String? = "Empty") {
        if let tableView = view.subviews.filter({ $0 is UITableView }).first {
            tableView.isHidden = true
        }
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}
