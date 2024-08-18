//
//  UserLocation.swift
//  Connected
//
//  Created by 정근호 on 8/17/24.
//

import UIKit

// 유저 id, 위치, 프로필 등
struct UserLocation: Identifiable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
    let profileImageURL: String
    var profileImage: UIImage?
}