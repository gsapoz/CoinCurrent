//
//  ViewController.swift
//  nancee
//
//  Created by Gary Sapozhnikov on 12/3/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

import UIKit
//
//let price_array = defaults.stringArray(forKey: "coinPrices") ?? [String]()
//let usercurrency : String = defaults.object(forKey: "currency") as! String

let defaults = UserDefaults.standard

let icons : [UIImage] = [#imageLiteral(resourceName: "bitcoin_icon"), #imageLiteral(resourceName: "ether_icon"), #imageLiteral(resourceName: "ltc_icon")]
let bgcolors : [UIColor] = [UIColor.btc, UIColor.eth, UIColor.ltc]
let tickers : [String] = ["BTC", "ETH", "LTC"]
let stnames : [String] = ["Bitcoin (BTC)","Ethereum (ETH)","Litecoin (LTC)"]
var stprices : [String] = ["0", "0", "0"]

var buttonPressed = 0
var rowSelected = 2

class UserConsoleVC : UIViewController{

    let apiURL = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD")
    lazy var etherValue : String = String()

    var tableView : UITableView!
    //let socialMediaIcons : [UIImage] = [#imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "instagram")]
//    let icons : [UIImage] = [#imageLiteral(resourceName: "bitcoin_icon"), #imageLiteral(resourceName: "ether_icon"), #imageLiteral(resourceName: "ltc_icon")]
//    let bgcolors : [UIColor] = [UIColor.btc, UIColor.eth, UIColor.ltc]
//    //let stprices : [String] = ["$11,409.00", "$465.00", "$101.43"]
//    let tickers : [String] = ["BTC", "ETH", "LTC"]
//    let stnames : [String] = ["Bitcoin (BTC)","Ethereum (ETH)","Litecoin (LTC)"]
//    var stprices : [String] = ["0", "0", "0"]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
 
        guard let apiURL = apiURL else {
            return
        }
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        tableView.register(UINib(nibName: "PricePortalCell", bundle:nil), forCellReuseIdentifier: "portalCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        
//        DispatchQueue.main.async {
//            //setCoinPrices()
//        }
        
//        let array = defaults.stringArray(forKey: "coinPrices") ?? [String]()
        //stprices = price_array
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    private func makeValueGETRequest(url: URL, completion: @escaping (_ value: NSNumber?) -> Void) {
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let value = json["USD"] as? NSNumber else {
                        completion(nil)
                        return
                }
                completion(value)
            } catch  {
                completion(nil)
                print(error.localizedDescription)
            }
        }
        request.resume()
    }
    
    private func formatAsCurrencyString(value: NSNumber?) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        // TODO: Unwrap the number as a formatted currency String
        guard let value = value,
            let formattedCurrencyAmount = formatter.string(from: value) else {
                return nil
        }
        return formattedCurrencyAmount
    }
    
    @objc func openSettings(_ sender: UIButton){
        buttonPressed = sender.tag
        self.performSegue(withIdentifier: "ToNotifications", sender: nil)
    }


}

extension UserConsoleVC : UITableViewDataSource, UITableViewDelegate{

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row{
        case 0:
            return 20.0
        case 4:
            return 100.0
        default:
            return 260.0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            return cell!
        default:
            let usercurrency : String = defaults.object(forKey: "currency") as! String
            let btcurl = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=" + usercurrency)!
            let ethurl = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=" + usercurrency)!
            let ltcurl = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=" + usercurrency)!
            let urls : [URL] = [btcurl, ethurl, ltcurl]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "portalCell", for: indexPath) as! PricePortalCell
            cell.selectionStyle = .none
            cell.stockIcon.image =  icons[indexPath.row - 1]
            cell.backgroundImg.backgroundColor = bgcolors[indexPath.row - 1]
            
            cell.stockName.text = stnames[indexPath.row - 1]
            
            cell.stockPrice.addTarget(self, action:#selector(openSettings), for: .touchUpInside)
            
            cell.stockPrice.tag = indexPath.row
            
            makeValueGETRequest(url: urls[indexPath.row - 1]) { (value) in
                DispatchQueue.main.async {
                    //self.etherValueLabel.text = self.formatAsCurrencyString(value: value) ?? "Failed"
                    let nvalue = self.formatAsCurrencyString(value: value) ?? "Failed"
                    cell.stockPrice.setTitle(nvalue, for: .normal)
                    
                    stprices[indexPath.row - 1] = nvalue
                }
            }
            
            
            return cell
            
        }

    }

}



class PricePortalCell: UITableViewCell {
    @IBOutlet weak var stockIcon: UIImageView!
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var backgroundImg: UIView!
    @IBOutlet weak var stockPrice: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



//    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 20))

//lazy var searchBar : UISearchBar = UISearchBar()


//searchBar.sizeToFit()
//        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10))
//
//        searchBar.sizeThatFits(CGSize(width: 200, height: 44))
//        searchBar.barStyle = .blackTranslucent
//        searchBar.placeholder = "Search Stocks and Cryptocurrencies"
//        searchBar.setTextColor(color: .white)
//        searchBar.setPlaceholderTextColor(color: .white)
//        searchBar.setSearchImageColor(color: .white)
//        searchBar.setTextFieldClearButtonColor(color: .white)
//        navigationItem.titleView = searchBar
