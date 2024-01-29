//
//  reMindApp.swift
//  reMind
//
//  Created by Pedro Sousa on 23/06/23.
//

import SwiftUI

@main
struct reMindApp: App {
    
    @State var paths = NavigationPath()
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack(path: $paths) {
                BoxesView(viewModel: BoxViewModel(), paths: $paths)
            }
        }
    }
}
