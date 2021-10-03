//
//  ViewController.swift
//  DemoApp
//
//  Created by Shrutika Surve on 26/09/21.
//

import UIKit

class ViewController: UIViewController,StockViewModelProtocol, UISearchBarDelegate, UISearchControllerDelegate {
    
    
    var stockModelData = stockViewModel()
    
    var btTag = 0
    
    @IBOutlet weak var stockCollectionView: UICollectionView!
    
   
    var stockArray = [Stock]()
    
    var lStockArray = [Stock]()
    var scStockArray = [Stock]()
    var sStockArray = [Stock]()
    var luStockArray = [Stock]()
    
    var searchData = [Stock]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockCollectionView.delegate = self
       self.stockCollectionView.dataSource = self
        
        searchBarSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.stockModelData.stockViewModelProtocol = self
        self.stockModelData.getAllStockApi()
        
        
    
        
    }
    
    private func searchBarSetup() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    
    @IBAction func onStockCategoryClick(_ sender: Any) {
        
        switch (sender as AnyObject).tag {
        case 0:
            btTag = 0
            self.stockCollectionView.reloadData()
        case 1:
            btTag = 1
            self.stockCollectionView.reloadData()
        case 2:
            btTag = 2
            self.stockCollectionView.reloadData()
        case 3:
            btTag = 3
            self.stockCollectionView.reloadData()
        case 4:
            btTag = 4
            self.stockCollectionView.reloadData()
        default:
            print("Nothing to perform")
        }
    }
    func stockViewModelSuccess(stockArray:[Stock],lStockArray:[Stock],scStockArray: [Stock],sStockArray: [Stock],luStockArray : [Stock]) {
        self.stockArray = stockArray
        self.luStockArray = luStockArray
        self.sStockArray = sStockArray
        self.lStockArray = lStockArray
        self.scStockArray = scStockArray
        
        DispatchQueue.main.async {
            self.stockCollectionView.reloadData()
        }
        
    }
    
    func stockViewModelfail() {
        print("fail")
    }

}


extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return }
        
        if(searchText == "") {
            btTag = 0
        }else {
            searchData = stockArray
            searchData = searchData.filter{$0.title!.contains(searchText.uppercased())}
            btTag = 5
           
    }
        self.stockCollectionView.reloadData()
    }
}


extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch btTag {
        case 0:
            return stockArray.count
        case 1:
            return lStockArray.count
        case 2:
             return scStockArray.count
        case 3:
            return sStockArray.count
        case 4:
            return luStockArray.count
        default:
             return searchData.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! stockCollectionViewCell
        
        switch btTag {
            
        case 0 :
            cell.stockName.text = stockArray[indexPath.row].title!

            cell.stockPercentage.text = String(format:"%.3f",stockArray[indexPath.row].value3!) + "%"
            
            switch  stockArray[indexPath.row].stockKey! {
            case "l":
                cell.backgroundColor = UIColor.systemGreen
            case "sc":
                cell.backgroundColor = UIColor.systemYellow
            case "s":
                cell.backgroundColor = UIColor.systemRed
            case "lu":
                cell.backgroundColor = UIColor.systemTeal
            default:
                print("nothing to color")
            }
            
        case 1:
            cell.stockName.text = lStockArray[indexPath.row].title!
            cell.stockPercentage.text = String(format:"%.3f",lStockArray[indexPath.row].value3!) + "%"
            cell.backgroundColor = UIColor.systemGreen
           
        case 2:
            cell.stockName.text = scStockArray[indexPath.row].title!
            cell.stockPercentage.text = String(format:"%.3f",scStockArray[indexPath.row].value3!) + "%"
            cell.backgroundColor = UIColor.systemYellow
           
        case 3:
            cell.stockName.text = sStockArray[indexPath.row].title!
            cell.stockPercentage.text = String(format:"%.3f",sStockArray[indexPath.row].value3!) + "%"
            cell.backgroundColor = UIColor.systemRed
        case 4:
            cell.stockName.text = luStockArray[indexPath.row].title!
            cell.stockPercentage.text = String(format:"%.3f",luStockArray[indexPath.row].value3!) + "%"
            cell.backgroundColor = UIColor.systemTeal
        default:
            
            cell.stockName.text = searchData[indexPath.row].title!

            cell.stockPercentage.text = String(format:"%.3f",searchData[indexPath.row].value3!) + "%"
            
            switch  stockArray[indexPath.row].stockKey! {
            case "l":
                cell.backgroundColor = UIColor.systemGreen
            case "sc":
                cell.backgroundColor = UIColor.systemYellow
            case "s":
                cell.backgroundColor = UIColor.systemRed
            case "lu":
                cell.backgroundColor = UIColor.systemTeal
            default:
                print("nothing to color")
            }
        }
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1

            return cell

        
    }
    
   
}

extension ViewController : UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: (stockCollectionView.bounds.size.width / 4) - 1,height: stockCollectionView.bounds.size.height / 6)
       }
}


