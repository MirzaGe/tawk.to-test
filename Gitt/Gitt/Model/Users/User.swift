//
//  User+CoreDataClass.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/18/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var createdAt: String?
    @NSManaged public var location: String?
    @NSManaged public var id: Int32
    @NSManaged public var htmlUrl: String?
    @NSManaged public var hireable: Bool
    @NSManaged public var gravatarId: String?
    @NSManaged public var gistsUrl: String?
    @NSManaged public var followingUrl: String?
    @NSManaged public var following: Int32
    @NSManaged public var followersUrl: String?
    @NSManaged public var followers: Int32
    @NSManaged public var eventsUrl: String?
    @NSManaged public var email: String?
    @NSManaged public var company: String?
    @NSManaged public var blog: String?
    @NSManaged public var bio: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var nodeId: String?
    @NSManaged public var organizationsUrl: String?
    @NSManaged public var publicGists: Int32
    @NSManaged public var publicRepos: Int32
    @NSManaged public var receivedEventsUrl: String?
    @NSManaged public var reposUrl: String?
    @NSManaged public var siteAdmin: Bool
    @NSManaged public var starredUrl: String?
    @NSManaged public var subscriptionsUrl: String?
    @NSManaged public var type: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var login: String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case bio = "bio"
        case blog = "blog"
        case company = "company"
        case createdAt = "created_at"
        case email = "email"
        case eventsUrl = "events_url"
        case followers = "followers"
        case followersUrl = "followers_url"
        case following = "following"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case gravatarId = "gravatar_id"
        case hireable = "hireable"
        case htmlUrl = "html_url"
        case id = "id"
        case location = "location"
        case login = "login"
        case name = "name"
        case nodeId = "node_id"
        case organizationsUrl = "organizations_url"
        case publicGists = "public_gists"
        case publicRepos = "public_repos"
        case receivedEventsUrl = "received_events_url"
        case reposUrl = "repos_url"
        case siteAdmin = "site_admin"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case type = "type"
        case updatedAt = "updated_at"
        case url = "url"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        blog = try values.decodeIfPresent(String.self, forKey: .blog)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        followers = try values.decodeIfPresent(Int32.self, forKey: .followers) ?? 0
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
        following = try values.decodeIfPresent(Int32.self, forKey: .following) ?? 0
        followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        gistsUrl = try values.decodeIfPresent(String.self, forKey: .gistsUrl)
        gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
        hireable = try values.decodeIfPresent(Bool.self, forKey: .hireable) ?? false
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        id = try values.decodeIfPresent(Int32.self, forKey: .id) ?? 0
        location = try values.decodeIfPresent(String.self, forKey: .location)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
        organizationsUrl = try values.decodeIfPresent(String.self, forKey: .organizationsUrl)
        publicGists = try values.decodeIfPresent(Int32.self, forKey: .publicGists) ?? 0
        publicRepos = try values.decodeIfPresent(Int32.self, forKey: .publicRepos) ?? 0
        receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        reposUrl = try values.decodeIfPresent(String.self, forKey: .reposUrl)
        siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
        starredUrl = try values.decodeIfPresent(String.self, forKey: .starredUrl)
        subscriptionsUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(bio, forKey: .bio)
        try container.encode(blog, forKey: .blog)
        try container.encode(company, forKey: .company)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(email, forKey: .email)
        try container.encode(eventsUrl, forKey: .eventsUrl)
        try container.encode(followers, forKey: .followers)
        try container.encode(followersUrl, forKey: .followersUrl)
        try container.encode(following, forKey: .following)
        try container.encode(followingUrl, forKey: .followingUrl)
        try container.encode(gistsUrl, forKey: .gistsUrl)
        try container.encode(gravatarId, forKey: .gravatarId)
        try container.encode(hireable, forKey: .hireable)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(id, forKey: .id)
        try container.encode(location, forKey: .location)
        try container.encode(login, forKey: .login)
        try container.encode(name, forKey: .name)
        try container.encode(nodeId, forKey: .nodeId)
        try container.encode(organizationsUrl, forKey: .organizationsUrl)
        try container.encode(publicGists, forKey: .publicGists)
        try container.encode(publicRepos, forKey: .publicRepos)
        try container.encode(receivedEventsUrl, forKey: .receivedEventsUrl)
        try container.encode(reposUrl, forKey: .reposUrl)
        try container.encode(siteAdmin, forKey: .siteAdmin)
        try container.encode(starredUrl, forKey: .starredUrl)
        try container.encode(subscriptionsUrl, forKey: .subscriptionsUrl)
        try container.encode(type, forKey: .type)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(url, forKey: .url)
    }
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
