//
//  AddTaskProtocol.swift
//  TODO
//
//  Created by Wojtek Rempiński on 29/05/2022.
//

import Foundation

protocol AddTaskProtocol {
    func addTask(title: String, date: Date, category: String)
    func reload()
}
