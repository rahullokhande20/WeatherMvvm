//
//  DetailsViewModel.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
class DetailsViewModel{
    @Published var item:List
    @Published var error: String?
    init(item: List) {
        self.item = item
    }
}
