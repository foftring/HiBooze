//
//  ProfileViewModel.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/4/22.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var goalDrinks: Int = 31
    @Published var isShowingPhotoPicker: Bool = false
    @Published var profileImage : UIImage {
        didSet {
            saveProfileImage()
        }
    }
    
    
    let manager = LocalFileManager.instance
    
    func saveProfileImage() {
        manager.saveImage(image: profileImage, name: "profileImageCompressed")
    }
    
    init() {
        self.profileImage = manager.getImage(name: "profileImageCompressed") ?? UIImage(named: "default-avatar")!
    }
    
}
