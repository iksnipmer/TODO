//
//  ViewController.swift
//  TODO
//
//  Created by Wojtek Rempiński on 25/05/2022.
//

import UIKit
import SwipeCellKit


class ToDoViewController: UITableViewController, SwipeTableViewCellDelegate {

    var tasksModel = TasksModel()
    let dateFormatter = DateFormatter()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .short
        guard let navController = navigationController else {fatalError("Thrown Fatal Error, No NavBar.")}
        let navBar = navController.navigationBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(named: Constans.mainColor)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: Constans.orangeColor) ?? .orange]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: Constans.orangeColor) ?? .orange]
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
        tableView.backgroundColor = UIColor(named: Constans.backgroundColor)
        tableView.register(UINib(nibName: Constans.nibName, bundle: nil), forCellReuseIdentifier: Constans.cellId)
        
        if tasksModel.howManyTasks() == 0{
            let dialogMessage = UIAlertController(title: "Informacja", message: "Nie utworzono żadnego zadania", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksModel.howManyTasks()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constans.cellId, for: indexPath) as! TaskCell
        cell.delegate = self
        cell.taskLabel.text = tasksModel.getTaskTitle(index: indexPath.row)
        cell.viewBackground.backgroundColor = UIColor(hex: tasksModel.getTaskBackgrounbColor(index: indexPath.row))
        cell.deadlineLabel.text = dateFormatter.string(from: tasksModel.getTaskDeadline(index: indexPath.row))
        cell.taskImage.image = UIImage.init(systemName: tasksModel.getTaskImage(index: indexPath.row))
        cell.backgroundColor = UIColor(named: Constans.backgroundColor)
        cell.selectionStyle = .none
        cell.viewBackground.layer.cornerRadius = 15
        self.tableView.separatorColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: Constans.segueName, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let destinationVC = segue.destination as? InsertViewController{
          destinationVC.pickerData = tasksModel.getCategoriesNames()
          destinationVC.delegate = self
          tasksModel.delegate = destinationVC
        }
    }
    
    //MARK: - SwipeTableViewCellDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
            let deleteAction = SwipeAction(style: .destructive, title: "Usuń") { action, indexPath in
                let alert = UIAlertController(title: "Usuwanie zadania", message: "Czy na pewno chcesz usunąć zadanie?", preferredStyle: .alert)
                let deleteAction = UIAlertAction(title: "Usuń", style: .destructive, handler: { (action) in
                    self.tasksModel.removeTask(index: indexPath.row)
                    tableView.reloadData()
                })
                alert.addAction(deleteAction)
                let cancelAction = UIAlertAction(title: "Anuluj", style: .cancel)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            deleteAction.image = UIImage(named: "trash_icon")
            return [deleteAction]
    }
}

//MARK: - AddTaskProtocol extensions
extension ToDoViewController: AddTaskProtocol{
    func reload() {
        self.dismiss(animated: true){
            self.tableView.reloadData()
        }
    }
    
    func addTask(title: String, date: Date, category: String) {
        tasksModel.addTask(title: title, date: date, category: category)
    }
}



