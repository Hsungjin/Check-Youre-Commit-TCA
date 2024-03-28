//
//  Userdefaults+Extensions.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import Foundation

extension UserDefaults {
    private static let isUserLogin = "isUserLogin"
    
    func setLoginState(_ login: Bool) {
        set(login, forKey: UserDefaults.isUserLogin)
    }
    
    func getLoginState() -> Bool {
        return bool(forKey: UserDefaults.isUserLogin)
    }
}

extension UserDefaults {
    private static let userLoginKey = "userLoginKey"

    func setUserLogin(_ login: String) {
        set(login, forKey: UserDefaults.userLoginKey)
    }

    func getUserLogin() -> String? {
        return string(forKey: UserDefaults.userLoginKey)
    }
}

extension UserDefaults {
    private static let userAcessToken = "acessToken"

    func setAccessToken(_ token: String) {
        set(token, forKey: UserDefaults.userAcessToken)
    }

    func getAccessToken() -> String? {
        return string(forKey: UserDefaults.userAcessToken)
    }
}

extension UserDefaults {
    private static let userNickname = "userNickname"

    func setUserName(_ name: String) {
        set(name, forKey: UserDefaults.userNickname)
    }

    func getUserName() -> String? {
        return string(forKey: UserDefaults.userNickname)
    }
}

extension UserDefaults {
    private static let userGoal = "userGoal"
    
    func setUserGoal(_ day: Int) {
        set(day, forKey: UserDefaults.userGoal)
    }
    
    func getUserGoal() -> Int {
        return integer(forKey: UserDefaults.userGoal)
    }
}
