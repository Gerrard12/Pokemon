//
//  Coordinator.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}

