//
//  TaskModel.swift
//  TODO
//
//  Created by Wojtek Rempiński on 28/05/2022.
//

import Foundation
import CoreImage
import CoreData
import UIKit


class TasksModel{
    var delegate: AlertSavingProtocol?
    private let categoriesArray = [
        Category(name: "Praca", backgroundColor: "#30ab34", icon: "doc.plaintext"),
        Category(name: "Zakupy", backgroundColor: "#ffba01", icon: "bag"),
        Category(name: "Inne", backgroundColor: "#1c6466", icon: ""),
        Category(name: "Samochód", backgroundColor: "#770807", icon: "car.fill"),
        Category(name: "Dom", backgroundColor: "#671DAD", icon: "house.fill"),
        Category(name: "Sport", backgroundColor: "#44AD2F", icon: "sportscourt")
    ]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var tasksArray = [Task]()
    
    func addTask(title: String, date: Date, category: String){
        let newTask = Task(context: context)
        newTask.title = title
        newTask.date = date
        newTask.category = category
        saveTasks()
        tasksArray.append(newTask)
    }
    
    func removeTask(index: Int){
        context.delete(tasksArray[index])
        tasksArray.remove(at: index)
        updateTasks()
    }
    
    func updateTasks(){
        do {
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func saveTasks(){
        do {
            try context.save()
            delegate?.showSuccessAlert()
        }catch{
            delegate?.showFailureAlert()
        }
    }
    
    init(){
        loadTasks()
    }
    
    func howManyTasks() -> Int{
        return tasksArray.count
    }
    
    func getCategoriesNames() -> [String] {
        var namesArray = [String]()
        for category in categoriesArray{
            namesArray.append(category.name)
        }
        return namesArray
    }
    
    func getTaskTitle(index: Int) -> String {
        return tasksArray[index].title!
    }
    
    func getTaskDeadline(index: Int) -> Date {
        return tasksArray[index].date!
    }
    
    func getTaskImage(index: Int) -> String {
        for category in categoriesArray{
            if category.name == tasksArray[index].category{
                return category.icon
            }
        }
        return "note-text"
    }
    
    func getTaskBackgrounbColor(index: Int) -> String {
        for category in categoriesArray{
            if category.name == tasksArray[index].category!{
                return category.backgroundColor
            }
        }
        return "000000"
    }
    
    func getBackgroundColorForCategory(categoryName category: String) -> String{
        for categoryFromArray in categoriesArray{
            if categoryFromArray.name == category{
                return categoryFromArray.backgroundColor
            }
        }
        return "FFFFFF"
    }
    
    func getIconForCategory(categoryName category: String) -> String{
        for categoryFromArray in categoriesArray{
            if categoryFromArray.name == category{
                return categoryFromArray.getCategoryIcon()
            }
        }
        return "note-text"
    }
    
    func loadTasks(){
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        do{
            tasksArray = try context.fetch(request)
        }catch{
            print("error")
        }
    }
}





