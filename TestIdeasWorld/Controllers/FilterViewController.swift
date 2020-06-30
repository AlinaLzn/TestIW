//
//  FilterViewController.swift
//  TestIdeasWorld
//
//  Created by Alina on 2020-06-29.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func setGenderFilter(_ gender: Gender)
    func setRatingFilter(_ rating: Rating)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    private var genderFilter: Gender = .all
    private var raitingFilter: Rating = .all
    
    public func setGenderSegmentedControll(gender: Gender) {
        self.genderFilter = gender
    }
    
    public func setRatingSegmentedControll(rating: Rating) {
        self.raitingFilter = rating
    }
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filters"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        
        return label
    }()
    
    
    private lazy var rating5Students: UISegmentedControl = {
        let segmentItems = ["Rating 5", "All Students"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentControlRating5Students(_:)), for: .valueChanged)
        
        switch self.raitingFilter {
        case .rating5: segmentedControl.selectedSegmentIndex = 0
        case .all: segmentedControl.selectedSegmentIndex = 1
        }
        
        return segmentedControl
    }()
    
    private lazy var studentsGender: UISegmentedControl = {
        let segmentItems = ["Male", "Female", "All"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentControlGenderStudents(_:)), for: .valueChanged)
        
        switch self.genderFilter {
        case .male: segmentedControl.selectedSegmentIndex = 0
        case .female: segmentedControl.selectedSegmentIndex = 1
        case .all: segmentedControl.selectedSegmentIndex = 2
        }
        return segmentedControl
    }()
    
    @objc func segmentControlRating5Students(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            self.raitingFilter = .rating5
            delegate?.setRatingFilter(self.raitingFilter)
        case 1:
            self.raitingFilter = .all
            delegate?.setRatingFilter(self.raitingFilter)
        default: break
        }
    }
    
    @objc func segmentControlGenderStudents(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            self.genderFilter = .male
            delegate?.setGenderFilter(self.genderFilter)
        case 1:
            self.genderFilter = .female
            delegate?.setGenderFilter(self.genderFilter)
        case 2:
            self.genderFilter = .all
            delegate?.setGenderFilter(self.genderFilter)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        view.addSubview(filterLabel)
        view.addSubview(rating5Students)
        view.addSubview(studentsGender)
        
        initConstraints()
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            
            filterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            filterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            filterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            filterLabel.heightAnchor.constraint(equalToConstant: 50),
            
            rating5Students.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 40),
            rating5Students.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rating5Students.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rating5Students.heightAnchor.constraint(equalToConstant: 50),
            
            studentsGender.topAnchor.constraint(equalTo: rating5Students.bottomAnchor, constant: 20),
            studentsGender.leadingAnchor.constraint(equalTo: rating5Students.leadingAnchor),
            studentsGender.trailingAnchor.constraint(equalTo: rating5Students.trailingAnchor),
            studentsGender.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
