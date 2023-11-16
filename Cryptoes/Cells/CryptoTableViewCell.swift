//
//  CryptoTableViewCell.swift
//  Cryptoes
//
//  Created by Himanshu on 15/11/23.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cryptoSymbolLabel: UILabel!
    @IBOutlet weak var cryptoIconImage: UIImageView!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var dayGraphImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI(){
        cryptoSymbolLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
//        cryptoSymbolLabel.font = UIFont(name: "Inter-SemiBold", size: 18)
        
        cryptoNameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        cryptoNameLabel.font = UIFont(name: "Inter-Medium", size: 13)
        
        priceLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
//        priceLabel.font = UIFont(name: "Inter-SemiBold", size: 16)
        
        percentageLabel.textColor = UIColor(red: 0, green: 0.809, blue: 0.032, alpha: 1)
//        percentageLabel.font = UIFont(name: "Inter-Medium", size: 13)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
