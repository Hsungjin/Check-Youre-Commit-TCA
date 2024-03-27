//
//  LoginManager.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import Alamofire
import Realm
import RealmSwift
import SwiftUI

class LoginManager {
    
    static let shared = LoginManager()

    private let scope: String = "repo gist user"
    private let githubURL: String = "https://github.com"
    private let githubApiURL: String = "https://api.github.com"
    private var code = ""
    
    // 깃허브 api 에서 제공하는 형식의 로그인 페이지 연결 URL
    func requestCode() -> URL? {
        let loginURL = "https://github.com/login/oauth/authorize?client_id=\(client_id)&redirect_uri=\(redirectURL)&scope=user"
        return URL(string: loginURL)
    }
    
    // 로그인 완료시 지정한 redirectURL으로 전환되는데 그 뒤의 코드 값을 얻기위한 코드
    func handleCodeFromURL(_ url: URL) async -> Bool {
//        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        if let code = url.absoluteString.components(separatedBy: "code=").last {
//            RealmManager.shared.updateLoginState(code: code)
            self.code = code
            return true
        }
        return false
    }
    
    // 코드값을 토대로 액세스 토큰을 얻기위한 함수
    func get_access_token() async {
        let params = ["client_id": client_id,
                      "client_secret": client_secret,
                      "code": code]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        do {
            let response = try await AF.request("https://github.com/login/oauth/access_token",
                                      method: .post, parameters: params,
                                      headers: headers).serializingDecodable([String: String].self).value
            print(response)
            if let token = response["access_token"] {
                UserDefaults.standard.setAccessToken(token)
                print(UserDefaults.standard.getAccessToken()!)
                await self.getUser()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // 유저정보를 받아오기 위한 함수
    func getUser() async {
        let test = UserDefaults.standard.getAccessToken()
        let headers: HTTPHeaders = ["Accept": "application/vnd.github+json",
                                    "Authorization": "Bearer \(test!)"]

        do {
            let response = try await AF.request("https://api.github.com/user",
                                                method: .get, parameters: [:],
                                                headers: headers).serializingDecodable(User.self).value
            UserDefaults.standard.setUserLogin(response.login)
            UserDefaults.standard.setUserName(response.name)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
