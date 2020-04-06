//
//  SettingsSection.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    //case Social
    case Communications
    
    var description: String {
        switch self {
        //case .Social: return "Social"
        case .Communications: return "設定"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    case editProfile
    case logout
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .logout: return "Log Out"
        }
    }
}

enum CommunicationOptions: Int, CaseIterable, SectionType {
    case notifications
    case email
    //case reportCrashes
    
    var containsSwitch: Bool {
        switch self {
        case .notifications: return true
        case .email: return true
        //case .reportCrashes: return true
        }
    }
    
    var description: String {
        switch self {
        case .notifications: return "使用白話字（關閉則使用教育部羅馬字）"
        case .email: return "使用漢字（關閉則使用羅馬字）"
        //case .reportCrashes: return "開啟震動"
        }
    }
}
