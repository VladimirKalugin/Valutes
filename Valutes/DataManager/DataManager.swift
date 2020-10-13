//
//  DataManager.swift
//  Valutes
//
//  Created by Fuhrer_SS on 13.10.2020.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}

    func fetchData(_ completion: @escaping (Valutes) -> Void) {
        
        let urlSourse = "https://www.cbr-xml-daily.ru/daily_json.js"
        
        guard let url = URL(string: urlSourse) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let valutes = try JSONDecoder().decode(Valutes.self, from: data)
                completion(valutes)
            } catch let jsonError {
                print("Ошибка получения данных:", jsonError)
            }
        }.resume()
    }
}

