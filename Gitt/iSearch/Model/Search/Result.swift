//
//  Result.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

struct Result: Codable {
    
    // MARK: - Properties
    
    let artistId                 : Int?
    let artistName               : String?
    let artistViewUrl            : String?
    let artworkUrl100            : String?
    let artworkUrl30             : String?
    let artworkUrl60             : String?
    let collectionArtistId       : Int?
    let collectionArtistViewUrl  : String?
    let collectionCensoredName   : String?
    let collectionExplicitness   : String?
    let collectionHdPrice        : Float?
    let collectionId             : Int?
    let collectionName           : String?
    let collectionPrice          : Float?
    let collectionViewUrl        : String?
    let contentAdvisoryRating    : String?
    let copyright                : String?
    let country                  : String?
    let currency                 : String?
    let descriptionField         : String?
    let discCount                : Int?
    let discNumber               : Int?
    let hasITunesExtras          : Bool?
    let isStreamable             : Bool?
    let kind                     : String?
    let longDescription          : String?
    let previewUrl               : String?
    let primaryGenreName         : String?
    let releaseDate              : String?
    let shortDescription         : String?
    let trackCensoredName        : String?
    let trackCount               : Int?
    let trackExplicitness        : String?
    let trackHdPrice             : Float?
    let trackHdRentalPrice       : Float?
    let trackId                  : Int?
    let trackName                : String?
    let trackNumber              : Int?
    let trackPrice               : Float?
    let trackRentalPrice         : Float?
    let trackTimeMillis          : Int?
    let trackViewUrl             : String?
    let wrapperType              : String?
    
    enum CodingKeys: String, CodingKey {
        case artistId                    = "artistId"
        case artistName                  = "artistName"
        case artistViewUrl               = "artistViewUrl"
        case artworkUrl100               = "artworkUrl100"
        case artworkUrl30                = "artworkUrl30"
        case artworkUrl60                = "artworkUrl60"
        case collectionArtistId          = "collectionArtistId"
        case collectionArtistViewUrl     = "collectionArtistViewUrl"
        case collectionCensoredName      = "collectionCensoredName"
        case collectionExplicitness      = "collectionExplicitness"
        case collectionHdPrice           = "collectionHdPrice"
        case collectionId                = "collectionId"
        case collectionName              = "collectionName"
        case collectionPrice             = "collectionPrice"
        case collectionViewUrl           = "collectionViewUrl"
        case contentAdvisoryRating       = "contentAdvisoryRating"
        case copyright                   = "copyright"
        case country                     = "country"
        case currency                    = "currency"
        case descriptionField            = "description"
        case discCount                   = "discCount"
        case discNumber                  = "discNumber"
        case hasITunesExtras             = "hasITunesExtras"
        case isStreamable                = "isStreamable"
        case kind                        = "kind"
        case longDescription             = "longDescription"
        case previewUrl                  = "previewUrl"
        case primaryGenreName            = "primaryGenreName"
        case releaseDate                 = "releaseDate"
        case shortDescription            = "shortDescription"
        case trackCensoredName           = "trackCensoredName"
        case trackCount                  = "trackCount"
        case trackExplicitness           = "trackExplicitness"
        case trackHdPrice                = "trackHdPrice"
        case trackHdRentalPrice          = "trackHdRentalPrice"
        case trackId                     = "trackId"
        case trackName                   = "trackName"
        case trackNumber                 = "trackNumber"
        case trackPrice                  = "trackPrice"
        case trackRentalPrice            = "trackRentalPrice"
        case trackTimeMillis             = "trackTimeMillis"
        case trackViewUrl                = "trackViewUrl"
        case wrapperType                 = "wrapperType"
    }
    
    // MARK: - Functions
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        artworkUrl30 = try values.decodeIfPresent(String.self, forKey: .artworkUrl30)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        collectionArtistId = try values.decodeIfPresent(Int.self, forKey: .collectionArtistId)
        collectionArtistViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionArtistViewUrl)
        collectionCensoredName = try values.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        collectionExplicitness = try values.decodeIfPresent(String.self, forKey: .collectionExplicitness)
        collectionHdPrice = try values.decodeIfPresent(Float.self, forKey: .collectionHdPrice)
        collectionId = try values.decodeIfPresent(Int.self, forKey: .collectionId)
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
        collectionPrice = try values.decodeIfPresent(Float.self, forKey: .collectionPrice)
        collectionViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionViewUrl)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        discCount = try values.decodeIfPresent(Int.self, forKey: .discCount)
        discNumber = try values.decodeIfPresent(Int.self, forKey: .discNumber)
        hasITunesExtras = try values.decodeIfPresent(Bool.self, forKey: .hasITunesExtras)
        isStreamable = try values.decodeIfPresent(Bool.self, forKey: .isStreamable)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        previewUrl = try values.decodeIfPresent(String.self, forKey: .previewUrl)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        trackCount = try values.decodeIfPresent(Int.self, forKey: .trackCount)
        trackExplicitness = try values.decodeIfPresent(String.self, forKey: .trackExplicitness)
        trackHdPrice = try values.decodeIfPresent(Float.self, forKey: .trackHdPrice)
        trackHdRentalPrice = try values.decodeIfPresent(Float.self, forKey: .trackHdRentalPrice)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        trackNumber = try values.decodeIfPresent(Int.self, forKey: .trackNumber)
        trackPrice = try values.decodeIfPresent(Float.self, forKey: .trackPrice)
        trackRentalPrice = try values.decodeIfPresent(Float.self, forKey: .trackRentalPrice)
        trackTimeMillis = try values.decodeIfPresent(Int.self, forKey: .trackTimeMillis)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
    }
    
}
