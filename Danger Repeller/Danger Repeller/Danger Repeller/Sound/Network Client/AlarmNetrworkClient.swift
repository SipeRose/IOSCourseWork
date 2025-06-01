//
//  AlarmNetrworkClient.swift
//  Danger Repeller
//
//  Created by Никита Волков on 01.06.2025.
//

import UIKit

// MARK: Сетевой слой для отправки сигнала тревоги
final class AlarmNetrworkClient {
    
    static func postAlarm(about dangerType: String) {
        // Имитация API, развернутая на локальном Mac с локально БД на PostgreSQL
        guard let url = URL(string: "http://192.168.0.13:5001/data") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let deviceName = UIDevice.current.name
        let posts = ["app_id": deviceName, "danger_type": dangerType]
        let jsonData = try? JSONSerialization.data(withJSONObject: posts)
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = data {
                print("Запрос отправлен")
            } else if let error = error {
                print(" Ошибка: \(error)")
            }
        }.resume()
    }
    
}
