//
//  ResultHelper.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import Kingfisher
import SwiftDate

/**
 The helper for `Result`. Useful for extracting presentables.
 */
extension Result {
    /// Returns the cellType based on `wrapperType` and `kind`.
    /// TODO: make enum for `wrapperType` and `kind`.
    var cellType: DataCellType {
        get {
            if self.wrapperType == "audiobook" {
                return .long
            }
            
            if self.kind == "song" {
                return .short
            }
            
            // Defaults to feature-movie and tv-episode.
            return .long
        }
    }
    
    /// Determines if we are to hide the extra label for date. Show if movies and books.
    var dateLabelIsHidden: Bool {
        self.cellType != .long
    }
    
    /// Determines if we are to hide the get button
    var getButtonIsHidden: Bool {
        return self.kind == "feature-movie" || self.kind == "tv-episode"
    }
        
    /**
    The Get button title.
    - Since we don't have much time, we can just make a couple of catchers for currency symbol.
    - Ref: https://developer.apple.com/documentation/foundation/nslocale/1642814-currencysymbol
    */
    var currencySymbol: String {
        get {
            if self.currency == "USA" {
                return "$"
            } else if self.currency == "AUD" {
                return "$"
            } else if self.currency == "PHP" {
                return "₱"
            } else {
                return "$"
            }
        }
    }
    
    // MARK: - Presentables
    
    /// The trackname presentable
    var titlePresentable: String {
        get {
            return self.trackName ?? self.collectionName ?? ""
        }
    }
    
    /**
     The subtitle presentable, usually the grayed out part.
        - For song, it's the artist + album.
        - For audiobooks, it's the author.
        - For movies and tv-epidosdes, it's the genres.
     */
    var subtitlePresentable: String {
        get {
            if self.wrapperType == "audiobook" {
                return self.artistName ?? ""
            }
            
            if self.kind == "song" {
                return "\(self.artistName ?? "") - \(self.collectionName ?? "")"
            }
            
            // Defaults to feature-movie and tv-episode.
            return self.primaryGenreName ?? ""
        }
    }
    
    /// Presentable content advisory rating.
    /// Add leading trailing spaces for margin
    var contentAdvisoryRatingPresentable: String {
        return " \(self.contentAdvisoryRating ?? "No Rating") "
    }
    
    /// Presentable long description of the track.
    var longDescriptionPresentable: String {
        return self.longDescription ?? ""
    }
    
    /// The presentable genre
    var genrePresentable: String {
        return self.primaryGenreName ?? ""
    }
    
    /// The formatted year date used in `SearchDetailsViewModel`.
    var yearPresentable: String {
        get {
            let releaseDate = (self.releaseDate ?? "").toDate()
            let format = "yyyy"
            let formattedDate = releaseDate?.toFormat(format)
            return formattedDate ?? "Release Date Unavailable"
        }
    }
    
    /// The formatted presentable date
    var datePresentable: String {
        get {
            let releaseDate = (self.releaseDate ?? "").toDate()
            let format = "MMM d, yyyy"
            let formattedDate = releaseDate?.toFormat(format)
            return formattedDate ?? "Release Date Unavailable"
        }
    }
    
    /// Get button title presentable for the data cell.
    var getButtonTitlePresentable: String {
        get {
            switch self.cellType {
            case .long: return "GET"
            case .short: return self.trackPricePresentable
            }
        }
    }
    
    /// Presentable button title for rent
    var rentButtonTitlePresentable: String {
        get {
            let rentPrice = self.trackRentalPrice ?? 0.00
            let rentPriceString = String(format:"%.2f", rentPrice)
            return "\(self.currencySymbol) \(rentPriceString) RENT"
        }
    }
    
    /// Presentable button title for buy
    var buyButtonTitlePresentable: String {
        get {
            let buyPrice = self.trackPrice ?? 0.00
            let buyPriceString = String(format:"%.2f", buyPrice)
            return "\(self.currencySymbol) \(buyPriceString) BUY"
        }
    }
    
    /// The track price. Let's just focus on the `trackPrice` for now.
    var trackPricePresentable: String {
        get {
            let trackPrice = self.trackPrice ?? 0.00
            let trackPriceString = String(format:"%.2f", trackPrice)
            return "\(self.currencySymbol) \(trackPriceString)"
        }
    }
    
    /// The artwork 200
    var artworkResource: ImageResource {
        get {
            var artworkUrlString = self.artworkUrl100 ?? self.artworkUrl60 ?? ""
            artworkUrlString = artworkUrlString.replacingOccurrences(of: "100", with: "200")
            let url = URL(string: artworkUrlString)!
            return ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
}
