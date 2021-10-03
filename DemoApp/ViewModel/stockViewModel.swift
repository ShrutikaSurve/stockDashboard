//
//  stockViewModel.swift
//  DemoApp
//
//  Created by Shrutika Surve on 26/09/21.
//

import Foundation

protocol StockViewModelProtocol
{
    func stockViewModelSuccess(stockArray:[Stock],lStockArray:[Stock],scStockArray: [Stock],sStockArray: [Stock],luStockArray : [Stock])
    func stockViewModelfail()
}

class stockViewModel {
    
    
    weak var vc : ViewController!
    
    var stockResponse = NSDictionary()
    public var stockViewModelProtocol :StockViewModelProtocol?
    
    func getAllStockApi(){
        URLSession.shared.dataTask(with: URL(string: "https://qapptemporary.s3.ap-south-1.amazonaws.com/test/synopsis.json")!) { [self] (data , response , error ) in
                print("API Done.")
                if let responseData = data{
                    do{
                        self.stockResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as! NSDictionary
                        print("Response-> \n\(self.stockResponse)")

                        self.getStockData()
                    }catch{
                        self.stockViewModelProtocol?.stockViewModelfail()
                        print("Exception")
                       
                    }
                }
        }.resume()
    }
    
    func getStockData() -> [Stock] {
        
        var stockArray = [Stock]()
        var lStockArray = [Stock]()
        var scStockArray = [Stock]()
        var sStockArray = [Stock]()
        var luStockArray = [Stock]()
        
        for(key,value) in stockResponse {
           
            let tempArray = "\(value)".split(separator:";")
            
            for subString in tempArray
            {
                var subArray = subString.split(separator:",")
               
                subArray.append(key as! Substring.SubSequence)
               
                print("print the subarray=======", subArray)
               
                let instance = Stock(arr: subArray)
                
                stockArray.append(instance)
                
                switch instance.stockKey {
                case "l":
                    lStockArray.append(instance)
                case "sc":
                    scStockArray.append(instance)
                case "s":
                    sStockArray.append(instance)
                case "lu":
                    luStockArray.append(instance)
                default:
                    print("nothing has to be print")
                }
                
                print("key:= \(String(describing: instance.stockKey)) title:= \(String(describing: instance.title)) title:= \(instance.value3 ?? 0.00)")
               
            }
            
           
            
            stockArray.sort(by:{ S1, S2 in
                Double(S1.value3!) > Double(S2.value3!)
            })
            
            lStockArray.sort(by:{ S1, S2 in
                Double(S1.value3!) > Double(S2.value3!)
            })
            
            scStockArray.sort(by:{ S1, S2 in
                Double(S1.value3!) > Double(S2.value3!)
            })
            
            sStockArray.sort(by:{ S1, S2 in
                Double(S1.value3!) > Double(S2.value3!)
            })
            
            luStockArray.sort(by:{ S1, S2 in
                Double(S1.value3!) > Double(S2.value3!)
            })
            
            self.stockViewModelProtocol?.stockViewModelSuccess(stockArray: stockArray, lStockArray: lStockArray, scStockArray: scStockArray, sStockArray: sStockArray, luStockArray:luStockArray)
            
           

        }
        return stockArray
    }
}
