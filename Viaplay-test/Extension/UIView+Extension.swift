//
//  UIView+Extension.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-16.
//

import Foundation
import UIKit

extension UIView {
    
    func constrainToCenter() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                                     centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                                     trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                                     leadingAnchor.constraint(equalTo: superview.leadingAnchor)])
    }
                                     
    func constraintToFillSuperView() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: superview.topAnchor),
                                     bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                                     trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                                     leadingAnchor.constraint(equalTo: superview.leadingAnchor)])
    }
}
