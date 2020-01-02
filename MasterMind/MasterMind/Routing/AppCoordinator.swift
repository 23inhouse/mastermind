//
//  AppCoordinator.swift
//  Github
//
//  Created by Benjamin Lewis on 19/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
  var appViewController: AppViewController
  var previousViewController: UIViewController?

  init(appViewController: AppViewController) {
    self.appViewController = appViewController
  }

  func start() {
    let viewController = MainViewController()
    viewController.coordinator = self
    go(to: viewController)
  }
}

private extension AppCoordinator {
  func go(to viewController: UIViewController) {
    guard let view = viewController.view else { return }

    appViewController.add(viewController)
    appViewController.appView.addSubview(view)
    view.constrain(to: appViewController.appView)

    if let previousViewController = previousViewController {
      previousViewController.remove()
    }
    previousViewController = viewController
  }
}
