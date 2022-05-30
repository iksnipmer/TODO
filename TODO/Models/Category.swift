//
//  Category.swift
//  TODO
//
//  Created by Wojtek Rempiński on 28/05/2022.
//

import Foundation

class Category{
    let name: String
    let backgroundColor: String
    let icon: String
    
    init(name: String, backgroundColor: String, icon: String){
        self.name = name
        self.backgroundColor = backgroundColor
        self.icon = icon
    }
    func getCategoryName() -> String{
        return self.name
    }
    
    func getCategoryBackgroundColor() -> String{
        return self.backgroundColor
    }
    
    func getCategoryIcon() -> String{
        return self.icon
    }
}
