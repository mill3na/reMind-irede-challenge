//
//  BoxViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 17/07/23.
//

import Foundation

class BoxViewModel: ObservableObject {
    @Published var boxes: [Box] = []

    init() {
        self.boxes = Box.all()
    }

    func getNumberOfPendingTerms(of box: Box) -> String {
        return box.termsToReview.count.description
    }
    
    func saveBox(box: Box) {
        CoreDataStack.shared.saveContext()
        boxes.append(box)
    }
    
    func update() {
        boxes = Box.all()
    }
}
