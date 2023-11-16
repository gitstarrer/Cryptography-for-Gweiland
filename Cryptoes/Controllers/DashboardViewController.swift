//
//  ViewController.swift
//  Cryptoes
//
//  Created by Himanshu on 15/11/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var exchangesTextLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var filterTextLabel: UILabel!
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var miniBackgroundGraphView: UIView!
    
    @IBOutlet weak var cryptocurrencyTextLabel: UILabel!
    @IBOutlet weak var NFTTextLabel: UILabel!
    
    @IBOutlet weak var cryptoIconImageView: UIImageView!
    @IBOutlet weak var cryptoSymbolLabel: UILabel!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dayChangePercentageLabel: UILabel!
    
    
    @IBOutlet weak var topCryptocurrenciesLabel: UILabel!
    @IBOutlet weak var viewAllLabel: UILabel!
    
    @IBOutlet weak var cryptoCurrencyTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var cryptoList: CryptoDataModel?
    var topTwentyCryptoList: [CryptoData]?
    var cryptoIconList: RawServerResponse?
    var searchDisplayList = [CryptoData]()
    var filterOptions: [String] = [.priceFilterString, .volumeFilterString, .marketCapFilterString]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        loadDataOnUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundView.roundCorners(corners: .allCorners, radius: CGRectGetWidth(self.backgroundView.frame)/16.0)
        miniBackgroundGraphView.roundCorners(corners: [ .bottomLeft, .bottomRight], radius: CGRectGetWidth(self.miniBackgroundGraphView.frame)/18.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.alpha = 0.4
        self.activityIndicator.startAnimating()
    }
    
    func setupUI(){
//        setFonts()
        setFontColors()
        setupPlaceholderText()
        setupSearchTextField()
        setupAllTableViews()
    }
    
   private func setupTableViews(tableView: UITableView, isSeparatorStyleNone: Bool, identifier: String){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = isSeparatorStyleNone ? .none : .singleLine
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func setupSearchTextField(){
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTextFieldDidChange(_ textField: UITextField) {
        if filterTableView.isHidden == false{
            filterTableView.isHidden.toggle()
        }
        if let searchText = textField.text, let safeList = topTwentyCryptoList{
            searchDisplayList = safeList.filter{ $0.name.lowercased().contains( searchText.lowercased()) || $0.symbol.lowercased().contains(searchText.lowercased()) }
        }
        searchTableView.isHidden = searchDisplayList.count > 0 ? false : true
        searchTableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupAllTableViews(){
        setupTableViews(tableView: cryptoCurrencyTableView, isSeparatorStyleNone: true, identifier: .cryptoTableViewCellIdentifier)
        setupTableViews(tableView: filterTableView, isSeparatorStyleNone: false, identifier: .filterTableViewCellIdentifier)
        setupTableViews(tableView: searchTableView, isSeparatorStyleNone: false, identifier: .searchTableViewCellIdentifier)
    }
    
    private func loadDataOnUI(){
        getCryptoData()
        getCryptoImages()
    }
    
    private func setFonts(){
        exchangesTextLabel.font = UIFont(name: .interSemiBold, size: 20)
        filterTextLabel.font = UIFont(name: .interMedium, size: 13)
        cryptocurrencyTextLabel.font = UIFont(name: .interSemiBold, size: 20)
        NFTTextLabel.font = UIFont(name: .interSemiBold, size: 20)
        cryptoSymbolLabel.font = UIFont(name: .interBold, size: 18)
        cryptoNameLabel.font = UIFont(name: .interMedium, size: 13)
        priceLabel.font = UIFont(name: .interBold, size: 16)
        dayChangePercentageLabel.font = UIFont(name: .interBold, size: 13)
        topCryptocurrenciesLabel.font = UIFont(name: .interMedium, size: 18)
        viewAllLabel.font = UIFont(name: .interMedium, size: 13)
    }
    
    private func setFontColors(){
        exchangesTextLabel.textColor = UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 1)
        filterTextLabel.textColor =  UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 0.3)
        cryptocurrencyTextLabel.textColor = UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 1)
        NFTTextLabel.textColor = UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 0.3)
        cryptoSymbolLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cryptoNameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        priceLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        dayChangePercentageLabel.textColor = UIColor(red: 0, green: 0.809, blue: 0.032, alpha: 1)
        topCryptocurrenciesLabel.textColor = UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 1)
        viewAllLabel.textColor = UIColor(red: 0.043, green: 0.043, blue: 0.043, alpha: 0.5)
    }
    
    private func setupPlaceholderText(){
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.042, green: 0.042, blue: 0.042, alpha: 0.3),
//                        NSAttributedString.Key.font : UIFont(name: "Inter-Medium", size: 13)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: .searchCryptoText, attributes:attributes)
    }
    
    
    //MARK: Populate UI after fetching data
    func populateCryptoView(_ cryptoData: CryptoData?){
        if let safeCryptoData = cryptoData{
            cryptoSymbolLabel.text = safeCryptoData.symbol
            cryptoNameLabel.text = safeCryptoData.name
            priceLabel.text = "$"+String(format: "%.2f", safeCryptoData.quote.USD.price)+" USD"
            
            let percentChange = safeCryptoData.quote.USD.percent_change_24h
            dayChangePercentageLabel.text = String(format: "%.1f", percentChange)+"%"
            dayChangePercentageLabel.textColor = get24hrChangeColor(percentChange: percentChange)
            if percentChange < 0{
                backgroundView.layer.backgroundColor = UIColor(red: 0.99, green: 0.0, blue: 0.00, alpha: 0.1).cgColor
                miniBackgroundGraphView.backgroundColor = .systemRed
            }else{
                backgroundView.layer.backgroundColor = UIColor(red: 0.0, green: 0.808, blue: 0.031, alpha: 0.1).cgColor
                miniBackgroundGraphView.backgroundColor = .systemGreen
            }
            
            if let url = getCryptoImageURL(id: safeCryptoData.id){
                downloadImage(from: url, forCell: nil)
            }
        }
    }
    
    func get24hrChangeColor(percentChange: Double) -> UIColor{
        if percentChange < 0{
            return UIColor(red: 1, green: 0.24, blue: 0, alpha: 1)
        }else{
            return UIColor(red: 0, green: 0.809, blue: 0.032, alpha: 1)
        }
    }
    func get24hrGraphImage(percentChange: Double) -> UIImage{
        if percentChange < 0{
            return UIImage(named: .redGraph) ?? UIImage()
        }else{
            return UIImage(named: .greenGraph) ?? UIImage()
        }
    }
    
    
    //MARK: icon image helper functions
    func getCryptoImageURL(id: Int64) -> URL?{
        if let safeIcon = cryptoIconList?.data.values.filter({ $0.id == id}).first{
            return URL(string: safeIcon.logo)
        }
        return nil
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, forCell cell: CryptoTableViewCell) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.cryptoIconImage.image = UIImage(data: data)
            }
        }
    }
    
    func downloadImage(from url: URL, forCell cell: SearchTableViewCell?) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if let safeCell = cell{
                    safeCell.iconImage.image = UIImage(data: data)
                }else{
                    self.cryptoIconImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    //MARK: Fetch data from APIs
    func getCryptoData(){
        let url = URL(string: .cryptoDataUrl)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [.httpHeaderKey : .apiKey]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard error == nil else { return }
          guard let data = data, let _ = response else { return }
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(CryptoDataModel.self, from: data)
                self.cryptoList = json
                
                let top20List = (self.cryptoList?.data.prefix(20))?.sorted(by: {$0.quote.USD.market_cap > $1.quote.USD.market_cap})
                self.topTwentyCryptoList = top20List
                
                DispatchQueue.main.async {
                    self.cryptoCurrencyTableView.reloadData()
                    self.populateCryptoView(self.topTwentyCryptoList?[0])
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error)")
            }
        }.resume()
    }
    
    func getCryptoImages(){
        let url = URL(string: .finalIconsUrl)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [.httpHeaderKey: .apiKey]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
          guard error == nil else { return }
          guard let data = data, let _ = response else { return }
            do {
                let jsonValue = try JSONSerialization.jsonObject(with: data)
                debugPrint(jsonValue)
                
                let decoder = JSONDecoder()
                let json = try decoder.decode(RawServerResponse.self, from: data)
                self.cryptoIconList = json
                DispatchQueue.main.async {
                    self.cryptoCurrencyTableView.reloadData()
                    self.populateCryptoView(self.topTwentyCryptoList?[0])
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.view.alpha = 1
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error)")
            }
        }.resume()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        filterTableView.isHidden.toggle()
        if searchTableView.isHidden == false{
            searchTableView.isHidden.toggle()
        }
    }
}

