//
//  Student.swift
//  TestIdeasWorld
//
//  Created by Alina on 2020-06-25.
//  Copyright © 2020 Alina. All rights reserved.
//

import Foundation

enum Gender {
   case male, female, all
}

class Student {
    
    var name: String
    var secondName: String
    var gender: Gender
    var age: Int
    var rating: Int
    var socialNetworkingProfile: String?
    
    func takeTheExam() {
        print("I am pleased that you have passed the exam!")
    }
        
    init(name: String, secondName: String, gender: Gender, age: Int, rating: Int, socialNetworkingProfile: String? = nil) {
        self.name = name
        self.secondName = secondName
        self.gender = gender
        self.age = age
        self.rating = rating
        self.socialNetworkingProfile = socialNetworkingProfile
    }
}

enum Rating {
    case rating5, all
}





