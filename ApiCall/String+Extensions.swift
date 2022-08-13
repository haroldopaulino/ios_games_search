//
//  String+Extensions.swift
//
//  Created by Haroldo Paulino on 5/2/22.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
