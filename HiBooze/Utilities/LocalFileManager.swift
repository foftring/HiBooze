//
//  LocalFileManager.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/3/22.
//

import Foundation
import UIKit


class LocalFileManager: ObservableObject {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 0.5),
        let path = getPathForImage(name: name) else {
            print("Error getting data")
            return
        }
        
        do {
            try data.write(to: path)
            print("Success saving")
        } catch let error {
            print("Error saving \(error)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
                  print("Error getting path")
                  return nil
              }
        print("Printing path")
        print(path)
        return UIImage(contentsOfFile: path)
        
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
    
}
