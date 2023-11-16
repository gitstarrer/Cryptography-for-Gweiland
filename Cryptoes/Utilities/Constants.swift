//
//  Constants.swift
//  Cryptoes
//
//  Created by Himanshu on 16/11/23.
//

import Foundation

extension String{
    
    static let searchCryptoText = "Search Cryptocurrency"
    
    static let cryptoTableViewCellIdentifier = "CryptoTableViewCell"
    static let filterTableViewCellIdentifier = "FilterTableViewCell"
    static let searchTableViewCellIdentifier = "SearchTableViewCell"
    
    static let interBold = "Inter-Bold"
    static let interSemiBold = "Inter-SemiBold"
    static let interMedium = "Inter-Medium"
    
    static let priceFilterString = "Price"
    static let volumeFilterString = "Volume 24 Hrs"
    static let marketCapFilterString = "Market Cap"
    
    static let redGraph = "redDayGraph"
    static let greenGraph = "greenGraph"
    
    static let cryptoDataUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    
    static let httpHeaderKey = "X-CMC_PRO_API_KEY"
    static let apiKey = "4159b29d-cc00-436d-83c5-19d9c17b04c9"
    
    static let iconsBaseUrl = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
    static let iconQueries = "?&id=1,1027,825,1839,52,5426,3408,2010,74,1958,3890,5805,1975,11419,6636,3717,2,4943,5994,1831,3957,3794"
    static let finalIconsUrl = iconsBaseUrl+iconQueries
}


