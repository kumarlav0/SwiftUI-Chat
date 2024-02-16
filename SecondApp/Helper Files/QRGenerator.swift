//
//  QRGenerator.swift
//  SecondApp
//
//  Created by MacBook27 on 13/02/24.
//

import SwiftUI

class QRGenerator {
    static let shared = QRGenerator()
    
    private func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
    
    func getQRCodeFrom(text: String) -> UIImage {
        UIImage(data: getQRCodeDate(text: text)!)!
    }
    
    func loadUserDataAsString() -> String? {
        if let url = Bundle.main.url(forResource: "UserData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let userData = try JSONDecoder().decode(ContactData.self, from: data)
                
                // Encode the user data as JSON data
                let jsonData = try JSONEncoder().encode(userData)
                
                // Convert the JSON data to a string
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    return jsonString
                }
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return nil
    }
    
    func getContactDataFrom(qrCode jsonString: String) -> ContactData? {
        do {
            guard let jsonData = jsonString.data(using: .utf8) else {
                print("Failed to convert string to data")
                return nil
            }
            let userData = try JSONDecoder().decode(ContactData.self, from: jsonData)
            return userData
        } catch {
            print("Error decoding JSON data: \(error)")
            return nil
        }
    }

}