//MARK: UITableViewDataSource
extension DashboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == filterTableView{
            return filterOptions.count
        }else if tableView == searchTableView{
            return searchDisplayList.count
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == filterTableView{
            let cell = filterTableView.dequeueReusableCell(withIdentifier: .filterTableViewCellIdentifier, for: indexPath) as! FilterTableViewCell
            cell.FilterLabel.text = filterOptions[indexPath.row]
            return cell
            
        }
        else if tableView == searchTableView{
            let cell = searchTableView.dequeueReusableCell(withIdentifier: .searchTableViewCellIdentifier, for: indexPath) as! SearchTableViewCell
            cell.symbolLabel.text = searchDisplayList[indexPath.row].symbol
            cell.nameLabel.text = searchDisplayList[indexPath.row].name
            if let url = getCryptoImageURL(id: searchDisplayList[indexPath.row].id){
                downloadImage(from: url, forCell: cell)
            }
            return cell
        }
        
        else {
            let cell = cryptoCurrencyTableView.dequeueReusableCell(withIdentifier: .cryptoTableViewCellIdentifier, for: indexPath) as! CryptoTableViewCell
            
            if let safeCryptoList = topTwentyCryptoList{
                cell.cryptoSymbolLabel.text = safeCryptoList[indexPath.row].symbol
                cell.cryptoNameLabel.text = safeCryptoList[indexPath.row].name
                cell.priceLabel.text = "$"+String(format: "%.2f", safeCryptoList[indexPath.row].quote.USD.price)+" USD"
                
                let percentChange = safeCryptoList[indexPath.row].quote.USD.percent_change_24h
                cell.percentageLabel.text = String(format: "%.1f", percentChange)+"%"
                cell.percentageLabel.textColor = get24hrChangeColor(percentChange: percentChange)
                cell.dayGraphImageView.image = get24hrGraphImage(percentChange: percentChange)
                
                if let url = getCryptoImageURL(id: safeCryptoList[indexPath.row].id){
                    downloadImage(from: url, forCell: cell)
                }else{
                    cell.cryptoIconImage.image = UIImage()
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == filterTableView{
            return 48
        }else{
            return 75
        }
    }
}

//MARK: UITableViewDelegate
extension DashboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == cryptoCurrencyTableView{
            self.populateCryptoView(self.topTwentyCryptoList?[indexPath.row])
        }
        else if tableView == searchTableView{
            self.populateCryptoView(self.searchDisplayList[indexPath.row])
            searchTableView.isHidden = true
        }
        else if tableView == filterTableView{
            switch indexPath.row{
            case 0:
               topTwentyCryptoList = topTwentyCryptoList?.sorted(by: { $0.quote.USD.price > $1.quote.USD.price})
            case 1:
                topTwentyCryptoList = topTwentyCryptoList?.sorted(by: { $0.quote.USD.volume_24h > $1.quote.USD.volume_24h})
            default:
                topTwentyCryptoList = topTwentyCryptoList?.sorted(by: { $0.quote.USD.market_cap > $1.quote.USD.market_cap})
            }
            cryptoCurrencyTableView.reloadData()
            self.populateCryptoView(self.topTwentyCryptoList?[0])
            tableView.isHidden.toggle()
            if searchTableView.isHidden == false{
                searchTableView.isHidden.toggle()
            }
        }
    }
}

//MARK: UISearchTextFieldDelegate
extension DashboardViewController: UISearchTextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTableView.isHidden = true
        if filterTableView.isHidden == false{
            filterTableView.isHidden.toggle()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = .none
    }
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

