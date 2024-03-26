//
//  RealmManager.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted var name = ""
    @Persisted var age = 0
    @Persisted var color = ""
    @Persisted var currentCity = ""
    @Persisted var citiesVisited: MutableSet<String>
    @Persisted var companion: AnyRealmValue
    // To-one relationship
    @Persisted var favoriteToy: DogToy?
    // Map of city name -> favorite park in that city
    @Persisted var favoriteParksByCity: Map<String, String>
}

class DogToy: Object {
    @Persisted var name = ""
}

class RealmManager {
    static let shared = RealmManager()
    
    private let realm = try! Realm()
    
    private init() { }
    
//    func updateLoginState(code: String) {
//        let user = User()
//        user.code = code
//        
//        do {
//            try realm.write {
//                realm.add(user)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    func testfunc() {
        // (1) Create a Dog object from a dictionary
        let myDog = Dog(value: ["name": "Pluto", "age": 3])
        // (2) Create a Dog object from an array
        let myOtherDog = Dog(value: ["Fido", 5])
        let realm = try! Realm()
        // Add to the realm inside a transaction
        try! realm.write {
            realm.add([myDog, myOtherDog])
        }
    }
}
