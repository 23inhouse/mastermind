//
//  Collection+Optional.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation
extension Collection {
  subscript(optional i: Index) -> Iterator.Element? {
    return self.indices.contains(i) ? self[i] : nil
  }
}
