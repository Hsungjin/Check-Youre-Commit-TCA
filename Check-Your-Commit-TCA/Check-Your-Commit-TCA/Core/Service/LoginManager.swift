//
//  LoginManager.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import Alamofire
import SwiftUI
import SwiftSoup

class LoginManager {
    
    static let shared = LoginManager()
    
    private let scope: String = "repo gist user"
    private let githubURL: String = "https://github.com"
    private let githubApiURL: String = "https://api.github.com"
    private var code = ""
    var testCase: [String: Int] = [:]
    
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
    
    func getCommitData() async -> Int {
        var commitDay: Int = 0
        
        guard let url = URL(string: "http://github.com/users/\(UserDefaults.standard.getUserLogin()!)/contributions") else {
            print("Invalid URL")
            return 0
        }
        
        do {
            // URLSession의 비동기 메서드를 사용하여 데이터를 가져옵니다.
            let (data, _) = try await URLSession.shared.data(from: url)
            if let html = String(data: data, encoding: .utf8) {
                let parsedHtml = try SwiftSoup.parse(html)
                let dailyContribution = try parsedHtml.select("td")
                
                let validCommits = dailyContribution.compactMap { element -> (String, String)? in
                    guard
                        let dateString = try? element.attr("data-date"),
                        let levelString = try? element.attr("data-level"),
                        !dateString.isEmpty
                    else { return nil }
                    
                    return (dateString, levelString)
                }
                
                if dataToDictionary(validCommits) {
                    commitDay = findConsecutiveDates(withData: testCase)
                }
            }
        } catch {
            print("Error fetching or parsing data: \(error)")
        }
        return commitDay
    }
    
    func dataToDictionary(_ data: [(String, String)]) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // 정렬된 데이터를 딕셔너리로 변환하고 날짜를 String으로 변환하여 데이터를 Int로 변경
        for tuple in data {
            if let date = dateFormatter.date(from: tuple.0) {
                let dateString = dateFormatter.string(from: date)
                let dataInt = Int(tuple.1) ?? 0 // 데이터를 Int로 변환, 실패하면 기본값 0
                self.testCase[dateString] = dataInt * 3
            }
        }
        return true
    }
    
    func findConsecutiveDates(withData data: [String: Int]) -> Int {
        // 값이 1 이상인 날짜를 찾아서 sort 해줌
        let filteredDates = data.filter { $0.value >= 1 }.keys.sorted()
        
        // 문자열 형식의 날짜를 Date 객체로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateObjects = filteredDates.compactMap { dateFormatter.date(from: $0) }.sorted()
        
        // 연속된 날짜를 찾습니다.
        var currentConsecutive: [String] = []
        
        for (index, date) in dateObjects.enumerated() {
            if index == 0 {
                currentConsecutive.append(dateFormatter.string(from: date))
            } else {
                let previousDate = dateObjects[index - 1]
                let currentDate = date
                
                // 이전 날짜와의 일수 차이를 확인하여 연속된 경우를 판별합니다.
                if let daysBetween = Calendar.current.dateComponents([.day], from: previousDate, to: currentDate).day, daysBetween == 1 {
                    currentConsecutive.append(dateFormatter.string(from: date))
                } else {
                    currentConsecutive = [dateFormatter.string(from: date)]
                }
            }
        }
        // 가장 최신 날짜 - 디버깅용
        print(currentConsecutive)
//        print(currentDateFormatted())
        
        // currentDateFormatted(연속된 날짜를 저장한 배열)의 마지막값은 최근 커밋날짜가 되므로 조건문 실행으로 연속 커밋날짜 판독
        if currentConsecutive.last == currentDateFormatted() {
            return Int(currentConsecutive.count) + 1
        } else {
            return 0
        }
    }
    
    // 오늘의 날자를 String 타입으로 가져와줌
    func currentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}
