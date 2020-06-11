//
//  Profile.swift
//  NoticeSound
//
//  Created by Yuriy  Troyan on 12/11/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

enum ProfileNotification {
    static let accessKeysQuantityUpdated = NSNotification.Name("AccessKeysQuantityUpdated")
}

class Profile: NSObject {
    static let shared = Profile()

    private let profileKey = "profile"
    private let appWasStartedKey = "appWasStarted"

    public var temporaryRestorationCode: String?

    private func getProfile() -> ProfileModel? {
        guard let profileData = UserDefaults.standard.value(forKey: profileKey) as? Data else {return nil}
        do {
            let profile = try PropertyListDecoder().decode(ProfileModel.self, from: profileData)
            return profile
        } catch {
            print(error)
            return nil
        }
    }
    private func storeProfile(_ profile: ProfileModel) {
        do {
            let propertyList = try PropertyListEncoder().encode(profile)
            UserDefaults.standard.set(propertyList, forKey: profileKey)
        } catch {
            print(error)
        }
    }

    public func saveProfile(dict:[String:Any]){
        guard let profile = ProfileModel(dict: dict) else {return}
        storeProfile(profile)
    }
    public func updateProfile(dict:[String:Any]){
        if let newProfile = ProfileModel(dict: dict) {
            storeProfile(newProfile)
        } else if let updatedDetails = ProfileDetails(dict: dict) {
            if let profile = getProfile() {
                profile.details = updatedDetails
                storeProfile(profile)
            }
        }
    }
    
    public func getToken() -> String? {
        guard let profile = getProfile() else { return nil}
        return profile.token
    }
    public func userID() -> String? {
        guard let profile = getProfile() else { return nil}
        return String(profile.details.id)
    }
    
    public func logout () {
        UserDefaults.standard.removeObject(forKey: profileKey)
    }
    //MARK: - Sounders
    public func fbIsAdded() -> Bool{
        guard let profile = getProfile() else {return false}
        return profile.details.socialAccounts?.facebook != nil
    }
    
    public func spotifyIsAdded() -> Bool {
        guard let profile = getProfile() else {return false}
        return profile.details.socialAccounts?.spotify != nil
    }
    
    public func emailIsAdded() -> Bool {
        guard let profile = getProfile() else {return false}
        return profile.details.email != nil
    }
    
    public func needToShowWizzard() -> Bool {
        return UserDefaults.standard.value(forKey: appWasStartedKey) == nil
    }

    //MARK: - MusiQuiz
    public func currentScore() -> Score? {
        guard let profile = getProfile() else {return nil}
        return profile.details.game?.score
    }
    public func updateScore(_ score: Score) {
        guard let profile = getProfile(), let game = profile.details.game else {return}
        game.score = score
        profile.details.game = game
        storeProfile(profile)
    }
    public var availableKeys: Int {
        get {
            guard let profile = getProfile(), let game = profile.details.game else {return 0}
            return game.accessKeys
        }
        set {
            guard let profile = getProfile(), let game = profile.details.game else {return}
            game.accessKeys = newValue
            profile.details.game = game
            storeProfile(profile)
            NotificationCenter.default.post(name: ProfileNotification.accessKeysQuantityUpdated, object: nil)
        }
    }
}
fileprivate enum Key {
    static let id = "id"
    static let token = "token"
    static let email = "email"
    static let name = "name"

    static let socialAccounts = "socialAccounts"
    static let facebook = "facebook"
    static let spotify = "spotify"

    static let extensions = "_extensions"
    static let artist = "artist"

    static let game = "game"
    static let gamePoints = "game_points"
    static let shopPoints = "shop_points"
    static let accessKeys = "key_count"
}
fileprivate class ProfileModel: NSObject, Codable {
    var token: String
    var details: ProfileDetails

    init?(dict: [String:Any]) {
        guard let token = dict[Key.token] as? String, let profile = ProfileDetails(dict: dict) else { return nil }
        self.token = token
        self.details = profile
    }
}
fileprivate class ProfileDetails: NSObject, Codable {
    let id: Int
    var email: String?
    var socialAccounts: SocialAccounts?
    var game: GameExtension?
    /* for further use of info received at login (Sounders)
     var artist: ArtistExtension?
     */

    init?(dict: [String:Any]) {
        guard let id = dict[Key.id] as? Int else {
            return nil
        }
        self.id = id

        if let email = dict[Key.email] as? String {
            self.email = email
        }
        if let socialAccounts = dict[Key.socialAccounts] as? [String: String] {
            self.socialAccounts = SocialAccounts(dict: socialAccounts)
        }
        if let extensions = dict[Key.extensions] as? [String: Any] {
            if let gameDict = extensions[Key.game] as? [String:Any] {
                self.game = GameExtension(dict: gameDict)
            }
            /* for further use of info received at login (Sounders)
             if let artistDict = extensions[Key.artist] as? [String:Any] {
             self.artist = ArtistExtension(dict: artistDict)
             }
             */
        }
        super.init()

    }
}

fileprivate class SocialAccounts: Codable {
    var facebook: String?
    var spotify: String?

    init?(dict: [String:String]) {
        if dict.isEmpty {
            return nil
        } else {
            if let fb = dict[Key.facebook] {
                self.facebook = fb
            }
            if let spotify = dict[Key.spotify] {
                self.spotify = spotify
            }
        }
    }
}
fileprivate class GameExtension: Codable  {
    var name: String?
    var score: Score = Score()
    var gamePoints: Int = 0
    var shopPoints: Int = 0
    var accessKeys: Int = 0
    init(dict: [String: Any]) {
        if let name = dict[Key.name] as? String {
            self.name = name
        }
        if let gamePoints = dict[Key.gamePoints] as? Int {
            score.gamePoints = gamePoints
        }
        if let shopPoints = dict[Key.shopPoints] as? Int {
            score.shopPoints = shopPoints
        }
        if let keys = dict[Key.accessKeys] as? Int {
            accessKeys = keys
        }
    }
}
public struct Score: Codable {
    var gamePoints: Int = 0
    var shopPoints: Int = 0
}
/* for further use of info received at login (Sounders)
 fileprivate class ArtistExtension: Codable {

 let name: String
 let country_id: Int
 let signed: Int
 let contact_with: [String]
 let bio: String
 let gender: String
 let birthday: String
 let profile_photo_url: String
 let phone: String
 let account_country_id: Int
 let account_city: String
 let account_street: String
 let personal_website: String?
 let facebook_url: String?
 let instagram_url: String?
 let youtube_url: String?
 let spotify_url: String?
 let twitter_url: String?
 let confirmed_legal: Int

 init?(dict: [String: Any]) {
 //FIXME: need actual initialization code
 return nil
 }
 }
 */
