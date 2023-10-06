//
//  WorkoutsViewModel.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import SwiftUI

class WorkoutsViewModel: ObservableObject {
    static let shared = WorkoutsViewModel()

    @Published var presentedViews = NavigationPath()
}
