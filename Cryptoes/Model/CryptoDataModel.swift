//
//  CryptoDataModel.swift
//  Cryptoes
//
//  Created by Himanshu on 15/11/23.
//

import Foundation

struct CryptoDataModel: Codable{
    var data: [CryptoData]
}

struct CryptoData: Codable{
    var id     :  Int64
    var name   :  String
    var symbol :  String
    var quote  :  QuoteModel
}

struct QuoteModel: Codable{
    var USD: USD
}

struct USD: Codable{
    let price: Double //9283.92,
    let volume_24h: Double //7155680000,
    let volume_change_24h: Double //-0.152774,
    let percent_change_1h: Double //-0.152774,
    let percent_change_24h: Double //0.518894,
    let percent_change_7d: Double //0.986573,
    let market_cap: Double //852164659250.2758,
    let market_cap_dominance: Double //51,
    let fully_diluted_market_cap: Double //952835089431.14,
    let last_updated: String //"2018-08-09T22:53:32.000Z"
}




struct RawServerResponse : Decodable {
    enum Keys : String, CodingKey {
        case data = "data"
    }
    let data : [String:Base]
}

struct Base : Decodable {
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case logo = "logo"
    }
    let id : Int64
    let logo: String
}

extension RawServerResponse {
    enum BaseKeys : String {
        //first 20 displayed in the default list
        case btc   = "1"
        case eth   = "1027"
        case usdt  = "825"
        case bnb   = "1839"
        case xpr   = "52"
        case sol   = "5426"
        case usdc  = "3408"
        case ada   = "2010"
        case doge  = "74"
        case trx   = "1958"
        case matic = "3890"
        case avax  = "5805"
        case link  = "1975"
        case ton   = "11419"
        case dot   = "6636"
        case wbtc  = "3717"
        case ltc   = "2"
        case dai   = "4943"
        case shiba = "5994"
        case bch   = "1831"
        
        case leo   = "3957"
        case atom  = "3794"
    }

    var eth   : Base? { return data[BaseKeys.eth.rawValue] }
    var btc   : Base? { return data[BaseKeys.btc.rawValue] }
    var usdt  : Base? { return data[BaseKeys.usdt.rawValue] }
    var bnb   : Base? { return data[BaseKeys.bnb.rawValue] }
    var xpr   : Base? { return data[BaseKeys.xpr.rawValue] }
    var sol   : Base? { return data[BaseKeys.sol.rawValue] }
    var usdc  : Base? { return data[BaseKeys.usdc.rawValue] }
    var ada   : Base? { return data[BaseKeys.ada.rawValue] }
    var doge  : Base? { return data[BaseKeys.doge.rawValue] }
    var trx   : Base? { return data[BaseKeys.trx.rawValue] }
    var matic : Base? { return data[BaseKeys.matic.rawValue] }
    var avax  : Base? { return data[BaseKeys.avax.rawValue] }
    var link  : Base? { return data[BaseKeys.link.rawValue] }
    var ton   : Base? { return data[BaseKeys.ton.rawValue] }
    var dot   : Base? { return data[BaseKeys.dot.rawValue] }
    var wbtc  : Base? { return data[BaseKeys.wbtc.rawValue] }
    var ltc   : Base? { return data[BaseKeys.ltc.rawValue] }
    var dai   : Base? { return data[BaseKeys.dai.rawValue] }
    var shiba : Base? { return data[BaseKeys.shiba.rawValue] }
    var bch   : Base? { return data[BaseKeys.bch.rawValue] }
    
    var leo   : Base? { return data[BaseKeys.leo.rawValue] }
    var atom  : Base? { return data[BaseKeys.atom.rawValue] }
    
}
