//
//  ViewController.swift
//  TestIdeasWorld
//
//  Created by Alina on 2020-06-25.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var filteredStudents = [Student]()
    
    private lazy var listOfStudents: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Enter name or second name"
        return search
    }()
    
    static let reuseId = "ListOfStudentsCell"
    
    var genderFilter: Gender = .all
    var raitingFilter: Rating = .all
    
    let studentGroup = [
        Student(name: "Anton", secondName: "Ivanov", gender: .male, age: 18, rating: 5),
        Student(name: "Ivan", secondName: "Petrov", gender: .male, age: 50, rating: 4),
        Student(name: "Svetlana", secondName: "Utkina", gender: .female, age: 32, rating: 3),
        Student(name: "Lina", secondName: "Luzina", gender: .female, age: 27, rating: 5, socialNetworkingProfile: "https://instagram.com/lzn_ln?igshid=14cxmuyzi1g5t"),
        Student(name: "Petr", secondName: "Sonov", gender: .male, age: 38, rating: 4),
        Student(name: "Katerina", secondName: "Tutova", gender: .female, age: 20, rating: 4),
        Student(name: "Alex", secondName: "Rochev", gender: .male, age: 46, rating: 4),
        Student(name: "Olga", secondName: "Nosova", gender: .female, age: 20, rating: 5, socialNetworkingProfile: "https://www.ted.com"),
        Student(name: "Natasha", secondName: "Okulova", gender: .female, age: 28, rating: 5),
        Student(name: "Alexey", secondName: "Gladkov", gender: .male, age: 29, rating: 5),
        Student(name: "Sofya", secondName: "Farina", gender: .female, age: 33, rating: 3),
        Student(name: "Konstantin", secondName: "Vetrov", gender: .male, age: 25, rating: 2, socialNetworkingProfile: "https://mailfuture.ru/write/"),
        Student(name: "Oleg", secondName: "Safronov", gender: .male, age: 21, rating: 4),
        Student(name: "Alina", secondName: "Chunareva", gender: .female, age: 27, rating: 5, socialNetworkingProfile: "https://vk.com/id343303128"),
        Student(name: "Denis", secondName: "Lobov", gender: .male, age: 20, rating: 4),
        Student(name: "Kirill", secondName: "Kim", gender: .male, age: 18, rating: 5),
        Student(name: "Timur", secondName: "Dvorov", gender: .male, age: 30, rating: 4),
        Student(name: "Alan", secondName: "Buev", gender: .male, age: 22, rating: 5),
        Student(name: "Tanya", secondName: "Hlueva", gender: .female, age: 21, rating: 5, socialNetworkingProfile: "https://vk.com/ideas.apps"),
        Student(name: "Artem", secondName: "Efimov", gender: .male, age: 18, rating: 3),
        Student(name: "Egor", secondName: "Lapin", gender: .male, age: 25, rating: 5),
        Student(name: "Lev", secondName: "Holkin", gender: .male, age: 20, rating: 3),
        Student(name: "Tihon", secondName: "Moev", gender: .male, age: 68, rating: 5),
        Student(name: "Max", secondName: "Durov", gender: .male, age: 24, rating: 5),
        Student(name: "Efim", secondName: "Pupkov", gender: .male, age: 24, rating: 4),
        Student(name: "Rick", secondName: "Astley", gender: .male, age: 54, rating: 5, socialNetworkingProfile: "https://youtu.be/dQw4w9WgXcQ"),
        Student(name: "Elena", secondName: "Anina", gender: .female, age: 18, rating: 5, socialNetworkingProfile: "https://instagram.com/spacex?igshid=1w3pafn4i86b3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(listOfStudents)
        view.addSubview(searchBar)

        sortedStudents()
        
        initConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: width, height: 44))
        self.view.addSubview(navigationBar)
        let navigationItem = UINavigationItem(title: "STUDENTS")
        let filterButton = UIBarButtonItem(image: UIImage(named: "Filter"), style: .plain, target: nil, action: #selector(playFilterButton))
        navigationItem.leftBarButtonItem = filterButton
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func playFilterButton() {
        let filterVC = FilterViewController()
        filterVC.delegate = self
        filterVC.setGenderSegmentedControll(gender: self.genderFilter)
        filterVC.setRatingSegmentedControll(rating: self.raitingFilter)
        present(filterVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: ViewController.reuseId)
            let modelForAllStudents = filteredStudents[indexPath.row]
            cell.textLabel?.text = modelForAllStudents.secondName + " " + modelForAllStudents.name
            cell.detailTextLabel?.text = "Gender: \(modelForAllStudents.gender), Age: \(modelForAllStudents.age), Rating: \(modelForAllStudents.rating)"
        
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func showAlert () {
        let alertController = UIAlertController(title: "Данные не найдены", message: "У студента не указан профиль соц.сети", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let modelForAllStudents = filteredStudents[indexPath.row].socialNetworkingProfile  {
            let vc = SocialNetworkingProfileViewController()
            vc.currentURLString = modelForAllStudents
            present(vc, animated: true, completion: nil)
            
        } else {
        showAlert ()
        }
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 84),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            listOfStudents.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            listOfStudents.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            listOfStudents.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            listOfStudents.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func sortedStudents() {
        filteredStudents = studentGroup.sorted{$0.secondName < $1.secondName}
            .filter{(student) -> Bool in
                switch self.genderFilter {
                case .male: return student.gender == .male
                case .female: return student.gender == .female
                case .all: return true
                }
        }
            .filter{ (student) -> Bool in
            switch self.raitingFilter {
            case .all: return true
            case .rating5: return student.rating >= 5
            }
        }
        listOfStudents.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar( _ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStudents = studentGroup.filter({$0.name.prefix(searchText.count) == searchText || $0.secondName.prefix(searchText.count) == searchText})
        listOfStudents.reloadData()
    }
}

extension ViewController: FilterViewControllerDelegate {
   
    func setGenderFilter(_ gender: Gender) {
        self.genderFilter = gender
        sortedStudents()
    }
    
    func setRatingFilter(_ rating: Rating) {
        self.raitingFilter = rating
        sortedStudents()
    }
}
