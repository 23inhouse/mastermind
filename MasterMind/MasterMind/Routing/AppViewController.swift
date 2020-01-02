//
//  AppViewController.swift
//  Github
//
//  Created by Benjamin Lewis on 19/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
  var appView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }
}

private extension AppViewController {
  func setupView() {
    view.backgroundColor = .white
    view.addSubview(appView)
    appView.constrain(to: view)
    appView.backgroundColor = .white
  }
}
